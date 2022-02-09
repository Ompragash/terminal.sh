#!/bin/bash
#
# Configure .vimrc for YAML and Ansible.

cat > ~/.vimrc <<EOF
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
set et ai sw=2 ts=2 tw=78 sts=2 cuc
set cursorline
set cursorcolumn
set hidden
set autoindent
set smartindent
EOF
