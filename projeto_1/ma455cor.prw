
User Function MA455COR()

	Local aRet := {}//ParamIxb
	
	For nlI := 1 To Len(ParamIxb)+1
		If nlI < 4
		    aAdd(aRet,ParamIxb[nlI])		
		ElseIf nlI == 4
			aAdd(aRet,{"C9_BLEST=='XX' .AND. C9_BLCRED <> '09' .And. C9_BLCRED <> '10' .And. C9_BLCRED <> 'ZZ'","BR_PINK"})//Item Aguardando a expedicao		
		Else
		    aAdd(aRet,ParamIxb[nlI-1])
		EndIf		
	Next nlI


Return (aRet)