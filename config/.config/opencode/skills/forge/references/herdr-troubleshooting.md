# Forge: Herdr Failures

Load only for startup, auth, model, hook, permission, timeout, or output failures.
Follow current `herdr --skill` and installed help.

- Inspect blocked UI; follow Herdr's approval instructions. Never approve for the
  user. A timeout does not prove non-delivery: inspect the named agent before
  resending.
- Startup/readiness proves neither correct model nor completed review. Check
  terminal model display as well as replies. Correct alias mismatches with a
  verified native ID; report unavailable models without silent substitution.
- Read verdict via `agent read --source recent-unwrapped`; try a larger read,
  then Herdr's documented temporary-file fallback if needed.
- Do not reinstall integrations, upgrade Herdr, stop its server, or change global
  config to unblock review without permission.
- Integration status may say current despite stale hooks. Inspect only relevant
  hook entries, never whole credential-bearing configs/environment files.
- Reinstallation can leave duplicate absolute-path hooks. Portable macOS/Linux
  command, if repair is authorized:
  ```json
  "command": "bash \"$HOME/.claude/hooks/herdr-agent-state.sh\" session"
  ```
  Preserve each entry's argument; single-quoted `$HOME` will not expand. Preserve
  dotfiles links/unrelated settings, validate JSON, and run a real Claude smoke
  test after repair.
- Report failures, recovery, missing review coverage, and remaining user action
  explicitly. Never substitute process startup for a review verdict.
