#include <hmg.ch>

function abre_arquivo()

	//dbUseArea( .T., "DBFNTX", "NETASSOC" )
	//NETASSOC->( dbSetIndex( "MK_ASS" ))
	//NETASSOC->( dbSetIndex( "NK_ASS" ))

	MySQL_Connect()
	MySQL_Database_Connect()
	
return NIL

function fecha_arquivo()

	//NETASSOC->( dbCloseArea() )
	MySQL_Destroy()
	
return NIL

function le_dados( aDados, cChave )

	local cQuery

	cQuery := "SELECT idchave, razao, nome, dt_nasc, documento, end_rua, end_bairro, "
	cQuery := cQuery + "end_cidade, end_cep, end_uf, fone_res, fone_cel, end_email, "
	cQuery := cQuery + "web_site, num_icq, cadastro, detalhe "
	cQuery := cQuery + "FROM netassoc "

    if ! empty( cChave )
		cQuery := cQuery + "WHERE " + cChave
		if ! empty( cIdSelecionado )
			cQuery := cQuery + " AND idchave = '" + str(val(cIdSelecionado),7) + "'"
		endif
	else
		if ! empty( cIdSelecionado )
			cQuery := cQuery + " WHERE idchave = '" + str(val(cIdSelecionado),7) + "'"
		endif
	endif

	aDados := MySQL_ExecQuery( oServer, cQuery )

	/*
	aDados := { ;
		NETASSOC->IDCHAVE,;
		NETASSOC->RAZAO,;
		NETASSOC->NOME,;
		NETASSOC->DT_NASC,;
		NETASSOC->DOCUMENTO,;
		NETASSOC->END_RUA,;
		NETASSOC->END_BAIRRO,;
		NETASSOC->END_CIDADE,;
		NETASSOC->END_CEP,;
		NETASSOC->END_UF,;
		NETASSOC->FONE_RES,;
		NETASSOC->FONE_CEL,;
		NETASSOC->END_EMAIL,;
		NETASSOC->WEB_SITE,;
		NETASSOC->NUM_ICQ,;
		NETASSOC->CADASTRO,;
		NETASSOC->DETALHE,;
	}
	*/

return NIL

function carrega_grid( aGrid, cPesquisa, nChave )

	local aDados := {}
	//local bFiltro
	local cChave, nI

	aGrid := {}
	
	if cPesquisa == NIL .or. nChave == NIL .or. empty( cPesquisa )
		//bFiltro := { || .T. }
		cChave := " "
	elseif nChave == 1    // ID
		//bFiltro := { || Val( aDados[01] ) == Val( cPesquisa ) }
		cChave := "idchave LIKE '%" + alltrim(cPesquisa) + "%'"
	elseif nChave == 2    // NOME
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[03] ) }
		cChave := "upper(nome) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	elseif nChave == 3    // EMPRESA
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[02] ) }
		cChave := "upper(razao) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	elseif nChave == 4    // ENDERECO
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[06] ) }
		cChave := "upper(end_rua) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	elseif nChave == 5    // CIDADE
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[08] ) }
		cChave := "upper(end_cidade) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	elseif nChave == 6    // ESTADO
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[10] ) }
		cChave := "upper(end_uf) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	elseif nChave == 7    // DOCUMENTO
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[05] ) }
		cChave := "upper(documento) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	elseif nChave == 8    // ANIVERSARIO
		//bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[04] ) }
		cChave := "upper(dt_nasc) LIKE '%" + upper(alltrim(cPesquisa)) + "%'"
	endif

	/*
	NETASSOC->( dbGotop() )
	
	while ! NETASSOC->( eof() )
		le_dados( @aDados )
		
		if Eval( bFiltro )
			aAdd( aGrid, {;
				aDados[01],;
				aDados[03],;
				aDados[02],;
				aDados[06],;
				aDados[08],;
				aDados[10],;
				aDados[05],;
				aDados[04] } )
		endif
		
		NETASSOC->( dbSkip() )
	enddo
	*/

	le_dados( @aDados, cChave )

	for nI := 1 to len( aDados )
		aAdd( aGrid, {;
			aDados[nI][01],;
			aDados[nI][03],;
			aDados[nI][02],;
			aDados[nI][06],;
			aDados[nI][08],;
			aDados[nI][10],;
			aDados[nI][05],;
			aDados[nI][04] } )
	next
	
return NIL

function posiciona_selecionado()
//return NETASSOC->( dbSeek( cIdSelecionado ))
return .T.

function carrega_limpo()

	//NETASSOC->( dbGoBottom() )
	//NETASSOC->( dbSkip() )
	alimenta_form( "limpo" )
	
return NIL

function grava_dados( aDados )

	local lSucesso := .F.
	local cQuery, aProximo

	if empty( aDados[01] )
		cQuery := "SELECT max(IdChave) AS PROXIMO FROM netassoc"
		aProximo := MySQL_ExecQuery( oServer, cQuery )
		aDados[01] := str( val( aProximo[01][01] ) + 1, 7 )
		aDados[16] := dtoc( date() )
		aDados[17] := aDados[16] + " ... " + aDados[17]

		cQuery := "INSERT INTO netassoc (Idchave, Razao, Nome, Dt_nasc, Documento, End_rua, End_bairro, End_cidade, End_cep, End_uf, Fone_res, Fone_cel, End_email, Web_site, Num_icq, Cadastro, Detalhe) VALUES ('"
		cQuery := cQuery + aDados[01] + "', '"
		cQuery := cQuery + aDados[02] + "', '"
		cQuery := cQuery + aDados[03] + "', '"
		cQuery := cQuery + dtoc( ctod( alltrim( aDados[04] ))) + "', '"
		cQuery := cQuery + aDados[05] + "', '"
		cQuery := cQuery + aDados[06] + "', '"
		cQuery := cQuery + aDados[07] + "', '"
		cQuery := cQuery + aDados[08] + "', '"
		cQuery := cQuery + aDados[09] + "', '"
		cQuery := cQuery + aDados[10] + "', '"
		cQuery := cQuery + aDados[11] + "', '"
		cQuery := cQuery + aDados[12] + "', '"
		cQuery := cQuery + aDados[13] + "', '"
		cQuery := cQuery + aDados[14] + "', '"
		cQuery := cQuery + aDados[15] + "', '"
		cQuery := cQuery + dtoc( ctod( alltrim( aDados[16] ))) + "', '"
		cQuery := cQuery + aDados[17] + "')"

		//NETASSOC->( dbGoBottom() )
		//aDados[01] := str( val( NETASSOC->IDCHAVE ) + 1, 7 )
		//aDados[16] := dtoc( date() )
		//aDados[17] := aDados[16] + " ... " + aDados[17]
		//lSucesso := NETASSOC->( dbAppend() )
	else
		//lSucesso := NETASSOC->( RLock() )
		if len( aDados ) == 17
			cQuery := "UPDATE netassoc SET Razao = '" + aDados[02] + "', Nome = '"
			cQuery := cQuery + aDados[03] + "', Dt_nasc = '"
			cQuery := cQuery + dtoc( ctod( alltrim( aDados[04] ))) + "', Documento = '"
			cQuery := cQuery + aDados[05] + "', End_rua = '"
			cQuery := cQuery + aDados[06] + "', End_bairro = '"
			cQuery := cQuery + aDados[07] + "', End_cidade = '"
			cQuery := cQuery + aDados[08] + "', End_cep = '"
			cQuery := cQuery + aDados[09] + "', End_uf = '"
			cQuery := cQuery + aDados[10] + "', Fone_res = '"
			cQuery := cQuery + aDados[11] + "', Fone_cel = '"
			cQuery := cQuery + aDados[12] + "', End_email = '"
			cQuery := cQuery + aDados[13] + "', Web_site = '"
			cQuery := cQuery + aDados[14] + "', Num_icq = '"
			cQuery := cQuery + aDados[15] + "', Cadastro = '"
			cQuery := cQuery + dtoc( ctod( alltrim( aDados[16] ))) + "', Detalhe = '"
			cQuery := cQuery + aDados[17] + "' WHERE Idchave = '" + str(val(aDados[01]),7) + "'"
		else
			cQuery := "UPDATE netassoc SET Detalhe = '"
			cQuery := cQuery + aDados[03] + "' WHERE Idchave = '" + str(val(aDados[01]),7) + "'"
		endif
	end if

	lSucesso := MySQL_Exec( oServer, cQuery )

	/*
	if lSucesso
		if len( aDados ) == 17
			NETASSOC->IDCHAVE    := aDados[01]
			NETASSOC->RAZAO      := aDados[02]
			NETASSOC->NOME       := aDados[03]
			NETASSOC->DT_NASC    := dtoc( ctod( alltrim( aDados[04] )))
			NETASSOC->DOCUMENTO  := aDados[05]
			NETASSOC->END_RUA    := aDados[06]
			NETASSOC->END_BAIRRO := aDados[07]
			NETASSOC->END_CIDADE := aDados[08]
			NETASSOC->END_CEP    := aDados[09]
			NETASSOC->END_UF     := aDados[10]
			NETASSOC->FONE_RES   := aDados[11]
			NETASSOC->FONE_CEL   := aDados[12]
			NETASSOC->END_EMAIL  := aDados[13]
			NETASSOC->WEB_SITE   := aDados[14]
			NETASSOC->NUM_ICQ    := aDados[15]
			NETASSOC->CADASTRO   := dtoc( ctod( alltrim( aDados[16] )))
			NETASSOC->DETALHE    := aDados[17]
		else
			NETASSOC->DETALHE    := aDados[03]
		endif
		
		NETASSOC->( dbUnlock() )
	endif
	*/

return lSucesso

function carrega_relat( aDados )

	local aRegistro := {}
	
	aDados := {}

	le_dados( @aDados )

	/*
	NETASSOC->( dbGotop() )
	while ! NETASSOC->( eof() )
		le_dados( @aRegistro )
		aAdd( aDados, aRegistro )
	
		NETASSOC->( dbSkip() )
	enddo
	*/

return NIL
