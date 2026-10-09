#!/bin/sh
set -eu

package_root=$(
  CDPATH= cd -- "$(dirname -- "$0")" >/dev/null 2>&1
  pwd
)

if [ ! -f "$package_root/LOCAL_RUNTIME_MANIFEST.json" ] ||
  [ ! -x "$package_root/bin/china-legal-local" ]; then
  printf '%s\n' \
    "This installer must be run from a complete platform release package." >&2
  exit 1
fi

version=$(sed -n 's/^[[:space:]]*"version": "\([^"]*\)",[[:space:]]*$/\1/p' "$package_root/LOCAL_RUNTIME_MANIFEST.json")
target_id=$(sed -n 's/^[[:space:]]*"target": "\([^"]*\)",[[:space:]]*$/\1/p' "$package_root/LOCAL_RUNTIME_MANIFEST.json")
if [ -z "$version" ] || [ -z "$target_id" ]; then
  printf '%s\n' "LOCAL_RUNTIME_MANIFEST.json is invalid." >&2
  exit 1
fi
install_base=${CNLAW_LOCAL_INSTALL_DIR:-"${XDG_DATA_HOME:-"$HOME/.local/share"}/china-legal-assistant"}
install_target="$install_base/releases/v$version-$target_id"
bin_directory=${CNLAW_LOCAL_BIN_DIR:-"$HOME/.local/bin"}
temporary_target="$install_target.tmp.$$"

if [ ! -f "$package_root/skills/china-legal-assistant/SKILL.md" ]; then
  printf '%s\n' "The release package does not contain china-legal-assistant Skill." >&2
  exit 1
fi

cleanup() {
  rm -rf -- "$temporary_target"
}
trap cleanup EXIT HUP INT TERM

mkdir -p -- "$install_base/releases" "$bin_directory"
mkdir -p -- "$temporary_target"
cp -R "$package_root/." "$temporary_target/"
rm -rf -- "$install_target"
mv -- "$temporary_target" "$install_target"
ln -sfn -- "$install_target/bin/china-legal-local" "$bin_directory/china-legal-local"
trap - EXIT HUP INT TERM

for client_root in \
  "$HOME/.trae/skills" \
  "$HOME/.codex/skills" \
  "$HOME/.claude/skills" \
  "$HOME/.opencode/skills"
do
  destination="$client_root/china-legal-assistant"
  skill_temporary="$destination.tmp.$$"
  rm -rf -- "$skill_temporary"
  mkdir -p -- "$client_root"
  cp -R "$install_target/skills/china-legal-assistant" "$skill_temporary"
  rm -rf -- "$destination"
  mv -- "$skill_temporary" "$destination"
done

printf '%s\n' "Installed china-legal-local v$version."
printf '%s\n' "Installed china-legal-assistant Skill for four supported clients."
printf '%s\n' "Command: $bin_directory/china-legal-local"
