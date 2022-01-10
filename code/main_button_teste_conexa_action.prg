#include "hmg.ch"

declare window Main

Function main_button_teste_conexa_action

	if MySQL_Connect()
		if MySQL_Database_Connect()
			MsgInfo( "Conexão com banco OK", "SQL" )
		else
			MsgStop( "Banco de dados [" + database + "] não localizado!", "SQL" )
		endif
		MySQL_Destroy()
	else
		MsgStop( "Conexão com banco não OK", "SQL" )
	endif

Return Nil
