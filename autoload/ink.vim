if has('unix')
let g:inkscape_graphs_dir = "./Images/"
	function! ink#Ink(image)
		if getcwd() !~ expand("%:p:h")
			cd %:p:h
		endif
		if !isdirectory(g:inkscape_graphs_dir)
		    call mkdir(g:inkscape_graphs_dir, "p")
		endif
		let b:inline = '\begin{figure}[htbp]\n
		\\centering \n
		\\input{'. g:inkscape_graphs_dir . a:image . '.pdf_tex} \n
		\\caption{} \n
		\\label{fig:} \n
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
		exe ":!inkscape" g:inkscape_graphs_dir . a:image . ".svg" "--export-pdf=" . g:inkscape_graphs_dir . a:image . ".pdf" "--without-gui" "--export-latex" "-D"
	endfunction
endif

if has('win32')
let g:inkscape_graphs_dir = "\\Images\\"
	function! ink#Ink(image)
		let b:inline = '\begin{figure}[htbp]
		\\centering		
		\\input{' . './Images/' . a:image . '.pdf_tex}
		\\caption{}
		\\label{fig:}
		\\end{figure}'
		call append(line('.'),b:inline)
		normal jo
		
		exe ":!copy" expand("%:p:h") . g:inkscape_graphs_dir . "default.svg" expand("%:p:h") . g:inkscape_graphs_dir . a:image . ".svg"
		exe ":!inkscape" expand("%:p:h") . g:inkscape_graphs_dir . a:image . ".svg"
		exe ":!inkscape" expand("%:p:h") . g:inkscape_graphs_dir . a:image . ".svg" "--export-pdf=" . expand("%:p:h") . g:inkscape_graphs_dir . a:image . ".pdf" "--export-latex" "--without-gui" "-D"
	endfunction
endif
