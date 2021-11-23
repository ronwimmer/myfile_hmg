#include <hmg.ch>

declare window impressao

public cTipo

function imprHtml()

	cTipo := "html"
	mostra_impressao()
	
return NIL

function imprTxt()

	cTipo := "txt"
	mostra_impressao()
	
return NIL

function mostra_impressao()

	if IsWindowActive(impressao)
		doMethod("impressao","MINIMIZE")
		doMethod("impressao","RESTORE")
		doMethod("impressao","SETFOCUS")
	else
		load window impressao
		activate window impressao
	endif

return NIL

function gera_impressao()

	local cArquivo := "relat." + cTipo
	local cCaminho := diskname() + ":\" + curdir()
	local aDados   := {}
	local cCrLf    := chr(13) + chr(10)
	local nI
	
	cArquivo := cCaminho + "\" + cArquivo
	
	if file( cArquivo )
		erase cArquivo
	endif
	
	abre_arquivo()
	carrega_relat( @aDados )
	fecha_arquivo()
	
	if len( aDados ) == 0
		MsgExclamation( cArquivo + cCrLf + cCrLf + "NÃO EXISTEM DADOS A APRESENTAR!", "Atenção" )
	else
	
		set( _SET_DEVICE, "PRINTER" )
		set( _SET_PRINTFILE, cArquivo )
		set( _SET_PRINTER, .T. )
		
		if cTipo == "txt"

			? date()
			?? " - Listagem de Contatos Cadastrados"
			? replicate("-",80)
			
			for nI := 1 to len(aDados)
				? " Chave ID: " + aDados[nI][1] + " Documento: "+ alltrim(aDados[nI][5])
				? "Data Aniv: " + aDados[nI][4]
				? "  Contato: " + alltrim(aDados[nI][3])
				? "  Empresa: " + alltrim(aDados[nI][2])
				? " Endereco: " + alltrim(aDados[nI][6])
				? "           " + alltrim(aDados[nI][7]) +" - "+  alltrim(aDados[nI][8])
				? "           " + alltrim(aDados[nI][10]) +" - "+aDados[nI][9]
				? "   Fone_1: " + alltrim(aDados[nI][11])
				? "   Fone_2: " + alltrim(aDados[nI][12])
				? "   e-mail: " + alltrim(aDados[nI][13])
				? "    Skype: " + alltrim(aDados[nI][15])
				? "     Site: " + alltrim(aDados[nI][14])
				? replicate("-",80)
			next
		
		elseif cTipo == "html"
		
			? [<html>]
			? [<head>]
			? [<title>Listagem de Contatos Cadastrados</title>]
			? [<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">]
			? [</head>]
			? [<body bgcolor="#FFFFFF" text="#000000" link="#0000FF" alink="#00CC00" vlink="#FF0000" leftMargin=0 topMargin=0 marginwidth=0 marginheight=0>]
			? [<table width="701" border="0" valign="top" align="center" bgcolor="#FFFFFF" cellspacing="0">]
			? [<tr>]
			? [<td align="center" valign="top">]
			? [<b>]
			? [<font face="Arial, Helvetica, sans-serif" size="3">]
			? date()
			?? [ - Listagem de Contatos Cadastrados]
			? [</font>]
			? [</b>]
			? [</td>]
			? [</tr>]
			? [</table>]
			? [<table width="701" border="1" valign="top" align="center" bgcolor="#FFFFFF" cellspacing="0">]

			for nI := 1 to len(aDados)
			   ? [<tr>]
			   ? [<td>]
			   ? [<table width='97%' border='0' cellspacing='0'><tr><td>KeyID:</td><td><b><font color='#0000FF'>]
			   ? aDados[nI][1]
			   ? [</font></b></td></tr><tr><td>Contato:</td><td><b><font color='#0000FF'>]
			   ? aDados[nI][3]
			   ? [</font></b></td></tr><tr><td>Documento:</td><td><b><font color='#0000FF'>]
			   ? aDados[nI][5]
			   ? [</font></b></td></tr><tr><td>Aniversario:</td><td><font color='#0000FF'><b>]
			   ? aDados[nI][4]
			   ? [</b></font></td></tr><tr><td width='15%'>Empresa:</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][2]
			   ? [</font></b></td></tr><tr></tr><tr><td width='15%'>Endereco:</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][6]
			   ? [</font></b></td></td></tr><tr><td width='15%'>&nbsp;</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][7]
			   ? [</font></b></td></tr><tr><td width='15%'>&nbsp;</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][8]
			   ? [&nbsp;/&nbsp;]
			   ? aDados[nI][10]
			   ? [</font></b></td></tr><tr><td width='15%'>&nbsp;</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][9]
			   ? [</font></b></td></tr><tr><td width='15%'>Fone_1:</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][11]
			   ? [</font></b></td></tr><tr><td width='15%'>Fone_2:</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][12]
			   ? [</font></b></td></tr><tr><td width='15%'>E-mail:</td><td width='85%'><b><font color='#0000FF'><a href='mailto:]
			   ? aDados[nI][13]
			   ? ['>]
			   ? aDados[nI][13]
			   ? [</a></font></b></td></tr><tr><td width='15%'>Site:</td><td width='85%'><b><font color='#0000FF'><a href='http://]
			   ? aDados[nI][14]
			   ? ['>]
			   ? aDados[nI][14]
			   ? [</a></font></b></td></tr><tr><td width='15%'>Skype:</td><td width='85%'><b><font color='#0000FF'>]
			   ? aDados[nI][15]
			   ? [</font></b></td></tr></table>]
			   ? [<br>]
			   ? [<hr width='98%' align="left">]
			   ? [<br>]
			   ? [<table width="50%" border="0" cellspacing="0">]
			   ? [<tr>]
			   ? [<td align="center" valign="top">]
			   ? [<font face="Arial, Helvetica, sans-serif" size="2">]
			   ? [Historico do Contato]
			   ? [</font>]
			   ? [</td>]
			   ? [</tr>]
			   ? [<tr>]
			   ? [<td valign="top">]
			   ? [<div align="justify">]
			   ? [<b>]
			   ? [<font color="#0000FF" size="2" face="Arial, Helvetica, sans-serif">]
			   ? aDados[nI][17]
			   ? [</b>]
			   ? [</div>]
			   ? [</font>]
			   ? [</td>]
			   ? [</tr>]
			   ? [</table>]
   			   ? [</td>]
			   ? [</tr>]
			next

			? [</table>]
			? [</body>]
			? [</html>]
		
		endif
		
		set( _SET_DEVICE, "SCREEN" )
		set( _SET_PRINTFILE, "" )
		set( _SET_PRINTER, .F. )

		MsgExclamation( "Arquivo " + cArquivo + " gerado!! Utilize um " + iif( cTipo == "txt", "editor de texto", "navegador de internet" ) + " para vizualizar e imprimir!", "Atenção" )
	
	endif

return NIL
