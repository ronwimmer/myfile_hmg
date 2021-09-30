#include "hmg.ch"

declare window contato

Function contato_form_onrelease

	local aGrid := {}

	if IsWindowActive(grid_contatos)

		carrega_grid_ctrl( @aGrid )

		doMethod("grid_contatos","Grid_contatos","DeleteAllItems")
		if len( aGrid ) > 0
			for nI := 1 to len( aGrid )
				doMethod("grid_contatos","Grid_contatos","AddItem", aClone(aGrid[nI]))
			next
		endif
	
		doMethod("Main","MINIMIZE")
		doMethod("grid_contatos","MINIMIZE")
		doMethod("grid_contatos","RESTORE")
		doMethod("grid_contatos","SETFOCUS")
	else
		doMethod("Main","MINIMIZE")
		doMethod("Main","RESTORE")
		doMethod("Main","SETFOCUS")
	endif

Return Nil
