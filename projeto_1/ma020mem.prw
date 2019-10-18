#INCLUDE "PROTHEUS.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � MA020MEM � Autor � Edilson    Nascimento � Data � 03.06.13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Para validar o cadastro de Fornecedores, impossibilitando  ���
���          � o cadastro de mais de um Fornecedor com o mesmo CNPJ.      ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe e � Void DAI001(void)                                          ���
�������������������������������������������������������������������������Ĵ��
���Uso       �Cadastro de Fornecedores                                    ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User function MA020MEM

Local aArea := GetArea()

	If AllTrim( FunName() ) == "MATA020"
		
		DBSelectArea("SX6" )
		SX6->( DBSetOrder(1) )
		IF SX6->( DBSeek( xFilial("SX6")+ "MV_VALCNPJ" ) )
			RecLock("SX6", .F. )
			SX6->X6_CONTEUD := "2"
			SX6->X6_CONTENG := "2"
			SX6->X6_CONTSPA := "2"
			SX6->( MSUnLock() )
		Endif
		
	Endif
	
	RestArea( aArea )
			
Return 
