 # ==========================================
    # ⚡ 1. POWERLEVEL10K INSTANT PROMPT
    # ==========================================
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # ==========================================
    # 📦 2. PLUGIN MANAGER (ZINIT)
    # ==========================================
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    if [ ! -d "$ZINIT_HOME" ]; then
       mkdir -p "$(dirname $ZINIT_HOME)"
       git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    fi
    source "${ZINIT_HOME}/zinit.zsh"

    # Theme Configuration
    zstyle ':catppuccin:p10k' 'theme' 'lean'
    zstyle ':catppuccin:p10k' 'flavour' 'mocha'
    zinit ice depth=1; zinit light romkatv/powerlevel10k
    zinit light tolkonepiu/catppuccin-powerlevel10k-themes

    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    # Zsh Plugins
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
    zinit light Aloxaf/fzf-tab

    autoload -Uz compinit && compinit

    # Oh-My-Zsh Snippets
    zinit snippet OMZL::git.zsh
    zinit snippet OMZP::git
    zinit snippet OMZP::sudo
    zinit snippet OMZP::archlinux
    zinit snippet OMZP::aws
    zinit snippet OMZP::kubectl
    zinit snippet OMZP::command-not-found

    # ==========================================
    # ⚙️ 3. SHELL HISTORY & KEYBINDINGS
    # ==========================================
    bindkey -e
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^[w' kill-region

    HISTSIZE=5000
    HISTFILE=~/.zsh_history
    SAVEHIST=$HISTSIZE
    setopt appendhistory
    setopt sharehistory
    setopt hist_ignore_space
    setopt hist_ignore_all_dups
    setopt hist_save_no_dups
    setopt hist_ignore_dups
    setopt hist_find_no_dups

    # ==========================================
    # 🎨 4. COMPLETION STYLING & FZF CANDIDATES
    # ==========================================
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

    _fzf_compgen_path() { fd --hidden --exclude .git . "$1" }
    _fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1" }

    # Bat (Better Cat Theme)
    export BAT_THEME="Catppuccin Mocha"

    # ==========================================
    # 🛠️ 5. PATH DEFINITIONS
    # ==========================================
    # Standard local binaries
    export PATH="$HOME/.local/bin:$PATH"

    # Go Binaries
    export PATH="$HOME/go/bin:$PATH"

    # Spicetify Spotify modifier
    export PATH="$PATH:$HOME/.spicetify"

    # LM Studio CLI (lms)
    export PATH="$PATH:$HOME/.lmstudio/bin"

    # Android SDK
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

    # Sourcing general environment scripts
    [ -f "$HOME/.local/share/../bin/env" ] && . "$HOME/.local/share/../bin/env"
    [ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

    # ==========================================
    # ⚡ 6. LAZY-LOAD NODE / EXTRA RUNTIMES
    # ==========================================
    # Note: Since you use mise, you should manage Node via mise (e.g. `mise use -g node@20`)
    # which has 0ms load speed. If you still need NVM, use this:
    export NVM_DIR="$HOME/.config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # ==========================================
    # Integrations (FZF & Zoxide)
    # ==========================================
    eval "$(fzf --zsh)"
    eval "$(zoxide init --cmd cd zsh)"

    # ==========================================
    # 🐚 7. ALIASES (Cleaned and Deduplicated)
    # ==========================================
    alias vim='nvim'
    alias c='clear'
    alias md='mkdir -p'
    alias lg="lazygit"

    # Eza (Modern LS replacements)
    alias ls='eza --icons=always --group-directories-first'
    alias ll='eza -l --icons=always --header --group-directories-first'
    alias la='eza -la --icons=always --header --group-directories-first'
    alias lt='eza --tree --icons=always'

    # tmuxp session shortcuts
    alias tgo="tmuxp load golang"
    alias tdsa="tmuxp load DSA"
    alias trn="tmuxp load react-native"
    alias tls="tmux ls"
    alias tkill="tmux kill-session -t"
    alias tgen="tmuxp load Genai"

    # Hardcoded "thefuck" command (Saves ~150ms startup delay)
    fuck () {
        TF_LIMIT_DESC=9999
        local fuck_command=$(THEFUCK_REQUIRE_CONFIRMATION=true thefuck $(fc -ln -1))
        if [ -n "$fuck_command" ]; then
            eval "$fuck_command"
            print -s "$fuck_command"
        fi
    }

    # ==========================================
    # 🧠 8. SECOND BRAIN ALIASES
    # ==========================================
    alias b='brain'
    alias bj='brain journal'
    alias bcap='brain capture'
    alias bs='brain search'
    alias bp='brain process-inbox'
    alias btd='brain todo daily'
    alias btw='brain todo weekly'
    alias btm='brain todo monthly'
    alias btg='brain tag'
    alias blk='brain link'
    alias brd='brain review daily'
    alias brw='brain review weekly'

