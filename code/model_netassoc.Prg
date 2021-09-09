#include <hmg.ch>

function abre_arquivo()

	dbUseArea( .T., "DBFNTX", "NETASSOC" )
	NETASSOC->( dbSetIndex( "MK_ASS" ))
	NETASSOC->( dbSetIndex( "NK_ASS" ))
	
return NIL

function fecha_arquivo()

	NETASSOC->( dbCloseArea() )
	
return NIL

function le_dados( aDados )

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

return NIL

function carrega_grid( aGrid, cPesquisa, nChave )

	local aDados := {}
	local bFiltro
	
	aGrid := {}
	
	if cPesquisa == NIL .or. nChave == NIL .or. empty( cPesquisa )
		bFiltro := { || .T. }
	elseif nChave == 1    // ID
		bFiltro := { || Val( aDados[01] ) == Val( cPesquisa ) }
	elseif nChave == 2    // NOME
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[03] ) }
	elseif nChave == 3    // EMPRESA
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[02] ) }
	elseif nChave == 4    // ENDERECO
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[06] ) }
	elseif nChave == 5    // CIDADE
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[08] ) }
	elseif nChave == 6    // ESTADO
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[10] ) }
	elseif nChave == 7    // DOCUMENTO
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[05] ) }
	elseif nChave == 8    // ANIVERSARIO
		bFiltro := { || Upper( cPesquisa ) $ Upper( aDados[04] ) }
	endif
		
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
	
return NIL

function posiciona_selecionado()
return NETASSOC->( dbSeek( cIdSelecionado ))
