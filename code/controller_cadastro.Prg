#include <hmg.ch>

declare window contato

function mostra_contato()

	if IsWindowActive(contato)
		doMethod("contato","MINIMIZE")
		doMethod("contato","RESTORE")
		doMethod("contato","SETFOCUS")
	else
		load window contato
		activate window contato
	endif

return NIL

function alimenta_form()

	local aDados := {}
	
	le_dados( @aDados )

	setProperty("contato", "Text_idchave"         , "Value", aDados[01] )
	setProperty("contato", "Text_empresa"         , "Value", aDados[02] )
	setProperty("contato", "Text_nome"            , "Value", aDados[03] )
	setProperty("contato", "Text_data_aniversario", "Value", aDados[04] )
	setProperty("contato", "Text_documento"       , "Value", aDados[05] )
	setProperty("contato", "Text_endereco"        , "Value", aDados[06] )
	setProperty("contato", "Text_bairro"          , "Value", aDados[07] )
	setProperty("contato", "Text_cidade"          , "Value", aDados[08] )
	setProperty("contato", "Text_cep"             , "Value", aDados[09] )
	setProperty("contato", "Text_uf"              , "Value", aDados[10] )
	setProperty("contato", "Text_fone1"           , "Value", aDados[11] )
	setProperty("contato", "Text_fone2"           , "Value", aDados[12] )
	setProperty("contato", "Text_email"           , "Value", aDados[13] )
	setProperty("contato", "Text_site"            , "Value", aDados[14] )
	setProperty("contato", "Text_skype"           , "Value", aDados[15] )
	setProperty("contato", "Text_cadastro"        , "Value", aDados[16] )
	setProperty("contato", "Text_historico"       , "Value", aDados[17] )

return NIL
