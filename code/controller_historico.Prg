#include <hmg.ch>

declare window historico

function mostra_historico()

	if IsWindowActive(historico)
		doMethod("historico","MINIMIZE")
		doMethod("historico","RESTORE")
		doMethod("historico","SETFOCUS")
	else
		load window historico
		activate window historico
	endif

return NIL
