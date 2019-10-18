#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA080POS  �Autor  �WALDIR ARRUDA          Data �  18/03/09  ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para alterar os dados a serem exibidos na  ���
���          �rotina de baixa manual do contas a pagar.                   ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus 8                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA080POS()

	//CHIST070 - Variavel privada no fonte FINA080 que carrega
	//o Historico da Baixa. Este Ponto de entrada tem o objeti-
	//vo de exibir o historico do titulo no SE2 caso este este-
	//ja preenchido.
	CHIST070 := "PGTO "+SE2->E2_NUM+" "+SA2->A2_NOME
	
Return