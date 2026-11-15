---
name: Forge
description: "Use for implementation with the forge agent, @forge, or an explicit Sol + Astra + Claude/Herdr workflow request. Not for ordinary coding in other agents."
---

# Forge

Current agent coordinates → GPT-6.1 Sol subagents implement → GPT-6 Astra and
Claude Opus 5.5 (Claude Code through Herdr) review independently → fix → verify.
Honor user overrides. Resolve OpenCode model IDs with the models tool, own
provider first; verify Claude's actual version. Never guess IDs or silently
substitute models.

Delegation is authorized within task scope, repository instructions, and
permissions. Never bypass Plan restrictions; request a switch to Build.

## 1. Scope and delegate

- Read applicable instructions/code; load relevant skills; record working-tree
  status. Exclude pre-existing modified/untracked work unless explicitly in scope.
- Clarify material ambiguity; decide minor details. Assign one writer per file,
  explicit shared contracts (types, exports, null/omission, auth, errors), and
  focused checks. Coordinator owns integration checks.
- Give each Sol agent complete requirements, ownership, contracts, exclusions,
  and checks: children start fresh. Optional [templates](references/prompts.md).
- Parallelize independent owners; use fewer for small tasks. Coordinate rather
  than duplicate work. Reuse child sessions for fixes; share contract changes.
- Await completion notifications; no polling/sleeping/progress-file inspection.
  Keep mutations scoped; never expose secrets or deploy DB changes just to test.

## 2. Preflight Claude early

1. Check `test "${HERDR_ENV:-}" = 1`. If false, report second review unavailable,
   continue independent work, and do not inspect/control another Herdr session.
2. Load `herdr --skill` once; follow installed help for syntax. Check
   `herdr integration status` and Claude availability.
3. Create a sibling pane in the current tab/project, layout-appropriate split,
   `--no-focus`. Use its returned ID and a unique agent name; no unsolicited
   workspace/worktree creation or reuse of someone else's agent.
4. After confirming syntax:
   ```bash
   herdr agent start <name> --kind claude --pane <pane-id> -- --model opus --permission-mode plan --name <task>-review
   ```
   Confirm Opus 5.5 in startup output; correct alias mismatches with a verified ID.
5. Send readiness via `agent prompt ... --wait --timeout ...`: no tools, diff
   inspection, edits, or plans; reply `REVIEW_READY`. Read the result.

For failures/stalls, read [troubleshooting](references/herdr-troubleshooting.md).
Report problems; do not repair global configuration without permission.

## 3. Review independently

- Review completed scopes only; mark unfinished/excluded files and cover remaining
  work plus integration later. Give both reviewers identical requirements and
  changed/new/untracked scope; `git diff` alone misses new files.
- Astra: read-only reviewer subagent. Claude: named Herdr agent,
  `agent prompt ... --wait --timeout ...`. Keep initial conclusions independent.
- Require introduced actionable defects: severity, file/line, evidence/failure
  scenario, remedy; otherwise explicit clean verdict. No edits, plans, secrets,
  mutating commands, speculative improvements, or cosmetic nits.
- For data changes check auth, atomicity, untouched fields, null/clear/no-op,
  and filtering before pagination/row caps.
- Background long Herdr waits; use completion notifications, not polling.
  Retrieve verdict with `agent read --source recent-unwrapped`.

## 4. Fix, verify, report

- Validate findings against code; send accepted fixes and acceptance criteria to
  the owning Sol session. Add meaningful regression tests when warranted.
- Originating reviewer rechecks substantial fixes; inspect small fixes and run
  focused regression checks.
- Run required integrated tests/typecheck/build; isolate or roll back DB checks.
  Repeat only for changes, failures, or unresolved concerns. Inspect final diff
  for unintended changes, whitespace, and outstanding findings.
- Report briefly: changes, checks actually passed, both review outcomes,
  unresolved findings, deployment steps, and Herdr problems/resolution.
  Startup/readiness is not a review; disclose blocked work and model fallbacks.
