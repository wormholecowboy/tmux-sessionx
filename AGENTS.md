# AGENTS.md

## Project Overview
tmux-sessionx is a tmux plugin written in Bash for fuzzy session management with fzf.

## Build/Test/Lint Commands
- **Build (Nix):** `nix build`
- **Install:** Use TPM (Tmux Plugin Manager) - add to tmux.conf and run prefix + I
- **No test framework** - manual testing via tmux
- **Lint (optional):** `shellcheck scripts/*.sh sessionx.tmux`

## Code Style Guidelines
- **Shebang:** Always use `#!/usr/bin/env bash`
- **Indentation:** Tabs, not spaces
- **Variables:** `UPPER_SNAKE_CASE` for constants/exports, `lower_snake_case` for locals
- **Functions:** `lower_snake_case` (hyphens allowed for feature functions like `is_fzf-marks_enabled`)
- **Quoting:** Always quote variables: `"$var"` not `$var`
- **Conditionals:** Prefer `[[ ]]` over `[ ]` for string comparisons
- **Error handling:** Use `2>/dev/null` for optional commands, `exit 0` for early returns
- **Comments:** Sparse; only for non-obvious logic

## File Structure
- `sessionx.tmux` - Main entry point, sources helper scripts
- `scripts/` - Helper scripts (reload_sessions.sh, sessionx.sh, fzf-marks.sh, tmuxinator.sh)
- `flake.nix` - Nix build configuration
