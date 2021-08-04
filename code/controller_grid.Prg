#include <hmg.ch>

declare window grid_contatos

function mostra_grid_contato()

	if IsWindowActive(grid_contatos)
		doMethod("grid_contatos","MINIMIZE")
		doMethod("grid_contatos","RESTORE")
		doMethod("grid_contatos","SETFOCUS")
	else
		load window grid_contatos
		activate window grid_contatos
	endif
	
return NIL
