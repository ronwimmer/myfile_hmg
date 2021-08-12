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

function carrega_grid( aGrid )

	local aDados := {}
	
	aGrid := {}
	
	NETASSOC->( dbGotop() )
	
	while ! NETASSOC->( eof() )
		le_dados( @aDados )
		
		aAdd( aGrid, {;
			aDados[01],;
			aDados[03],;
			aDados[02],;
			aDados[06],;
			aDados[08],;
			aDados[10],;
			aDados[05],;
			aDados[04] } )
		
		NETASSOC->( dbSkip() )
	enddo
	
return NIL
