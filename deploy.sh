#!/bin/sh

set -eu

SCRIPT_DIR="$(cd $(dirname $0) && pwd)"

for _dotfile in $(cd ${SCRIPT_DIR} && git ls-files)
do
  if echo ${_dotfile} | grep -q -e '/'
  then
    _mkdir_dir="${HOME}"
    for _dir in $(echo ${_dotfile%/*} | tr '/' ' ')
    do
      _mkdir_dir="${_mkdir_dir}/${_dir}"
      if [ ! -d ${_mkdir_dir} ]
      then
        mkdir -v ${_mkdir_dir}
      fi
    done
  fi
  ln -snfv ${SCRIPT_DIR}/${_dotfile} ${HOME}/${_dotfile}
done
