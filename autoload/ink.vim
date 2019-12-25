if has('unix')
	function! ink#Ink(image)
		if getcwd() !~ expand("%:p:h")
			cd %:p:h
		endif
		if !isdirectory(g:inkscape_graphs_dir)
		    call mkdir(g:inkscape_graphs_dir, "p")
		endif
		let b:inline = '\begin{figure}[htbp]
		\\centering
		\\includegraphics[width=0.9\textwidth]{' . g:inkscape_graphs_dir . a:image . '.png}
		\\end{figure}'
		call append(line('.'),b:inline)
		normal jo
		if filereadable(expand("~/.config/inkscape/templates/default.svg"))
			exe ":!cp ~/.config/inkscape/templates/default.svg" g:inkscape_graphs_dir . a:image . ".svg"
		elseif filereadable("/usr/share/inkscape/templates/default.svg")
			exe ":!cp /usr/share/inkscape/templates/default.svg" g:inkscape_graphs_dir . a:image . ".svg"
		else 
			finish
		endif
		exe ":!export PATH=/usr/bin/:${PATH} && inkscape" g:inkscape_graphs_dir . a:image . ".svg"
		exe ":!inkscape" g:inkscape_graphs_dir . a:image . ".svg" "-e" g:inkscape_graphs_dir . a:image . ".png" "--without-gui" "-D"
	endfunction
endif

if has('win32')
let g:inkscape_graphs_dir = "/Images/"
	function! ink#Ink(image)
		if getcwd() !~ expand("%:p:h")
			cd %:p:h
		endif
		if !isdirectory(g:inkscape_graphs_dir)
		    call mkdir(%:p:h . g:inkscape_graphs_dir, "p")
		endif
		let b:inline = '\begin{figure}[htbp]
		\\centering
		\\includegraphics[width=0.9\textwidth]{' . g:inkscape_graphs_dir . a:image . '.png}
		\\end{figure}'
		call append(line('.'),b:inline)
		normal jo
		if filereadable(shellescape("%USERPROFILE%/AppData/Roaming/inkscape/templates/default.svg", 1))
			exe ":!copy" shellescape("%USERPROFILE%/AppData/Roaming/inkscape/templates/default.svg", 1) %:p:h . g:inkscape_graphs_dir . a:image
		else 
			finish
		endif
		exe ":!inkscape" %:p:h . g:inkscape_graphs_dir . a:image
	endfunction
endif
