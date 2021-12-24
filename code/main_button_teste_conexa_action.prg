#include "hmg.ch"

declare window Main

Function main_button_teste_conexa_action

	if MySQL_Connect()
		MsgInfo( "Conexão com banco OK", "SQL" )
		MySQL_Destroy()
	else
		MsgStop( "Conexão com banco não OK", "SQL" )
	endif

Return Nil
