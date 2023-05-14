if status is-interactive
    # Commands to run in interactive sessions can go here
    # Git
    abbr -a --global -- gst 'git status'
    abbr -a --global -- ga 'git add'
    abbr -a --global -- gaa 'git add --all'
    abbr -a --global -- gc 'git commit -S -v'
    abbr -a --global -- glo 'git log --decorate --oneline'
    abbr -a --global -- gp 'git push'
    abbr -a --global -- gl 'git pull'
    abbr -a --global -- gb 'git branch'
    abbr -a --global -- gs 'git switch'
    abbr -a --global -- gld 'git log --decorate -p'
    abbr -a --global -- gr 'git rebase'

    abbr -a --global -- l 'ls -la'

    fish_vi_key_bindings insert
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore

    set fish_greeting

    # add coursier to path
    switch (uname)
    case Darwin
        # macos specific config goes here
        fish_add_path --path "$HOME/Library/Application Support/Coursier/bin"
    case Linux
        # linux specific config goes here
        fish_add_path --path $HOME/.local/share/coursier/bin
    case '*'
        echo "Unknown OS"
    end
end

# todo:
# create a quick way to toggle between light & dark mode in Neovim
alias lnvim="nvim --cmd \"let g:light='true'\""

# use to enter pgp passphrase when commiting
set -gx GPG_TTY "$(tty)"
