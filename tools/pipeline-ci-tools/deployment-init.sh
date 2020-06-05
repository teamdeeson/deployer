#!/usr/bin/env bash

# Create a temporary directory and change into it
# Clone target repo: git@bitbucket.org:deesongroup6346/deeson-ci-quickstart-example.git
# Rsync files to target repo
# Remove temporary directory

# Declare proper usage
usage () {
  cat << EOF

usage:
   deployment-init.sh <path-to-git-repo>
   deployment-init.sh -h

EOF
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

# Set up variables
script_path=$(dirname $0)
debug=0
ci_quickstart_repo_url="git@bitbucket.org:deesongroup6346/deeson-ci-quickstart-example.git"
path_to_git_repo=$1

if [ ! -e ${path_to_git_repo} ]; then
  echo 'The path to the Git repo to copy the auto-deployment quick start files to that has been provided does not exist.'
  exit 1
fi


# Copy deployment quickstart files
ci_quickstart_dir=$(mktemp -d)
cd ${ci_quickstart_dir} && $(git clone ${ci_quickstart_repo_url} .)
rsync -av --exclude=.git "${ci_quickstart_dir}/" "${path_to_git_repo}/"
mv ${path_to_git_repo}/bitbucket-pipelines.yml.sample ${path_to_git_repo}/bitbucket-pipelines.yml
chmod -R a+x ${path_to_git_repo}/scripts/*.sh
