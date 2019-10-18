#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT440GR   � Autor �Reginaldo G. Ribeiro� Data �  02/08/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de Entrada para flag do SC9 para aparecer na expedi��o��
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MT450FIM()

Local aArea := GetArea()

	DBSelectArea("SC9")
	SC9->( DBSetOrder(1) )
	If SC9->( DBSeek( xFilial("SC9") + ParamIXB[1] ) )
		
		If Empty( SC9->C9_BLEST ) .And. Empty( SC9->C9_BLCRED ) .And. Empty( SC9->C9_NFISCAL )
			If RecLock("SC9",.F.)
				SC9->C9_BLEST := "XX"
				SC9->(MsUnLock())
			EndIf
		EndIf
		
	EndIf
		
	RestArea( aArea )
		
Return