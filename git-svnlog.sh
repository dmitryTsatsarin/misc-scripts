#!/bin/bash

NUM_LOG=${1:-10}
TARGET_DIR=$2

if ! [[ "$NUM_LOG" =~ ^[0-9]+$ ]] ; then
    exec >&2; echo "Error: argument must be a number"; exit 1
fi

_git_dir="$(git rev-parse --show-toplevel 2> /dev/null)"
echo $_git_dir
_git_svn_dir="${_git_dir}/.git/svn"
echo $_git_svn_dir
if [ -d "${_git_svn_dir}" -a x != x"$(ls -A "${_git_svn_dir}/")" ]; then
    echo Looks like git-svn
fi

paste -d ' ' <(git svn log --oneline -${NUM_LOG} ${TARGET_DIR} | cut -d '|' -f1 | tr -d ' ') <(git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset' --abbrev-commit -${NUM_LOG} ${TARGET_DIR});
