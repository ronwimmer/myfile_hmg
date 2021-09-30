#include "hmg.ch"

declare window grid_contatos

Function grid_contatos_form_onrelease

	fecha_grid()
	cIdSelecionado := ""
	
	doMethod("Main","MINIMIZE")
	doMethod("Main","RESTORE")
	doMethod("Main","SETFOCUS")
	
Return Nil
