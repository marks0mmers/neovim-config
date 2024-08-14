# marks0mmers.nvim

My current neovim setup. Inspired from [kickstart.nvim]('https://github.com/nvim-lua/kickstart.nvim').

## Installation

### Backup Old NeoVim

1. If you have an existing config, back it up by running 
```sh
mv ~/.config/nvim ~/.config/nvim-bak
```
2. Delete old data by
```sh
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

### Install
1. ```sh 
git clone git@github.com:marks0mmers/neovim-config.git ~/.config/nvim
```
2. Open nvim and ensure lazy deps install successfully
