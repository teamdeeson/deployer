#!/usr/bin/env bash

# Create a temporary directory
# Clone target repo: git clone mypipelinestest@svn-6182.devcloud.hosting.acquia.com:mypipelinestest.git . && git fetch --all
# Add source repo as remote: git remote add relay git@bitbucket.org:deesongroup6346/my-pipelines-test.git
# Push to source repo: git push --mirror relay
# Remove temporary directory

# Declare proper usage
usage () {
  cat << EOF

usage:
   repository-sync.sh <git-repo-url-to-sync-from> <git-repo-url-to-sync-to>
   repository-sync.sh -h

EOF
}

if [ $# -lt 2 ]; then
  usage
  exit 1
fi

# Set up variables
script_path=$(dirname $0)
debug=0
source_repo_url=$1
target_repo_url=$2

repo_sync_dir=$(mktemp -d)
cd $repo_sync_dir && \
  $(git clone --mirror $source_repo_url .) && \
  git fetch --all && \
  $(git remote add relay $target_repo_url) && \
  git push --mirror relay
