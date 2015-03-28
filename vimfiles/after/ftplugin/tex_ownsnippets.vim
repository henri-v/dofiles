if !exists('loaded_snippet') || &cp
	finish
endif

Snippet figure % {{{ fig:<{figname}><CR>\begin{figure}<CR>\begin{center}<CR>
	\\includegraphics[width=<{width}>]{<{figname}>}<CR>
	\\caption{<{caption}>}<CR>\label{fig:<{figname}>}<CR>
	\\end{center}<CR>\end{figure}<CR>% }}}<CR><{}>
