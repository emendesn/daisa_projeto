User Function AC0033()
                      
If !Empty(M->CJ_CODOBS)
	DbSelectArea("SZ2")
	dbSeek(xFilial("SZ2")+M->CJ_CODOBS)
	
	cRet := SZ2->Z2_OBS	
Else
	cRet := ""
EndIf

Return cRet