---
name: Sol Dual Review
description: "Use for implementation requests when the sol-dual-review primary agent is selected, when the user invokes @sol-dual-review, or when they explicitly request the Sol implementation plus Astra and Claude/Opus-through-Herdr review workflow. Coordinate scoped implementation subagents, two independent reviews, fixes, and verification. Do not activate for ordinary coding requests in other agents."
---

# Sol Dual Review

Implement the user's task with Sol subagents, review it with Astra and independently with Claude Code through Herdr, resolve actionable findings, and verify the result.

## Default lineup

| Responsibility | Model / runtime |
| --- | --- |
| Coordinator | Current OpenCode agent |
| Implementation | GPT-6.1 Sol subagents |
| First reviewer | GPT-6 Astra reviewer subagent |
| Independent second reviewer | Claude Opus 5.5 in Claude Code through Herdr |

Honor user overrides. Resolve OpenCode model names with the available models tool, searching your own provider first; never guess provider/model IDs or silently substitute models. Verify the actual Claude model before reviewing: the `opus` alias can change over time.

This workflow authorizes delegation for the requested task. It does not override Plan mode, repository instructions, permissions, or the user's task scope. If implementation is blocked by Plan mode, ask the user to switch to Build; do not delegate around the restriction.

## 1. Establish scope and contracts

- Inspect applicable `AGENTS.md` files, current code, and the working-tree status. Load relevant domain skills.
- Record existing modified/untracked user work and exclude it from implementation and review unless explicitly in scope.
- Resolve material product ambiguity before delegating. Make reasonable small implementation decisions without adding approval steps.
- Split substantial work into non-overlapping ownership areas, usually backend/data and UI/routes. Use fewer agents when the task is small.
- Define shared contracts up front: exports, argument/return types, nullable versus omitted fields, permissions, and behavior on failure. Assign each shared file to exactly one writer.
- Tell agents which verification they own and reserve repository-wide checks for the coordinator.
- Read [prompt templates](references/prompts.md) when preparing delegation.

## 2. Preflight Herdr and Claude

Perform this early enough that integration problems do not block the end of the task.

1. Verify that this session is inside Herdr:
   ```bash
   test "${HERDR_ENV:-}" = 1
   ```
   If false, do not inspect or control another Herdr session. Report that the requested second-review route is unavailable; continue independent implementation work.
2. Unless already loaded, run `herdr --skill` and follow its current instructions. Use the installed CLI's help/group output as the authority for syntax.
3. Check `herdr integration status` and Claude Code availability. An integration reported as current can still contain stale hook commands.
4. Create a sibling pane in the current tab and project directory, choose its split direction from the caller's layout, and keep user focus unchanged with `--no-focus`. Do not create a workspace/worktree or reuse another person's agent without a request.
5. Use returned pane IDs and a unique agent name. Start Claude with the requested model and read-only review permissions. With the confirmed CLI syntax:
   ```bash
   herdr agent start <reviewer-name> --kind claude --pane <returned-pane-id> -- --model opus --permission-mode plan --name <task>-review
   ```
6. Read the startup output and confirm the requested Opus version. If an alias resolves to another version, correct it using a verified native model identifier before the review. Do not silently use the wrong model.
7. Send a short readiness prompt with `agent prompt ... --wait --timeout ...`; instruct Claude not to inspect unfinished work or modify anything. Read its result after completion.

Report startup, authentication, model, hook, permission, timeout, and output-retrieval problems plainly. Never equate successful process startup with a completed review.

### Herdr troubleshooting boundaries

- Inspect blocked UI before responding. Follow Herdr's instructions for approval dialogs; do not approve them on the user's behalf.
- A timeout or stalled prompt does not prove non-delivery. Inspect the named agent before resending.
- Prefer `agent read --source recent-unwrapped` for the final verdict. If a larger read still cannot recover it, follow Herdr's documented temporary-file fallback.
- Do not reinstall integrations, edit global configuration, upgrade Herdr, or stop its server merely to make this workflow work. Request permission for configuration changes outside the task.
- For stale hook errors, inspect only relevant hook entries, not whole credential-bearing configs or environment files.
- Reinstallation may leave old absolute-path hooks alongside a new hook. On shared macOS/Linux configs, a portable command is:
   ```json
   "command": "bash \"$HOME/.claude/hooks/herdr-agent-state.sh\" session"
   ```
  Preserve the appropriate argument for each entry. Single-quoting `$HOME` prevents expansion. If authorized to edit, preserve the dotfiles link and unrelated settings, then validate JSON and run a real Claude smoke test.

## 3. Implement with Sol

- Launch Sol agents with the agreed ownership, contracts, user-work exclusions, and verification responsibilities.
- Include the complete requirements in each fresh agent's prompt; child sessions do not inherit your understanding automatically.
- Keep independent agents running concurrently. The coordinator handles integration setup, cross-cutting investigation, and verification preparation rather than duplicating their work.
- Use the existing child session for fixes or clarifications. Communicate contract changes to every affected owner.
- Subagents return completion notifications automatically: do not sleep, poll, or repeatedly inspect unfinished files for progress.
- Keep mutations in scope. In particular, never expose environment files or secrets, overwrite unfamiliar work, or deploy database changes merely to test them.

## 4. Obtain two independent reviews

- Start review when its assigned scope is complete. A completed frontend may be reviewed while backend work continues, but identify unfinished/excluded files explicitly and arrange a final integration/backend pass.
- Give both reviewers the same requirements and relevant changed/new files, including untracked feature files. A plain `git diff` misses new files.
- Astra runs as a read-only reviewer subagent. Claude runs through the named Herdr agent using `agent prompt ... --wait --timeout ...`.
- Require actionable introduced defects with severity, location, reproduction/evidence, and a concrete remedy. Ask for an explicit clean verdict when there are no findings.
- Keep the initial reviews independent: do not prime one reviewer with the other's conclusions. Send accepted fixes for targeted re-review afterward.
- Reviewers must not edit code, write plans, inspect secrets, or run mutating commands.
- For relevant data changes, scrutinize authorization, atomicity, untouched-field preservation, null/clear/no-op semantics, and filtering before database pagination/row caps.
- Use asynchronous shell execution and completion notifications for long Herdr waits. Read output after completion; do not poll the output file.

## 5. Resolve findings and verify

- Evaluate findings against the actual code. Do not blindly implement speculative suggestions or cosmetic preferences.
- Send accepted fixes to the owning Sol agent with concrete acceptance criteria. Keep concurrent writers off the same files.
- Add or update meaningful regression tests for demonstrated defects where appropriate; avoid tests that merely mirror source text.
- Have the originating reviewer verify substantial fixes. For small local fixes, inspect the final diff and run the relevant regression check.
- Run the project's required focused tests, typecheck, production build, or equivalent checks after integration. Use isolated or rolled-back database verification when appropriate.
- Re-run checks only when subsequent changes, failures, or unresolved concerns justify them.
- Check the final diff for unintended changes, whitespace errors, and unresolved review findings. Preserve pre-existing user work.

## 6. Report completion

Keep progress commentary limited to useful discoveries, decisions, and blockers. Background-job status is not the final completion report.

Finish with a short report containing:
- What changed.
- Which checks actually passed.
- Whether both requested reviews completed and findings were resolved.
- Any deployment step still required, such as an unapplied migration.
- Any Herdr/Claude problems encountered and whether they remain unresolved.

Do not claim the second review ran if only the agent started, or report a model fallback as the requested model. If blocked, state exactly what is complete and what still needs the user.
