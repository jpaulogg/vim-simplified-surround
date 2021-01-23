## surround.vim

Very simplified version of Tpope's [vim-surround](https://github.com/tpope/vim-surround).

`ys{char}` surrounds motions with `{char}`.

`ds{char}` deletes surrounding `{char}`.

`cs{char1}{char2}` changes surrounding `{char1}` with `{char2}`.

## Main differences to Tpope's surround.vim

- doesn't support tags
- `ysiw(` is the same of `ysiw)`
- doesn't support repeating `ds` and `cs` operations with `.` command.
- cursor position after operations
- this version has ~86 lines of code, while Tpope's plugin has ~594 lines of code. 

## Tips

- you can repeat `ys` operations with `.` but using a different surrounding pair.
- you can use abbreviations to use pairs with more then one characters.
- you can use spaces as surrounding pairs.
- it's very easy to make any changes directly to the script!

## Installation

You can simply copy surround.vim to your runtime.

```
# in neovim
mkdir -p ~/.config/nvim/plugin
cd ~/.config/nvim/plugin
git clone https://github.com/jpaulogg/vim-simplified-surround
```

If you prefer, install using your favorite package manager, or use (Neo)Vim's built-in package
support. Use `pack` branch in that case:

```
# vim-plug
Plg 'jpaulogg/vim-simplified-surround', { 'branch' : 'pack' }

# built-in package (neovim)
mkdir -p ~/.config/nvim/pack/dist/start
cd ~/.config/nvim/pack/dist/start
git clone https://github.com/jpaulogg/vim-simplified-surround
git fetch origin pack
git checkout pack
```
