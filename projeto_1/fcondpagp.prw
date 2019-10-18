#INCLUDE 'PROTHEUS.CH'

User Function fCondPagP()

Local cRet:= ""

If lprospect
	cRet:= POSICIONE("SUS",1,xFilial("SUS")+M->UA_CLIENTE+M->UA_LOJA,"US_COND")
Else
	cRet:= POSICIONE("SA1",1,xFilial("SA1")+M->UA_CLIENTE+M->UA_LOJA,"A1_COND")
EndIf	  

Return(cRet)