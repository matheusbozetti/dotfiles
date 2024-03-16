# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

Clone dotfiles

```
git clone git@github.com:matheusbozetti/dotfiles.git ~/dotfiles
```

CD dotfiles folder

```
cd ~/dotfiles
```

Execute shell script to stow the files

```
sh ./install.sh
```
