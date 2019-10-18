#INCLUDE "Protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA100OKP  �Autor  �Aceex David         � Data �  31/05/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para Valida��o de Inclus�o de Movtos      ���
���          � banc�rios a pagar                                          ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FA100OKP()

Local lRetorno := .T. // vari�vel de retorno           

// Valida��o do preenchimento do centro de custo quando natureza se inicia com 33/34/35/36/37
If Empty(M->E5_CCD) //.And. Substr(M->E5_NATUREZ,1,2) $ "33/34/35/36/37"
	lRetorno := .F.
	Help(" ",1,"FA100OKP",, "Preenchimento Obrigat�rio do Centro de Custo de acordo a Natureza Informada" , 4,0)
EndIf

Return lRetorno