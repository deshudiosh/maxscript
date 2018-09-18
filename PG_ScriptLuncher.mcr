macroScript PG_SL
	category:"Pawel Grzelak"
	toolTip:"PG Script Lister"
	buttonText:"PGSL"
(
	on execute do (
		pgscripts = (getINIsetting ((pathConfig.GetDir #userMacros) + "\\PG.ini") "PG" "pgscripts")
		
		if not keyboard.shiftPressed then ( filein (pgscripts + "PG_ScriptLuncher.ms") )
		else ( filein (pgscripts + "PG_ScriptLuncherLast.ms") )
	)
)