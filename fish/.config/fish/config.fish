/opt/homebrew/bin/brew shellenv | source

# autostart tmux (check if tmux variable is set to avoid nesting)
if status is-interactive
and not set -q TMUX
    tmux new-session -A
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
    abbr -a --global -- gswt 'git switch TST-'
    abbr -a --global -- gld 'git log --decorate -p'
    abbr -a --global -- gr 'git rebase'
    abbr -a --global -- grc 'git rebase --continue'
    abbr -a --global -- gra 'git rebase --abort'
    abbr -a --global -- grv 'git remote -v'
    abbr -a --global -- gm 'git merge'
    abbr -a --global -- gf 'git fetch'
    abbr -a --global -- grs 'git restore'

    abbr -a --global -- l 'lsd -lA'
    abbr -a --global -- b 'bat -p'

    abbr -a --global -- rm 'trash'

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
        fish_add_path --path "$HOME/.cargo/bin"
    case Linux
        # linux specific config goes here
        fish_add_path --path $HOME/.local/share/coursier/bin
    case '*'
        echo "Unknown OS"
    end

    # use to enter pgp passphrase when commiting
    set -gx GPG_TTY "$(tty)"
end
