#include <hmg.ch>

function MySQL_Connect( cHostName, cUserName, cPassWord )

	cHostName := iif( cHostName == NIL, hostName, cHostName )
	cUserName := iif( cUserName == NIL, userName, cUserName )
	cPassWord := iif( cPassWord == NIL, passWord, cPassWord )
	
	oServer := TMySQLServer():New( cHostName, cUserName, cPassWord )
	
	if (oServer:NetErr())
		MsgStop( "Erro ao conectar!" + chr(13) + chr(10) + "(" + oServer:Error() + ")" + chr(13) + chr(10) + ;
		         "Server: " + cHostName + chr(13) + chr(10) + ;
				 "User: " + cUserName + chr(13) + chr(10), "SQL" )
		return .F.
	endif

return .T.

function MySQL_Destroy()

	if (oServer != NIL)
		oServer:Destroy()
		oServer := NIL
	endif

return .T.
