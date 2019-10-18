#INCLUDE "PROTHEUS.CH"
#INCLUDE "VKEY.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MANUT_CFD �Autor  �Edilson Nascimento  � Data � 27/09/13    ���
�������������������������������������������������������������������������͹��
���Desc.     �Realiza a manutencao nos registros gerados na tabela CFD    ���
���          �relacionados aos registros da FCI                           ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION MANUT_CFD()

LOCAL   cAlias    := "CFD"
PRIVATE cCadastro := "Ficha de Conteudo de Import"
PRIVATE aRotina   := {}
PRIVATE aCores    := {}

	AADD(aRotina, {"Pesquisar" ,"AXPESQUI"   ,0,1})
	AADD(aRotina, {"Visualizar","AXVISUAL"   ,0,2})
	AADD(aRotina, {"Alterar"   ,"U_ALTCFD"   ,0,4})
	AADD(aRotina, {"Legenda"   ,"U_B2Legenda",0,6})
	
	DBSelectArea("SB1")
	SB1->( DBSetOrder(1) )
	
	DBSelectArea(cAlias)
	DBSetOrder(2)
	
	AADD(aCores,{"CFD_CONIMP#0","BR_VERMELHO"})
	AADD(aCores,{"CFD_CONIMP=0","BR_VERDE"})
	
	MBROWSE(6,1,22,75,cAlias,,,,,4,aCores)
	
RETURN


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ALTCFD    �Autor  �Edilson Nascimento  � Data � 27/09/13    ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para realizar a alteracao do registro da tabela CFD. ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION ALTCFD( cAlias, nReg, nOpc )

LOCAL oDlg
LOCAL oProduto
LOCAL oDESC
LOCAL oVPARIM
LOCAL oVSAIIE
LOCAL oCONIMP
LOCAL oCODFCI
LOCAL oButton1
LOCAL oButton2

PRIVATE cPRODUTO := CFD->CFD_COD
PRIVATE cDESC    := SB1->B1_DESC
PRIVATE nVPARIM  := CFD->CFD_VPARIM
PRIVATE nVSAIIE  := CFD->CFD_VSAIIE
PRIVATE nCONIMP  := CFD->CFD_CONIMP
PRIVATE cCODFCI  := CFD->CFD_FCICOD

	IF nVSAIIE <> 0
		
		DEFINE MSDIALOG oDlg TITLE "Conte�do de importa��o" FROM 000, 000  TO 330, 390 PIXEL
		
		@ 010, 010 SAY "Produto" SIZE 025, 007 OF oDlg PIXEL
		@ 010, 085 MSGET oPRODUTO VAR cPRODUTO SIZE 085, 010 OF oDlg PIXEL  WHEN .F.
		
		@ 025, 010 MSGET oDESC VAR cDESC SIZE 180, 010 OF oDlg PIXEL WHEN .F.
		
		@ 050, 010 SAY "Valor da Parcela Importad" SIZE 085, 007 OF oDlg PIXEL
		@ 050, 083 MSGET oVPARIM VAR nVPARIM PICTURE "@E 999,999.99" VALID ( CALC(), oCONIMP:REFRESH(), .T. )  SIZE 060, 010 OF oDlg PIXEL
		
		@ 070, 010 SAY "Valor Saida Interestadual" SIZE 085,010 OF oDlg PIXEL
		@ 070, 083 MSGET oVSAIIE VAR nVSAIIE PICTURE "@E 999,999.99" SIZE 060, 010 OF oDlg PIXEL WHEN .F.
		
		@ 090, 010 SAY "Conteudo de Importacao" SIZE 085,010 OF oDLG PIXEL
		@ 090, 083 MSGET oCONIMP VAR nCONIMP PICTURE "@E 999,999.99" SIZE 060, 010 OF oDlg PIXEL WHEN .F.
		
		@ 110, 010 SAY "Codigo FCI" SIZE 085,010 OF oDLG PIXEL
		@ 110, 083 MSGET oCODFCI VAR cCODFCI PICTURE "@!" SIZE 060, 010 OF oDlg PIXEL		
		
		@ 140, 100 BUTTON oButton1 PROMPT "Salvar" SIZE 040, 012 OF oDlg PIXEL ACTION (GRAVA(),oDLG:END())
		@ 140, 150 BUTTON oButton2 PROMPT "Fechar" SIZE 040, 012 OF oDlg PIXEL ACTION (oDLG:END())
		
		ACTIVATE MSDIALOG oDlg CENTERED
		
	Else
		MSGINFO("Valor Valor Saida Interestadual esta zero"+CRLF+CRLF+"Informar suporte")
	EndIf
	
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CALC     �Autor  �Edilson Nascimento  � Data � 27/09/13    ���
�������������������������������������������������������������������������͹��
���Desc.     �Realiza o calculo do percentual.                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
STATIC FUNCTION CALC()

	If nVPARIM <> 0
		
		nCONIMP := ( nVPARIM / nVSAIIE ) * 100
		
	EndIf
	
RETURN .T.


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GRAVA    �Autor  �Edilson Nascimento  � Data � 27/09/13    ���
�������������������������������������������������������������������������͹��
���Desc.     �Realiza a gravacao do registro.                             ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
STATIC FUNCTION GRAVA() 

	IF nVPARIM <> 0
		
		RECLOCK("CFD",.F.)
		CFD_VPARIM := nVPARIM
		CFD_CONIMP := nCONIMP               
		CFD_FCICOD := cCODFCI
		MSUNLOCK()
				
	Else
		MSGINFO("Informar Valor da Parcela Importad")
	EndIf
	
RETURN


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �B2Legenda �Autor  �Edilson Nascimento  � Data � 27/09/13    ���
�������������������������������������������������������������������������͹��
���Desc.     �Exibe a legenda para o usuario.                             ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION B2Legenda()
Private aLegenda := {}
	AADD(aLegenda,{"BR_VERMELHO"," Valor digitado       " })
	AADD(aLegenda,{"BR_VERDE"   ," Pendente de digita��o" })
	BrwLegenda(cCadastro, "Conte�do de importa��o", aLegenda)
Return



