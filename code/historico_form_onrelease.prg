#include "hmg.ch"

declare window historico

Function historico_form_onrelease

	doMethod("Main","MINIMIZE")
	doMethod("grid_contatos","MINIMIZE")
	doMethod("grid_contatos","RESTORE")
	doMethod("grid_contatos","SETFOCUS")

Return Nil
