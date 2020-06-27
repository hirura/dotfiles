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
  if [ ! ".gitkeep" = ${_dotfile##*/} ]
  then
    ln -snfv ${SCRIPT_DIR}/${_dotfile} ${HOME}/${_dotfile}
  fi
done

# download and deploy vim color schemes
if [ ! -d ${HOME}/.vim/colors/molokai ]
then
  git clone https://github.com/tomasr/molokai.git ${HOME}/.vim/colors/molokai
else
  (cd ${HOME}/.vim/colors/molokai && git pull)
fi
ln -snfv ${HOME}/.vim/colors/molokai/colors/molokai.vim ${HOME}/.vim/colors/
if [ ! -d ${HOME}/.vim/colors/iceberg ]
then
  git clone https://github.com/cocopon/iceberg.vim.git ${HOME}/.vim/colors/iceberg
else
  (cd ${HOME}/.vim/colors/iceberg && git pull)
fi
ln -snfv ${HOME}/.vim/colors/iceberg/colors/iceberg.vim ${HOME}/.vim/colors/
