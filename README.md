# surround.vim

Very simplified version of Tpope's [vim-surround](https://github.com/tpope/vim-surround).
I wrote this script because the way "(" and ")" works in different ways in the Tpope's plugin left me
confused. I prefer to deal with the spaces separately. Also because I like to keep things minimal.

## Philosophy - should you use this plugin?

This plugin was written in an attempt to be simple enough that users could make any changes directly
to it. I believe that this gives users more control and a wider range of possible changes. In
addition, the script has comments that help to make some customizations (for example, to creating
[custom pairs](https://github.com/jpaulogg/vim-simplified-surround/blob/2ba2a950f5228ce0ad088602fe38659cea19dd37/surround.vim#L31-L33).
It's almost as simple as doing it in your vimrc.

If you prefere something that provides global variables and options that you can set from
your vimrc, you should keep Tpope's [vim-surround](https://github.com/tpope/vim-surround).

## Usage

#### visual mode

`S{char}` surrounds from start of selection to cursor position with `{char}`.

#### normal mode

`ys{motion}{char}` surrounds `{motion}` with `{char}`.

`ds{char}` deletes surrounding `{char}`.

`cs{char1}{char2}` changes surrounding `{char1}` with `{char2}`.

See the examples above:

| input tex  | key sequence  | output text  |  mode  |
|------------|---------------|--------------|--------|
|`foo`       |`ysiw)`        |`(foo)`       | normal |
|`foo`       |`viwS(`        |`(foo)`       | visual |
|`foo`       |`ysiw).<Space>`|`( foo )`     | normal |
|`( foo )`   |`ds<Space>`    |`(foo)`       | normal |
|`(foo)`     |`cs)}`         |`{foo}`       | normal |
|`whole line`|`0ys$"`        |`"whole line"`| normal |
|`whole line`|`V$S"`         |`"whole line"`| visual |

## Main differences from Tpope's surround.vim

- no complex operations with tags, functions and things like that.
- `ysiw(` is the same of `ysiw)`.
- doesn't support repeating `ds` and `cs` operations with `.` command.
- cursor positions after operations.
- this version has ~90 lines of code, while Tpope's plugin has ~590 lines of code. 

## Tips

- you can repeat `ys` operations with `.` but using a different surrounding pair.
- you can use spaces as surrounding pairs.
- create [custom pairs](https://github.com/jpaulogg/vim-simplified-surround/blob/2ba2a950f5228ce0ad088602fe38659cea19dd37/surround.vim#L31-L33)
  to surround with more than one character at once.
- or use abbreviations (this one can work by file type).
- it's very easy to make any changes directly to the script (for example, to cursor positions).

## Installation

You can simply copy surround.vim to your runtime. From the shell:

```bash
# in vim use '~/.vim/' instead of '~/.config/nvim'
curl -fLo ~/.config/nvim/plugin/vim-simplified-surround --create-dirs \
	https://raw.githubusercontent.com/jpaulogg/vim-simplified-surround/master/surround.vim
```

If you prefer use (Neo)Vim's built-in package support.

```bash
# in vim use '~/.vim/' instead of '~/.config/nvim'
curl -fLo ~/.config/nvim/pack/any/start/vim-simplified-surround/plugin/surround.vim \
	--create-dirs \
	https://raw.githubusercontent.com/jpaulogg/vim-simplified-surround/master/surround.vim 
```
