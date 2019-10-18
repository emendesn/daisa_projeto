#include "Protheus.ch"
#include "TopConn.ch"

User Function LimpaSA1()

	Local nlI 		:= 1
	Local clCampo   := ""
	Local clDado	:= ""
	
	DbSelectArea("SA1")
    SA1->(DbGoTop())
    SA1->(DbSetOrder(1))    
	While SA1->(!Eof())
		For nlI := 1 To SA1->(FCount())
			clCampo := SA1->(FieldName(nlI))
			clDado	:= &("SA1->"+clCampo)
			
			If ValType(clDado) == "C"
				If "ÿ" $ clDado
					
					If RecLock("SA1",.F.)
						&("SA1->"+clCampo) := StrTran(clDado,"ÿ","")
						
						SA1->(MsUnlock())
					EndIf
				EndIf
			EndIf
		Next nlI
		SA1->(DbSkip())
    EndDo
	
Return (Nil)