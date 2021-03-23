My configuration files, mostly here to hold onto my neovim configuration which I've pieced together over the years.

# Usage

Clone repository into any directory. Create symlinks manually for each file.

# tmux

My tmux configuration uses the configuration at [gpakosz/.tmux](https://github.com/gpakosz/.tmux), with a few modifications to the colors and styles.

# neovim

General configuration is contained in `init.vim`, which sources `plugins.vim` which contains my plugin-specific key-mappings and configurations. In time I'm considering moving from coc to neovim's native LSP client.
