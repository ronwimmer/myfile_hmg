#include "hmg.ch"

declare window historico

Function historico_form_oninit

	setProperty( "historico", "Text_idchave", "Enabled", .F. )
	setProperty( "historico", "Text_nome", "Enabled", .F. )

	if ! empty( cIdSelecionado )
		if posiciona_selecionado()
			alimenta_historico()
		endif
	endif

Return Nil
