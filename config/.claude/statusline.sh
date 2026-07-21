#!/usr/bin/env bash
# Claude Code statusLine: dir + git branch + model + context % remaining
input=$(cat)

dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
transcript=$(printf '%s' "$input" | jq -r '.transcript_path // ""')

name=$(basename "$dir")

branch=""
if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$dir" branch --show-current 2>/dev/null)
fi

# Context window: opus[1m] = 1M tokens, otherwise default 200k.
limit=200000
case "$model" in
  *1[mM]*|*"1m"*) limit=1000000 ;;
esac

ctx=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  used=$(grep -a '"usage"' "$transcript" 2>/dev/null | tail -1 | jq -r '
    (.message.usage // {}) as $u
    | (($u.input_tokens // 0)
       + ($u.cache_read_input_tokens // 0)
       + ($u.cache_creation_input_tokens // 0)
       + ($u.output_tokens // 0))' 2>/dev/null)
  if [ -n "$used" ] && [ "$used" -gt 0 ] 2>/dev/null; then
    pct=$(( (limit - used) * 100 / limit ))
    [ "$pct" -lt 0 ] && pct=0
    ctx="${pct}% ctx"
  fi
fi

out="$name"
[ -n "$branch" ] && out="$out  $branch"
out="$out  $model"
[ -n "$ctx" ] && out="$out  $ctx"
printf '%s' "$out"
