_laka() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local words=("${COMP_WORDS[@]}")
  unset words[0]
  local completion=$(laka completion ${words[@]})
  COMPREPLY=( $(compgen -W "$completion" -- "$word") )
}

complete -F _laka laka
