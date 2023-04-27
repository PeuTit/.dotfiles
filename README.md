# Dotfiles repo

I'm now using stow to manage my config files.
This is really helpful to manage each programm separately. You only need to create a folder for each program and store its related file in the same way they would be stored on your machine.
Then you only need a single command to create all the symbolic links needed.

```sh
stow git
stow tmux
stow ...
```

```sh
stow -S folder_app1, folder_app2
```
Tips: You can add the flag `-v` to activate verbose mode and `-n` to preview the action without making any changes.

To unstow (unlink) you need to use the `-D` flag.

It's still possible to use the classic way of course.
To simlink a file from this repo to the home directory of your user, use this command

```sh
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```

## Dependencies

(For Arch, you can check the AUR)

### Neovim

(Packer)[https://github.com/wbthomason/packer.nvim]

Clone the packer repository and run `:PackerInstall`.

### Tmux

(tpm)[https://github.com/tmux-plugins/tpm]

Clone the tmux plugin manager repository and run the install command: `prefix + I`.

## Keyboard config

(keyd)[https://github.com/rvaiya/keyd]

Install `keyd` on your system. (Available on the AUR)

AT Translated Set 2 Keyboard -> built-in MSI keyboard
SONiX USB DEVICE -> Epomaker S68
Apple Inc. Apple Internal Keyboard / Trackpad

Verify the name of your input key with `sudo keyd -m`.

## Install app with Brewfile

```
brew bundle --file ~/.dotfiles/Brewfile install
```

To get the list of all app installed with Homebrew, use the command:

```sh
brew bundle dump --no-lock --force
```
