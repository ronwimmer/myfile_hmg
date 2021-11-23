#include "hmg.ch"

declare window impressao

Function impressao_form_oninit

	setProperty("impressao", "Label_tipo", "Value", "< " + cTipo + " >" )

Return Nil
