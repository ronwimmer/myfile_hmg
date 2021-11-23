#include "hmg.ch"

declare window impressao

Function impressao_button_cancela_action

	doMethod("impressao","RELEASE")
	
Return Nil
