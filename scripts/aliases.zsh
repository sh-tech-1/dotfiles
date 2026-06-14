# Python — resolve python3 / pip3 from PATH (arch & version agnostic)
alias python='python3'
alias pip='pip3'

# Modern CLI replacements — alias only when the tool is installed, so a freshly
# provisioned machine (before homebrew.sh finishes) keeps working core commands.
(( $+commands[bat] ))   && alias cat='bat'
(( $+commands[rg] ))    && alias grep='rg -n'
(( $+commands[nvim] ))  && alias vim='nvim'
(( $+commands[gsed] ))  && alias sed='gsed'
(( $+commands[dust] ))  && alias du='dust'
(( $+commands[hexyl] )) && alias xxd='hexyl'
(( $+commands[tokei] )) && alias cloc='tokei'
(( $+commands[btm] ))   && alias htop='btm'
(( $+commands[procs] )) && alias top='procs --watch --insert TcpPort --sortd cpu'
(( $+commands[procs] )) && alias ps='procs --color=disable --sorta pid'

# clipboard
alias q='pbcopy'
alias qq='pbpaste'

# misc
alias t='twterm'
alias dc='docker-compose'
alias ai-assistant='cd ~/products/business-ai-assistant'
