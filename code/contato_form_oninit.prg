#include "hmg.ch"

declare window contato

Function contato_form_oninit

	setProperty( "contato", "Text_idchave", "Enabled", .F. )
	setProperty( "contato", "Text_cadastro", "Enabled", .F. )

	if empty( cIdSelecionado )
		setProperty( "contato", "Frame_historico", "Visible", .T. )
		setProperty( "contato", "Text_historico", "Visible", .T. )
		abre_arquivo()
		carrega_limpo()
	else
		setProperty( "contato", "Frame_historico", "Visible", .F. )
		setProperty( "contato", "Text_historico", "Visible", .F. )
		if posiciona_selecionado()
			alimenta_form()
		endif
	endif
	
Return Nil
