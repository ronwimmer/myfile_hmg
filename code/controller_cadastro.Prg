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

function alimenta_form( cLimpo )

	local aDados := {}
	local aDados1 := {}

	if cLimpo == NIL
		le_dados( @aDados1 )
		aDados := aDados1[01]

	elseif cLimpo == "limpo"
		aDados := Array(17)

		aDados[01] := Space(7)
		aDados[02] := Space(40)
		aDados[03] := Space(40)
		aDados[04] := Space(10)
		aDados[05] := Space(40)
		aDados[06] := Space(40)
		aDados[07] := Space(30)
		aDados[08] := Space(30)
		aDados[09] := Space(9)
		aDados[10] := Space(22)
		aDados[11] := Space(30)
		aDados[12] := Space(30)
		aDados[13] := Space(45)
		aDados[14] := Space(44)
		aDados[15] := Space(45)
		aDados[16] := Space(10)
		aDados[17] := Space(100)
	endif

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

function alimenta_array()

	local aDados := array(17)
	
	aDados[01] := getProperty("contato", "Text_idchave"         , "Value" )
	aDados[02] := getProperty("contato", "Text_empresa"         , "Value" )
	aDados[03] := getProperty("contato", "Text_nome"            , "Value" )
	aDados[04] := getProperty("contato", "Text_data_aniversario", "Value" )
	aDados[05] := getProperty("contato", "Text_documento"       , "Value" )
	aDados[06] := getProperty("contato", "Text_endereco"        , "Value" )
	aDados[07] := getProperty("contato", "Text_bairro"          , "Value" )
	aDados[08] := getProperty("contato", "Text_cidade"          , "Value" )
	aDados[09] := getProperty("contato", "Text_cep"             , "Value" )
	aDados[10] := getProperty("contato", "Text_uf"              , "Value" )
	aDados[11] := getProperty("contato", "Text_fone1"           , "Value" )
	aDados[12] := getProperty("contato", "Text_fone2"           , "Value" )
	aDados[13] := getProperty("contato", "Text_email"           , "Value" )
	aDados[14] := getProperty("contato", "Text_site"            , "Value" )
	aDados[15] := getProperty("contato", "Text_skype"           , "Value" )
	aDados[16] := getProperty("contato", "Text_cadastro"        , "Value" )
	aDados[17] := getProperty("contato", "Text_historico"       , "Value" )
	
	grava_dados( aDados )
	
return NIL
