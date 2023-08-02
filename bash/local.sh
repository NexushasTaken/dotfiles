#!/usr/bin/env bash
# vim: ft=bash
alias psql="PAGER='nvim --clean -R' psql"
codoo() {
  # [[ -d '.cache' ]] || mkdir -p '.cache/'
  odoo --dev=all -d $(basename $(pwd)) -D .cache/odoo $@
}
