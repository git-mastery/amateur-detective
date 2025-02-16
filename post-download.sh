#!/bin/bash

touch file{1..100}.txt
rm file77.txt

git add file*.txt

git commit -m "Change 1"

echo "This is a change" >>file14.txt

touch file77.txt

# Remove permissions to edit these files for user
chmod -w file{1..100}.txt

first_commit_hash=$(git log --reverse --pretty=format:'%h' | head -n 1)
if [ $(git tag -l "git-mastery-start-$first_commit_hash") ]; then
  git tag -d "git-mastery-start-$first_commit_hash"
  git push --delete origin "git-mastery-start-$first_commit_hash" 2>/dev/null
fi

git tag "git-mastery-start-$first_commit_hash"
git push --tags
