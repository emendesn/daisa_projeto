#INCLUDE "PROTHEUS.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � MA030MEM � Autor � Edilson    Nascimento � Data � 03.06.13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Para validar o cadastro de Clientes, possibilitando        ���
���          � o cadastro de mais de um Cliente com o mesmo CNPJ.         ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe e � Void DAI001(void)                                          ���
�������������������������������������������������������������������������Ĵ��
���Uso       �Cadastro de Clientes                                        ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User function MA030MEM

Local aArea := GetArea()

	If AllTrim( FunName() ) == "MATA030"
		
		DBSelectArea("SX6" )
		SX6->( DBSetOrder(1) )
		IF SX6->( DBSeek( xFilial("SX6")+ "MV_VALCNPJ" ) )
			RecLock("SX6", .F. )
			SX6->X6_CONTEUD := "1"
			SX6->X6_CONTENG := "1"
			SX6->X6_CONTSPA := "1"
			SX6->( MSUnLock() )
		Endif
		
	EndIf
	
	RestArea( aArea )
					
Return 
