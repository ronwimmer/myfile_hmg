#include "hmg.ch"

declare window historico

Function historico_button_alterar_action

	alimenta_array_historico()
	doMethod( "historico", "RELEASE" )

Return Nil
