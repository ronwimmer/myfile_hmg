#include "hmg.ch"

declare window contato

Function contato_form_oninit

	// cIdSelecionado
	
	if posiciona_selecionado()
		alimenta_form()
	endif

Return Nil
