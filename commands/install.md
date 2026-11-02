---
description: Add the brutally honest advisor prompt to this project's CLAUDE.md or AGENTS.md
argument-hint: "[improved|original|remove]"
allowed-tools: Bash(bash:*)
---
!`bash "${CLAUDE_PLUGIN_ROOT}/scripts/install.sh" $ARGUMENTS`

Report the line above to the user in one sentence. If it was installed, tell them it takes effect in the next session (or after `/clear`).
