#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT120GOK	º Autor ³ Rafael P. Goncalvesº Data ³  26/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Ponto de entrada ao alterar um Pedido de Compra, os saldos  º±±
±±º          ³recebem o valor do limite do aprovador.					  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MT120GOK()
	
	Local clKeySAL := ""

	//Se for alteracao
	If ParamIxb[3]
		SCS->(DbSetOrder(1))
		SAL->(DbGoTop())
		SAL->(DbSetOrder(1))
		SAK->(DbSetOrder(1))

		
		clKeySAL := xFilial("SAL")+SC7->C7_APROV
		//Posiciona no grupo de aprovador
		If SAL->(DbSeek(clKeySAL))
			//Enquanto houver aprovadores desse grupo
			While SAL->(!EoF()) .AND. SAL->AL_FILIAL+SAL->AL_COD == clKeySAL
				//Posiciona no aprovador para buscar o valor limite
				If SAK->(DbSeek(xFilial("SAK")+SAL->AL_APROV))
					//Posiciona no saldo na data do sistema do aprovador para alterar o saldo
					If SCS->(DbSeek(xFilial("SCS")+SAK->AK_USER+DtoS(dDataBase)))
						If RecLock("SCS",.F.)	
							SCS->CS_SALDO 	:= SAK->AK_LIMITE
							SCS->(MsUnLock())
						EndIf
					EndIf
				EndIf
				SAL->(DbSkip())
			EndDo
		EndIf
	EndIf
	
Return (Nil)

