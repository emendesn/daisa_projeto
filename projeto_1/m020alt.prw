#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M020ALT   �Autor  �Edilson Nascimento  � Data �  02/10/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada executado na finalizacao da gravacao       ���
���          �do cadastro de Forncedor.                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Todas as empresas.                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M020ALT()

	RECLOCK("SA2",.F.)
	SA2->A2_DTAALT := dDataBase
	SA2->A2_USRALT := Upper( cUserName )
	SA2->( MSUnLock() )
					
Return