#!/usr/bin/env bash
# Usage: install.sh [improved|original|remove]
# Writes the advisor prompt into CLAUDE.md, else AGENTS.md, else AGENT.md, else creates CLAUDE.md.
# Re-running replaces the previous block, so it is safe to switch variants.
set -euo pipefail
variant="${1:-improved}"
prompts="$(cd "$(dirname "$0")/../prompts" && pwd)"
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

target=CLAUDE.md
for f in CLAUDE.md AGENTS.md AGENT.md; do [ -f "$f" ] && { target=$f; break; }; done

begin='<!-- brutal-mirror:begin -->'
end='<!-- brutal-mirror:end -->'
[ -f "$target" ] && sed -i.bak "/$begin/,/$end/d" "$target" && rm -f "$target.bak"

if [ "$variant" = remove ]; then echo "Removed advisor prompt from $PWD/$target"; exit 0; fi
src="$prompts/$variant.md"
[ -f "$src" ] || { echo "Unknown variant '$variant'. Use: improved | original | remove" >&2; exit 1; }

{ [ -s "$target" ] && [ -n "$(tail -n1 "$target")" ] && echo; echo "$begin"; cat "$src"; echo "$end"; } >> "$target"
echo "Installed '$variant' advisor prompt into $PWD/$target"
