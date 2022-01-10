#include <hmg.ch>

/*********************************************************************************************
*
*   Função para conectar com o servidor de bancos de dados
*
*/
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

/*********************************************************************************************
*
*   Função para destruir a conexão com o servidor de bancos de dados
*
*/
function MySQL_Destroy()

	if (oServer != NIL)
		oServer:Destroy()
		oServer := NIL
	endif

return .T.

/*********************************************************************************************
*
*   Função para conectar com o banco de dados
*
*/
function MySQL_Database_Connect( cDataBase )

	local aDataBaseList := {}
	local bSucesso := .F.
	
	cDataBase := iif( cDataBase == NIL, database, cDataBase )
	
	if (oServer == NIL)
		MsgStop("Servidor não conectado!", "SQL")
		return bSucesso
	endif
	
	aDataBaseList := oServer:ListDbs()
	
	if (oServer:NetErr())
		MsgStop("Erro verificando lista de bancos de dados: " + oServer:Error(), "SQL")
		return bSucesso
	endif
	
	if ( aScan( aDataBaseList, cDataBase ) == 0 )
		MsgStop("Banco de Dados " + cDataBase + " não existe!", "SQL" )
		return bSucesso
	endif
	
	oServer:SelectDb(cDataBase)
	
	if (oServer:NetErr())
		MsgStop("Erro conectando no banco de dados " + cDataBase + ": " + oServer:Error(), "SQL")
		return bSucesso
	endif
	
	bSucesso := .T.

return bSucesso

/*********************************************************************************************
*
*   Função para executar comandos no MySQL que não retornam registros (INSERT, UPDATE, etc)
*
*/
function MySQL_Exec( oServer, cQuery )

	local oQuery
	local bSucesso := .F.
	
	if ( oServer == NIL )
		MsgStop( "Erro: sem conexão com o servidor!", "SQL" )
		return bSucesso
	endif
	
	if ( cQuery == NIL )
		cQuery := ""
	endif

	if ( empty( cQuery ) )
		MsgStop( "Erro: Query não definida!", "SQL" )
		return bSucesso
	endif
	
	oQuery := oServer:Query( cQuery )
	
	if ( oQuery:NetErr() )
		MsgStop( "Erro: " + oQuery:Error(), "SQL" )
		return bSucesso
	endif
	
	bSucesso := .T.
	
return bSucesso

/*********************************************************************************************
*
*   Função para executar comandos no MySQL que retornam registros (SELECT)
*
*/
function MySQL_ExecQuery( oServer, cQuery )

	local oQuery, oRow, i, j, campo
	local aTable := {}
	local aRow := {}
	
	if ( oServer == NIL )
		MsgStop( "Erro: sem conexão com o servidor!", "SQL" )
		return aTable
	endif
	
	if ( cQuery == NIL )
		cQuery := ""
	endif
	
	if ( empty( cQuery ) )
		MsgStop( "Erro: Query não definida!", "SQL" )
		return aTable
	endif
	
	oQuery := oServer:Query( cQuery )

	if ( oQuery:NetErr() )
		MsgStop( "Erro: " + oQuery:Error(), "SQL" )
		return aTable
	else
		if (oQuery:LastRec() > 0)
			aSize( aTable, 0 )
			for i := 1 to oQuery:LastRec()
				aSize( aRow, 0 )
				oRow := oQuery:GetRow(i)
				for j := 1 to oQuery:fCount()
					if (ValType(oRow:FieldGet(j)) == "C")
						campo := AllTrim(oRow:FieldGet(j))
					else
						campo := oRow:FieldGet(j)
					endif
					aAdd( aRow, campo )
				next
				aAdd( aTable, aClone( aRow ) )
			next
		endif
	endif
	
return aTable
