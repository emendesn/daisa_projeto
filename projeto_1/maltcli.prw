#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MALTCLI   �Autor  �Edilson Nascimento  � Data �  02/10/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada executado na finalizacao da gravacao       ���
���          �do cadastro de cliente.                                     ���
�������������������������������������������������������������������������͹��
���Uso       � Todas as empresas.                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MALTCLI()

	RECLOCK("SA1",.F.)
	SA1->A1_DTAALT := dDataBase
	SA1->A1_USRALT := Upper( cUserName )
	SA1->( MSUnLock() )
	
Return