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

function alimenta_historico()

	local aDados := {}
	
	le_dados( @aDados )

	setProperty("historico", "Text_idchave"         , "Value", aDados[01] )
	setProperty("historico", "Text_nome"            , "Value", aDados[03] )
	setProperty("historico", "Edit_historico"       , "Value", aDados[17] )

return NIL

function alimenta_array_historico()

	local aDados := array(3)
	
	aDados[01] := getProperty("historico", "Text_idchave"         , "Value" )
	aDados[02] := getProperty("historico", "Text_nome"            , "Value" )
	aDados[03] := getProperty("historico", "Edit_historico"       , "Value" )
	
	grava_dados( aDados )
	
return NIL
