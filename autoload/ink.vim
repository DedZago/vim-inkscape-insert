let g:inkscape_graphs_dir = "./Images/"

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
			exe ":!cp ~/.config/inkscape/templates/default.svg" g:inkscape_graphs_dir . a:image
		elseif filereadable("/usr/share/inkscape/templates/default.svg")
			exe ":!cp /usr/share/inkscape/templates/default.svg" g:inkscape_graphs_dir . a:image
		else 
			finish
		endif
		exe ":!inkscape" g:inkscape_graphs_dir . a:image
	endfunction
endif

if has('win32')
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
		if filereadable(expand("\%USERPROFILE\%\\AppData\\Roaming\\inkscape\\templates\\default.svg"))
			exe ":!copy \%USERPROFILE\%\\AppData\\Roaming\\inkscape\\templates\\default.svg" g:inkscape_graphs_dir . a:image
		else 
			finish
		endif
		exe ":!inkscape" g:inkscape_graphs_dir . a:image
	endfunction
endif
