# Forge Delegation Templates (Optional)

Replace brackets with concrete task details; omit unrelated history.

## Sol

```text
Implement [scope] in [directory].
Requirements: [behavior, edge cases, auth].
Own only: [files/tests]. Other owners: [files].
Contracts: [exports, types, null/omission, validation, errors].
Preserve/exclude: [existing user work].
Read applicable instructions/skills; use required editing tools. Coordinate
contract/ownership changes first. Never inspect credentials or expose secrets.
Run [focused checks]; coordinator owns [integration checks].
Return changed files, behavior, actual checks/results, blockers.
```

## Either reviewer

```text
Read-only review of [task] in [directory].
Requirements: [behavior/invariants].
Scope: [completed modified/new/untracked files].
Relevant context/callers: [paths]. Exclude: [user/unfinished work].
Inspect actual code/callers. Report introduced actionable defects with severity,
file/line, failure evidence, remedy; otherwise "No actionable findings".
No edits, plans, secrets, mutating commands, speculation, or cosmetic nits.
State unreviewed scope and checks actually run.
```

## Readiness

```text
Prepare for independent read-only review of [task]. Scope follows later.
No tools, diff inspection, edits, or plans. Reply REVIEW_READY and model if known.
```

## Fix / re-review

- Owner: Fix [accepted finding/evidence] in [owned files]; preserve [contracts].
  Expected: [criteria]. Add warranted regression check; report fix/checks.
- Reviewer: Recheck [finding] after [fix/files/check], read-only. Confirm resolution
  and any newly introduced defect; avoid unrelated repeat review.
