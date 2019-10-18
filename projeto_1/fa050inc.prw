#INCLUDE "Protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FA050INC �Autor  � ADVISE             � Data �  30/04/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de Entrada no fim da Inclusao Manual do Contas a     ���
���          � Pagar.                                                     ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FA050INC()
Local lRetorno := .T.                                         

//ALTERADO VITOR DANIEL TIRANDO O TIPO DE TAXA DA CONDICAO TX/
If INCLUI .And. Empty(M->E2_CCD) .And. !AllTrim(M->E2_TIPO) $ "FOL/FIS/IR/INS/ISS/RD " //.And. !Substr(M->E2_NATUREZ,1,2) $ "36/37/38/39"   
	lRetorno := .F.
	Alert("O Campo Centro de Custo � Obrigat�rio")
EndIf
	
If INCLUI .And. Empty(M->E2_CCD) // .And. Substr(M->E2_NATUREZ,1,2) $ "33/34/35/36/37"
	lRetorno := .F.
	Alert("Natureza obrigatoria para Centro de Custo")
EndIf
  
/*If INCLUI .And. !Empty(M->E2_CCD) .And. Substr(M->E2_NATUREZ,1,2) $ "36/37/38/39"
	lRetorno := .F.
	Alert("Natureza nao permite Centro de Custo")
EndIf
*/

Return lRetorno