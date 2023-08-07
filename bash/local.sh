#!/usr/bin/env bash
# vim: ft=bash
alias psql="PAGER='nvim --clean -R' psql"
codoo() {
  ODOO_PATH=$HOME/odoo-dev
  local addons_path="$ODOO_PATH/addons,$ODOO_PATH/odoo/addons"
  local cmd="odoo -D $PWD/.cache/odoo --dev=all"

  add_path() {
    local path=$(realpath $1)
    if [[ -d $path ]]; then
      for dir in $(exa -D $path); do
        if [[ -f "$path/$dir/__init__.py" ]]; then
          addons_path="$addons_path,$path"
          return 0
        fi
      done
    fi
  }
  add_path .

  for i in $(seq 3); do
    case $1 in
      init)
        cmd="$cmd -i all"
        shift
      ;;paths)
        shift
        for dir in ${1//,/ }; do
          add_path $dir
        done
        shift
      ;;db)
        cmd="$cmd -d $(basename $(pwd))"
        shift
    esac
  done

  unset add_path
  $PREFIX $cmd --addons-path=$addons_path $@
}
