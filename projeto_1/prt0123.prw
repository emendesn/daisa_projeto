#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTALCDOC	� Autor � Rafael P. Goncalves� Data �  26/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao �Ponto de entrada ao aprovar Pedido de Compra, volta o saldo ���
���          �do aprovador para que esta no limite, pois sera aprovado por���
���          �pedido e nao por periodo.									  ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MTALCDOC()
    
	Local llRet 	:= .F.
	
	//Liberou pedido de compra
	If ParamIxb[3] == 4
		If RecLock("SCS",.F.)	
			SCS->CS_SALDO 	:= SCS->CS_SALDO+ParamIxb[1][3]
			SCS->(MsUnLock())
			llRet := .T.
		EndIf
	EndIf
	
Return (llRet)
