/opt/homebrew/bin/brew shellenv | source

# fzf.fish extra config
fzf_configure_bindings --directory=\cf
set --global fzf_preview_dir_cmd lsd -A --color never
set --global fzf_preview_file_cmd bat -p --color never
set --global fzf_fd_opts --no-ignore
# Set up fzf key bindings
fzf --fish | source
set --global --export FZF_DEFAULT_OPTS '--height 40% --tmux bottom,40% --layout reverse --border sharp'

# create tmux session from current directory
function start_tmux_from_directory
    # current directory without leading path
    set dir (basename $PWD)
    # md5 hash for the full working directory path
    set md5 (echo -n $PWD | md5sum | cut -d ' ' -f 1)
    # human friendly unique session name for this directory
    set session_name "$dir"-(string shorten --char="" --max 6 $md5)
    # create or attach to the session
    tmux new -Ads "$session_name"
end

function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

# Commands to run in interactive sessions can go here
if status is-interactive
    # Git
    abbr -a --global -- gst 'git status'
    abbr -a --global -- ga 'git add'
    abbr -a --global -- gaa 'git add --all'
    abbr -a --global -- gc 'git commit -S -v'
    abbr -a --global -- glo "git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
    abbr -a --global -- gp 'git push'
    abbr -a --global -- gl 'git pull'
    abbr -a --global -- gb 'git branch'
    abbr -a --global -- gs 'git switch'
    abbr -a --global -- gsm 'git switch master'
    abbr -a --global -- gsa 'git switch ACDC-'
    abbr -a --global -- gld 'git dlog'
    abbr -a --global -- gr 'git rebase'
    abbr -a --global -- grc 'git rebase --continue'
    abbr -a --global -- gra 'git rebase --abort'
    abbr -a --global -- grv 'git remote -v'
    abbr -a --global -- gm 'git merge'
    abbr -a --global -- gf 'git fetch'
    abbr -a --global -- grs 'git restore'
    abbr -a --global -- gd 'git dft'
    abbr -a --global -- gsh 'git dshow'

    abbr -a --global -- l 'lsd -lA'
    abbr -a --global -- b 'bat -p'

    abbr -a --global -- rm 'trash'

    abbr -a --global -- gg 'lazygit'

    abbr -a --global -- bbb 'brew update && brew upgrade && brew cleanup'

    abbr -a --global -- hledger 'hledger --file ~/Documents/accounting/finance/2025.journal'

    abbr -a --global -- tds start_tmux_from_directory


    fish_user_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore

    set fish_greeting

    switch (uname)
    case Darwin
        # macos specific config goes here
        fish_add_path --path "$HOME/Library/Application Support/Coursier/bin"
        fish_add_path --path "$HOME/.cargo/bin"
        fish_add_path --path "$HOME/.local/bin" # pipx
    case Linux
        # linux specific config goes here
        fish_add_path --path $HOME/.local/share/coursier/bin
    case '*'
        echo "Unknown OS"
    end

    # use to enter pgp passphrase when commiting
    set -gx GPG_TTY "$(tty)"
end
