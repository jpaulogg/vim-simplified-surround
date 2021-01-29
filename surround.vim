" vim: set noet fdm=marker :
" zR to open and zM to close all folds
"
" surround.vim - <https://github.com/jpaulogg/vim-simplified-surround.git>
" Licence: public domain
" Last Change: 2021/01/22  

" Very simplified version of Tpope's vim-surround.

if exists('g:loaded_simplified_surround')
	finish
endif
let g:loaded_simplified_surround = 1

" mapping
nmap <silent> ys <Cmd>set  opfunc=<SID>SurroundMotion<CR>g@
xmap <silent> S  <Cmd>set  opfunc=<SID>SurroundMotion<CR>g@
nmap <silent> ds <Cmd>call <SID>DeleteSurrounding(getchar())<CR>
nmap <silent> cs <Cmd>call <SID>ChangeSurround(getchar(), getchar())<CR>

" pairs {{{1
function s:MatchPairs(char_nr)
	if a:char_nr == 40 || a:char_nr == 41        " '(' or ')'
		return ['(', ')']
	elseif a:char_nr == 60	|| a:char_nr == 62   " '<' or '>'
		return ['<', '>']
	elseif a:char_nr == 91	|| a:char_nr == 93   " '[' or ']'
		return ['[', ']']
	elseif a:char_nr == 123 || a:char_nr == 125  " '{' or '}'
		return ['{', '}']
	" you can create custom pairs. Get character number with char2nr() function. For example:
	" elseif a:char_nr == 96                     " `
	" 	return ['```', '```']
	else                                         " when pairs are the same (quotes, spaces, etc)
		return [nr2char(a:char_nr), nr2char(a:char_nr)]
	endif
endfunction

function s:SurroundMotion(type, ...)                        " {{{1
	let [open_char, close_char] = s:MatchPairs(getchar())
	let motion_start = [line("'["), col("'[")]
	let motion_end   = [line("']"), col("']")]

	call cursor(motion_end)
	exec 'normal a'.close_char."\<Esc>"
	let save_pos = [line('.'), col('.')]
	call cursor(motion_start)
	exec 'normal i'.open_char."\<Esc>"

	call cursor(save_pos)
endfunction

function s:DeleteSurrounding(char_nr)                       " {{{1
	let pos = s:PairPosition(a:char_nr)
	if pos.open == [0, 0] || pos.close == [0, 0]
		return
	endif

	" cursor already in pos.close
	normal x
	call cursor(pos.open)
	normal x

	call cursor(pos.save)
endfunction

function s:ChangeSurround(old_nr, new_nr)                   " {{{1
	let pos = s:PairPosition(a:old_nr)
	if pos.open == [0, 0] || pos.close == [0, 0]
		return
	endif
	let [new_open, new_close] = s:MatchPairs(a:new_nr)

	" cursor already in pos.close
	exec 'normal r'.new_close
	call cursor(pos.open)
	exec 'normal r'.new_open

	call cursor(pos.save)
endfunction

function s:PairPosition(char_nr)                            " {{{1
	let pos = {}
	let pos.save = [line('.'), col('.')]

	let [open_char, close_char] = s:MatchPairs(a:char_nr)
	let open_pat  = '\M'.open_char        " no 'magic' regex
	let close_pat = '\M'.close_char

	" searchpairpos doesn't work when open_char is equal to close_char (quotes, for example)
	if open_char == close_char
		let pos.open  = searchpos(open_pat,  'bc')
		let pos.close = searchpos(close_pat, 'z')
	else
		let pos.open = searchpairpos(open_pat, '', close_pat, 'b')

		if pos.open == [0, 0]
			let pos.open = searchpairpos(open_pat, '', close_pat, 'bc')
		endif

		let pos.close = searchpairpos(open_pat, '', close_pat)
	endif
	
	return pos
endfunction
