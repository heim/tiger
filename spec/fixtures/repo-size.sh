#!/bin/bash

set -e

function main() {
  echo "{"
  git rev-list --reverse HEAD | tail -n1 |
  while read rev; do 
    echo "\"`revision_time`\" => \"`line_count`\","
  done 
  echo "}"
}

function line_count() {
  git ls-tree -r $rev | 
  awk '{print $3}' | 
  xargs git show |
  wc -l
}
function revision_time() {
  git log -1 $rev --pretty=format:"%ai"
}
main
