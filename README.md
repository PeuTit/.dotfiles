# Dotfiles repo

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
