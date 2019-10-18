#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  FA070POS   �Autor  �Alan S. R. Oliveira � Data �  21/04/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para alterar os dados a serem exibidos na  ���
���          �rotina de baixa manual do contas a receber.                 ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus 8                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA070POS()

	//CHIST070 - Variavel privada no fonte FINA070 que carrega
	//o Historico da Baixa. Este Ponto de entrada tem o objeti-
	//vo de exibir o historico do titulo no SE1 caso este este-
	//ja preenchido.
	
	CHIST070 := IIF(!Empty(SE1->E1_HIST),SE1->E1_HIST,CHIST070)
	     
Return