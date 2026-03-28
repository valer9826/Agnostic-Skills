#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

usage() {
  cat <<'USAGE'
Install portable AI skills into local agent environments.

Usage:
  install-skills.sh [options]

Options:
  --env <name>              Preset destination: codex | claude-code | cursor | antigravity
  --target <dir>            Explicit destination directory (overrides --env)
  --source <dir>            Local directory containing skills (default: <repo>/skills)
  --from-repo <url>         Clone and install skills from external git repo
  --repo-ref <ref>          Branch/tag/commit for the previous --from-repo (default: default branch)
  --repo-subdir <path>      Skills folder inside cloned repo (default: skills)
  --skill <name>            Install only this skill (repeatable)
  --list-only               Print discovered skills and exit
  --dry-run                 Show operations without copying files
  -h, --help                Show this help

Environment overrides for presets:
  CODEX_HOME, CLAUDE_CODE_SKILLS_DIR, CURSOR_SKILLS_DIR, ANTIGRAVITY_SKILLS_DIR

Examples:
  # Install this repo's skills into Codex default location
  ./scripts/install-skills.sh --env codex

  # Install selected skills into Cursor
  ./scripts/install-skills.sh --env cursor --skill skills-index --skill nlm-skill

  # Pull skills from another repo and install in Claude Code
  ./scripts/install-skills.sh --env claude-code \
    --from-repo https://github.com/acme/agent-skills.git --repo-ref main --repo-subdir skills
USAGE
}

log() { printf '[install-skills] %s\n' "$*"; }
err() { printf '[install-skills] ERROR: %s\n' "$*" >&2; exit 1; }

ENV_NAME=""
TARGET_DIR=""
DRY_RUN=0
LIST_ONLY=0

SOURCE_DIRS=()
SELECTED_SKILLS=()

REPO_URLS=()
REPO_REFS=()
REPO_SUBDIRS=()

pending_repo_idx=-1

resolve_target_from_env() {
  case "$1" in
    codex)
      printf '%s/skills' "${CODEX_HOME:-$HOME/.codex}"
      ;;
    claude-code)
      printf '%s' "${CLAUDE_CODE_SKILLS_DIR:-$HOME/.claude/skills}"
      ;;
    cursor)
      printf '%s' "${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"
      ;;
    antigravity)
      printf '%s' "${ANTIGRAVITY_SKILLS_DIR:-$HOME/.antigravity/skills}"
      ;;
    *)
      err "Unknown --env '$1'. Use codex|claude-code|cursor|antigravity or pass --target."
      ;;
  esac
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --env)
      [[ $# -ge 2 ]] || err "Missing value for --env"
      ENV_NAME="$2"
      shift 2
      ;;
    --target)
      [[ $# -ge 2 ]] || err "Missing value for --target"
      TARGET_DIR="$2"
      shift 2
      ;;
    --source)
      [[ $# -ge 2 ]] || err "Missing value for --source"
      SOURCE_DIRS+=("$2")
      shift 2
      ;;
    --from-repo)
      [[ $# -ge 2 ]] || err "Missing value for --from-repo"
      REPO_URLS+=("$2")
      REPO_REFS+=("")
      REPO_SUBDIRS+=("skills")
      pending_repo_idx=$(( ${#REPO_URLS[@]} - 1 ))
      shift 2
      ;;
    --repo-ref)
      [[ $# -ge 2 ]] || err "Missing value for --repo-ref"
      [[ $pending_repo_idx -ge 0 ]] || err "--repo-ref must appear after --from-repo"
      REPO_REFS[$pending_repo_idx]="$2"
      shift 2
      ;;
    --repo-subdir)
      [[ $# -ge 2 ]] || err "Missing value for --repo-subdir"
      [[ $pending_repo_idx -ge 0 ]] || err "--repo-subdir must appear after --from-repo"
      REPO_SUBDIRS[$pending_repo_idx]="$2"
      shift 2
      ;;
    --skill)
      [[ $# -ge 2 ]] || err "Missing value for --skill"
      SELECTED_SKILLS+=("$2")
      shift 2
      ;;
    --list-only)
      LIST_ONLY=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      err "Unknown argument: $1"
      ;;
  esac
done

if [[ ${#SOURCE_DIRS[@]} -eq 0 ]]; then
  SOURCE_DIRS+=("${REPO_ROOT}/skills")
fi

if [[ -z "$TARGET_DIR" ]]; then
  if [[ -n "$ENV_NAME" ]]; then
    TARGET_DIR="$(resolve_target_from_env "$ENV_NAME")"
  elif [[ "$LIST_ONLY" -eq 0 ]]; then
    err "Provide --target or --env"
  fi
fi

TMP_ROOT=""
cleanup() {
  if [[ -n "$TMP_ROOT" && -d "$TMP_ROOT" ]]; then
    rm -rf "$TMP_ROOT"
  fi
}
trap cleanup EXIT

if [[ ${#REPO_URLS[@]} -gt 0 ]]; then
  TMP_ROOT="$(mktemp -d)"
  for i in "${!REPO_URLS[@]}"; do
    repo_url="${REPO_URLS[$i]}"
    repo_ref="${REPO_REFS[$i]}"
    repo_subdir="${REPO_SUBDIRS[$i]}"

    repo_dir="${TMP_ROOT}/repo-${i}"

    if [[ -n "$repo_ref" ]]; then
      log "Cloning ${repo_url} (ref=${repo_ref})"
      git clone --depth 1 --branch "$repo_ref" "$repo_url" "$repo_dir" >/dev/null
    else
      log "Cloning ${repo_url}"
      git clone --depth 1 "$repo_url" "$repo_dir" >/dev/null
    fi

    source_candidate="${repo_dir}/${repo_subdir}"
    [[ -d "$source_candidate" ]] || err "Skills directory not found in repo: ${source_candidate}"
    SOURCE_DIRS+=("$source_candidate")
  done
fi

discover_skills() {
  local source_dir="$1"
  [[ -d "$source_dir" ]] || err "Source directory does not exist: $source_dir"

  find "$source_dir" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r skill_dir; do
    if [[ -f "$skill_dir/SKILL.md" ]]; then
      printf '%s\n' "$(basename "$skill_dir")|$skill_dir"
    fi
  done
}

is_selected() {
  local skill_name="$1"
  if [[ ${#SELECTED_SKILLS[@]} -eq 0 ]]; then
    return 0
  fi

  local selected
  for selected in "${SELECTED_SKILLS[@]}"; do
    if [[ "$selected" == "$skill_name" ]]; then
      return 0
    fi
  done
  return 1
}

copy_skill() {
  local src="$1"
  local dst="$2"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "[dry-run] copy $src -> $dst"
    return 0
  fi

  rm -rf "$dst"

  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$src/" "$dst/"
  else
    mkdir -p "$dst"
    cp -R "$src/." "$dst/"
  fi
}

skills_to_install=()
for source_dir in "${SOURCE_DIRS[@]}"; do
  while IFS= read -r line; do
    skill_name="${line%%|*}"
    skill_path="${line#*|}"

    if is_selected "$skill_name"; then
      skills_to_install+=("$skill_name|$skill_path")
    fi
  done < <(discover_skills "$source_dir")
done

if [[ "$LIST_ONLY" -eq 1 ]]; then
  if [[ ${#skills_to_install[@]} -eq 0 ]]; then
    log "No matching skills found"
    exit 0
  fi
  printf '%s\n' "Available skills:"
  for item in "${skills_to_install[@]}"; do
    printf '  - %s\n' "${item%%|*}"
  done
  exit 0
fi

[[ -n "$TARGET_DIR" ]] || err "Unable to resolve target directory"

if [[ "$DRY_RUN" -eq 0 ]]; then
  mkdir -p "$TARGET_DIR"
fi

if [[ ${#skills_to_install[@]} -eq 0 ]]; then
  err "No skills matched the selection"
fi

installed_count=0
for item in "${skills_to_install[@]}"; do
  skill_name="${item%%|*}"
  skill_path="${item#*|}"
  destination="${TARGET_DIR}/${skill_name}"

  copy_skill "$skill_path" "$destination"
  installed_count=$((installed_count + 1))
  log "Installed ${skill_name} -> ${destination}"
done

log "Done. Installed ${installed_count} skill(s) into ${TARGET_DIR}"
