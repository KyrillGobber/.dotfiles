# Delegation Prompts

Fill in the placeholders with the current task's concrete requirements. Avoid sending every file or unrelated project history to every agent.

## Sol implementation

```text
Implement [owned portion] in [working directory].

Requirements:
[Agreed user-visible behavior, edge cases, and permissions.]

Read applicable AGENTS.md instructions and load relevant domain skills.
You own only:
[Files/modules and any reserved test files.]

Other agents own:
[Files/modules not to edit.]

Shared contracts:
[Exact exports, payloads, return types, omission/null behavior, validation,
authorization boundaries, and error handling.]

Existing user work to preserve:
[Modified/untracked files outside this task.]

Coordinate changes to these contracts before editing another owner's files.
Do not inspect environment/credential files or log secrets.
Use the harness's required editing tools.

Verification:
[Focused checks owned by this agent.]
The coordinator owns [repository-wide typecheck/build/integration checks].

Return: changed files, behavior implemented, checks actually run, and blockers.
```

## Astra or Claude review

```text
Perform a read-only review of [task] in [working directory].

Requirements:
[Same agreed behavior and invariants used for implementation.]

Scope:
[Completed modified AND new/untracked feature files.]

Existing context worth checking:
[Authorization helpers, database functions, current callers, shared components.]

Excluded or unfinished work:
[User files and any still-running implementation areas.]

Inspect actual code and relevant callers, not just the implementer's summary.
Identify actionable defects introduced by this change. Give severity,
file/line, concrete failure scenario/evidence, and suggested remedy.
Do not modify files, write plans, inspect environment/credential files, or
run mutating commands. Avoid speculative improvements and cosmetic nits.

Return a concise findings list or explicitly "No actionable findings".
State any scope you could not inspect and checks you actually ran.
```

## Claude readiness / hook smoke test

```text
You will be an independent read-only reviewer for [task].
Implementation is still in progress; do not inspect the diff yet.
Do not use tools, modify files, or write a plan.
Reply with REVIEW_READY and your model if known.
I will send the completed review scope separately.
```

Check the terminal's model display as well as the response. A readiness reply proves prompt delivery, not a completed code review.

## Fix assignment

```text
Address this accepted review finding in your owned files:
[Severity, location, concrete failure, and expected behavior.]

Keep these contracts and unrelated behavior intact:
[Constraints.]

Add a focused regression check if the failure warrants one, run the affected
checks, and report the fix and results. Do not broaden the refactor.
```

## Targeted re-review

```text
Your finding [identifier/summary] was addressed in [files].
The fix is [brief explanation]; the regression check is [test/check].
Verify this delta and its integration, read-only.
Report whether the original finding is resolved and any new actionable defect
introduced by the fix. Do not repeat the entire review without a reason.
```
