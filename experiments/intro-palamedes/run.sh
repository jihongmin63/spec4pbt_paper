#!/usr/bin/env bash
# Run from any directory. Argument: built Lake project depending on Palamedes.
set -u
artifact_dir=$(cd -- "$(dirname -- "$0")" && pwd)
project=${1:?Pass the path to a built Lake project depending on Palamedes}
cd -- "$project"
palamedes_source=${2:-"$project/.lake/packages/palamedes"}
{
  date -u '+%Y-%m-%dT%H:%M:%SZ'
  printf 'Lake project: %s\nPalamedes source: %s\n' "$project" "$palamedes_source"
  git -C "$palamedes_source" remote get-url origin
  git -C "$palamedes_source" rev-parse HEAD
  git -C "$palamedes_source" status --short
  cat "$palamedes_source/lean-toolchain"
  echo
  lake --version
  lake env lean --version
  lake env printenv LEAN_PATH
} > "$artifact_dir/environment.txt" 2>&1
cp "$palamedes_source/lakefile.toml" "$artifact_dir/palamedes-lakefile.toml"
cp "$palamedes_source/lake-manifest.json" "$artifact_dir/palamedes-lake-manifest.json"
cp lake-manifest.json "$artifact_dir/project-lake-manifest.json"
printf 'case\texit_status\n' > "$artifact_dir/results.tsv"
for case_name in Control ExactGoal Agentic; do
  lake env lean "$artifact_dir/$case_name.lean" > "$artifact_dir/$case_name.log" 2>&1
  exit_status=$?
  printf '%s\t%s\n' "$case_name" "$exit_status" >> "$artifact_dir/results.tsv"
done
cat "$artifact_dir/results.tsv"
