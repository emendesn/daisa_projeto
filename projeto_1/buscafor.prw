#INCLUDE "Protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � BUSCAFOR � Autor � Advise             � Data �  15/08/11   ���
�������������������������������������������������������������������������͹��
���Descricao �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function BUSCAFOR()

	Local cRetorno	:= ""

	DbSelectarea("SA2")
	SA2->(DbSetorder(1))
	If SA2->(DbSeek(xFilial("SA2") + SE5->E5_FORNADT + SE5->E5_LOJAADT))
		cRetorno := SA2->A2_CGC
	EndIf
	
Return cRetorno