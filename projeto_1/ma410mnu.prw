#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA410MNU  �Autor  �Vitor Daniel        � Data �  10/12/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para inclus�o da chamada no menu.         ���
�������������������������������������������������������������������������͹��
���Uso       � CTFR0001                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MA410MNU()

	If Upper( AllTrim( FunName() ) ) == "MATA410"
		aAdd(aRotina,{"Imprimir Daisa","U_AC0029('F')"	, 0 , 7, 0,nil})
		aAdd(aRotina,{"Imprimir Interno","U_AC0034()"	, 0 , 8, 0,nil})
		aAdd(aRotina,{"Informa Peso", "U_DAIINFPES()"	, 0	, 3, 0,Nil})
	Else
		aAdd(aRotina,{"Imprime Orcamento","U_FIMPORC"  	, 0 , 4, 0,NIL})  // Adicionar botao no Orcamento Faturamento
	EndIf
		
Return aRotina                                                                                         
