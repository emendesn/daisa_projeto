#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M440STTS	� Autor � Rafael P. Goncalves� Data �  26/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao �Ponto de entrada ao liberar um Pedido de Vendas, caso o     ���
���          �pedido ficar liberado automatico ficara aguardando expedicao���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function M440STTS()

	Local clKeySC9 := SC5->C5_FILIAL+SC5->C5_NUM //SC9->C9_FILIAL+SC9->C9_PEDIDO Alterado P/ Reginaldo

	SC9->(DBGoTop())
	SC9->(DBSetOrder(1))
	SC6->(DBSetOrder(1))
	SF4->(DBSetOrder(1))
	If SC9->(DBSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )
		While .Not. SC9->( EOF() ) .AND. xFilial("SC9") == SC5->C5_FILIAL .AND. SC9->C9_PEDIDO == SC5->C5_NUM
			If Empty( SC9->C9_BLEST ) .AND. Empty( SC9->C9_BLCRED ) .AND. SC5->C5_TIPO == "N"
				If SC6->( DBSeek( SC5->C5_FILIAL + SC5->C5_NUM + SC9->C9_ITEM ) )
					If SF4->( DBSeek( xFilial("SF4") + SC6->C6_TES))
						//Se a TES atualiza estoque
						If SF4->F4_ESTOQUE == "S"
							If RecLock("SC9",.F.)
								SC9->C9_BLEST := "XX"
								SC9->(MsUnlock())
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			SC9->(DBSkip())
		EndDo
	EndIf
	//U_DeleteVol(SC5->C5_FILIAL+SC5->C5_NUM)

	
Return