#include "Protheus.ch"
#include "Rwmake.ch"
#include "TopConn.ch"

User Function VldOper()

	Local lRet := .T.

	SA3->(DbSetOrder(7))
	If SA3->(DbSeek(xFilial("SA3")+__cUserId))
		/*If SA3->A3_XINCPED $ "N/ " .AND. M->UA_OPER == "1"
			lRet := .F.
			MsgStop("Você não possui permissão de cadastrar pedidos de vendas!")
		EndIf
		*/
	EndIf
		
Return (lRet)