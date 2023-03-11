#!/bin/sh
# This is a humorous take on deploy scripts.
# Don't do this to any project where you actually want versioned source control (see below)
# 
# The purpose of this script:
# - automatically force push the repository to a remote on GitHub which is always
#   immediately overwritten, purging any existing git history, including reflog.
# - in combination with a git webhook connected to my shared webhosting, 
#   this is an easy form of backup + automatic deployment
# Be careful to put secrets into .gitignore before running this.
COMMIT_MSG="Personal homepage"
git add . 
git commit -m "$COMMIT_MSG"
git reset $(git commit-tree HEAD^{tree} -m "$COMMIT_MSG") 
git reflog expire --expire=now --all
git gc --aggressive --prune=now
git push -f
