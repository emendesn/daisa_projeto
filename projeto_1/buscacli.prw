#INCLUDE "Protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � BUSCACLI � Autor � Advise             � Data �  15/08/11   ���
�������������������������������������������������������������������������͹��
���Descricao �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function BUSCACLI()

	Local cRetorno	:= ""

	DbSelectarea("SA1")
	SA1->(DbSetorder(1))
	If SA1->(DbSeek(xFilial("SA1") + SE5->E5_FORNADT + SE5->E5_LOJAADT))
		cRetorno := SA1->A1_CGC
	EndIf
	
Return cRetorno