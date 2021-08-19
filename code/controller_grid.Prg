#include <hmg.ch>

declare window grid_contatos

static cBotaoAtivo

function mostra_grid_contato( cBotao )

	cBotaoAtivo := iif( cBotao == NIL, "X", cBotao )

	if IsWindowActive(grid_contatos)
		doMethod("grid_contatos","MINIMIZE")
		doMethod("grid_contatos","RESTORE")
		doMethod("grid_contatos","SETFOCUS")
	else
		load window grid_contatos
		activate window grid_contatos
	endif

return NIL

function inicia_grid()

	local aGrid := {}
	local nI := 0

	if cBotaoAtivo == "A"
		setProperty("grid_contatos","Button_alterar","Enabled",.T.)
		setProperty("grid_contatos","Button_historico","Enabled",.F.)
	elseif cBotaoAtivo == "H"
		setProperty("grid_contatos","Button_alterar","Enabled",.F.)
		setProperty("grid_contatos","Button_historico","Enabled",.T.)
	else
		setProperty("grid_contatos","Button_alterar","Enabled",.F.)
		setProperty("grid_contatos","Button_historico","Enabled",.F.)
	endif
	
	abre_arquivo()
	carrega_grid_ctrl( @aGrid )

	doMethod("grid_contatos","Grid_contatos","DeleteAllItems")
	if len( aGrid ) > 0
		for nI := 1 to len( aGrid )
			doMethod("grid_contatos","Grid_contatos","AddItem", aClone(aGrid[nI]))
		next
	endif
	
return NIL

function carrega_grid_ctrl( aGrid, cPesquisa, nChave )

	carrega_grid( @aGrid, cPesquisa, nChave )

return NIL

function filtra_grid()

	local cPesquisa
	local nChave
	local aGrid := {}
	local nI := 0
	
	cPesquisa := alltrim( getProperty("grid_contatos","Text_pesquisa","Value") )
	nChave    := getProperty("grid_contatos","Combo_pesquisa","Value")
	
	carrega_grid_ctrl( @aGrid, cPesquisa, nChave )

	doMethod("grid_contatos","Grid_contatos","DeleteAllItems")
	if len( aGrid ) > 0
		for nI := 1 to len( aGrid )
			doMethod("grid_contatos","Grid_contatos","AddItem", aClone(aGrid[nI]))
		next
	endif
	
return NIL
