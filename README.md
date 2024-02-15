# senesc's dotfiles
These are some of my dotfiles.<br>
Some of the programs are configured to load parts of the configuration based on which machine is running it (e.g. tmux shows the battery percentage only if a battery is detected).<br>
<br>
The most interesting part of my config is probably the Neovim configuration. It has a ton of LuaSnip snippets for LaTeX, which I use to take notes during math lectures.<br>
<br>
Like any other dotfiles collection, this is a work in progress. I'll try keeping it up to date and working.

# Installing
When cloning this repository, you should clone submodules too:
```
git clone --recursive https://github.com/senesc/dotfiles.git
```
To quickly link the dotfiles in the correct places, I use `stow`. I should write a script, though.
