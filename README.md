# vim-inkscape-insert

A plugin to create and insert drawings (in .pdf_tex format) in latex files and 
edit them in inkscape without leaving vim.

The only command is :Ink \<name of the graph you want to add\>. It saves all 
the images created by the Ink command in the directory specified with 
g:inkscape_graphs_dir (default "./Images/")

