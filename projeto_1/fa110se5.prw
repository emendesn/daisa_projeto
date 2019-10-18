#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA110SE5  �Autor  �WALDIR ARRUDA         Data �  18/03/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para gravar o Historico da Baixa na rotina ���
���          �autom. de Baixas a Receber.                                 ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus 8                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA110SE5()
	
	SE5->E5_HISTOR := "REC "+ SE1->E1_PREFIXO+" "+SE1->E1_NUM+" "+SE1->E1_PARCELA+" "+SA1->A1_NOME
	
Return