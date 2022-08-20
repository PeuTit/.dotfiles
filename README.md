# Dotfiles repo

I'm now using stow to manage my config files.

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

## Keyboard config

Install `keyd` on your system.

Then you can simlink the two file in the folder `keyboard-config` in:

    /etc/keyd/

!Don't forget to use sudo!

AT Translated Set 2 Keyboard.cfg -> built-in MSI keyboard
SONiX USB DEVICE.cfg -> Epomaker S68 via USB

Always verify the name of your input with `sudo keyd -m`.

## Install app with Brewfile

```
brew bundle --file ~/.dotfiles/Brewfile install
```

To get the list of all app installed with Homebrew, use the command:

```sh
brew bundle dump --no-lock --force
```

## Install powerline font

Refer to this Github Repository for informations
https://github.com/powerline/fonts

## Install NVM

Refer to this Github Repository for informations
https://github.com/nvm-sh/nvm
