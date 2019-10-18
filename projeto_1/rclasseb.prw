#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RClasseB  �Autor  �Stanko              � Data �  29/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Relatorio de producao - Classe B                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � FAT - Especifico                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function RClasseB()

Local oReport
Private cPerg 	:= "RCLASSEB"

AjustaSX1(cPerg)

oReport:= ReportDef()
oReport:PrintDialog()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  �Stanko              � Data �  29/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ReportDef()

Local oReport
Local oSection1
Local oCell

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport:= TReport():New("RCLASSEB","Acompanhamento Classe B",cPerg, {|oReport| ReportPrint(oReport)},)
oReport:SetLandscape()
oReport:SetDevice(4)
oReport:SetTotalInLine(.F.)

oSection1 := TRSection():New(oReport,,)
oSection1 :SetTotalInLine(.F.)

//TRCell():New(oSection1,"OP"			,"   ","Cod.OP"			,PesqPict('ZZ3',"ZZ3_OP")  		,TamSX3("ZZ3_OP")[1],/*lPixel*/,/*{|| code-block de impressao }*/)


TRCell():New(oSection1,'CLASSE'	,'',"Classe"				  	,"@!"				,01	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'GRUPO'		,'',"Grupo"					  	,"@!"				,04	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DESCRGRP'	,'',"Descr.Grp"				  	,"@!"				,20	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'BLANK'		,'',"Blank"				  		,"@!"				,30	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'DESCRBLK'	,'',"Descr.Blk"			  		,"@!"				,30	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'ARMAZEM'	,'',"Armazem"				  	,"@!"				,02	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'ESTMIN'	,'',"Estoq.Min"				  	,"@E 9,999,999.99"	,12	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'QTDCART'	,'',"Qtd.Cart"				  	,"@E 9,999,999.99"	,12	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'ESTATU'	,'',"Estoq.Atual"			  	,"@E 9,999,999.99"	,12	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'QTDPROD'	,'',"Qtd.Produzir"			  	,"@E 9,999,999.99"	,12	,/*lPixel*/,/*{|| code-block de impressao }*/)
                        

Return(oReport)



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportPrin�Autor  �Stanko              � Data �  29/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1)
Local cAlias := ""
Local nAbort	:= 0

Pergunte(cPerg,.F.)

//������������������������������������������������������������������������Ŀ
//�Transforma parametros Range em expressao SQL                            �
//��������������������������������������������������������������������������
MakeSqlExpr(oReport:uParam)

cAlias := GetNextAlias()

//������������������������������������������������������������������������Ŀ
//�Query do relatorio da secao 1                                           �
//��������������������������������������������������������������������������
oReport:Section(1):BeginQuery()

//�������������������������������������������������������������������Ŀ
//�Esta rotina foi escrita para adicionar no select os campos         �
//�usados no filtro do usuario quando houver, a rotina acrecenta      �
//�somente os campos que forem adicionados ao filtro testando         �
//�se os mesmo j� existem no select ou se forem definidos novamente   �
//�pelo o usuario no filtro, esta rotina acrecenta o minimo possivel  �
//�de campos no select pois pelo fato da tabela SD1 ter muitos campos |
//�e a query ter UNION, ao adicionar todos os campos do SD1 podera'   |
//�derrubar o TOP CONNECT e abortar o sistema.                        |
//���������������������������������������������������������������������

BeginSql Alias cAlias
	
	//SELECT	*
	//FROM %table:SA1% SA1
	//	WHERE SA1.A1_FILIAL = %Exp:xFilial("SA1")%
	//	AND SA1.%NotDel%
	
	
	SELECT V.*, V.QTDCART+V.ESTMIN-V.ESTATU QTDPROD FROM
	(
	SELECT B1_XCLASS CLASSE, B1_GRUPO GRUPO,
	
	(SELECT BM_DESC
	FROM SBM010 SBM
	WHERE BM_FILIAL = '  ' AND SBM.D_E_L_E_T_ = ' '
	AND BM_GRUPO = B1_GRUPO) DESCRGRP,
	B1_XBLANK BLANK,
	
	
	(SELECT SB1B.B1_DESC
	FROM SB1010 SB1B
	WHERE SB1B.B1_FILIAL = '  ' AND SB1B.D_E_L_E_T_ = ' '
	AND SB1B.B1_COD = SB1.B1_XBLANK) DESCRBLK,
	
	
	C9_LOCAL ARMAZEM, B1_EMIN ESTMIN,
	
	isnull((SELECT B2_QATU FROM SB2010 SB2
	WHERE B2_FILIAL = '01' AND SB2.D_E_L_E_T_ = ' '
	AND B2_LOCAL = '03'
	AND B2_COD = B1_XBLANK),0) ESTATU,
	
	SUM(C9_QTDLIB) QTDCART
	
	FROM SC9010 SC9, SC6010 SC6, SB1010 SB1
	WHERE C9_FILIAL = '01' AND SC9.D_E_L_E_T_ = ' '
	AND C9_BLCRED = ' '
	AND C9_NFISCAL = ' '
	AND C6_FILIAL = C9_FILIAL AND SC6.D_E_L_E_T_ = ' '
	AND C6_NUM = C9_PEDIDO
	AND C6_ITEM = C9_ITEM
	AND C6_PRODUTO = C9_PRODUTO
	AND B1_FILIAL = '  ' AND SB1.D_E_L_E_T_ = ' '
	AND B1_COD = C9_PRODUTO
	AND B1_XCLASS = 'B'
	
	AND C9_PRODUTO  BETWEEN %Exp:(MV_PAR01)% AND %Exp:(MV_PAR02)%
	AND B1_XBLANK  BETWEEN %Exp:(MV_PAR03)% AND %Exp:(MV_PAR04)%
	AND C9_LOCAL   BETWEEN %Exp:(MV_PAR05)% AND %Exp:(MV_PAR06)%
	AND C6_ENTREG  BETWEEN %Exp:(MV_PAR07)% AND %Exp:(MV_PAR08)%
	
	GROUP BY B1_XCLASS, B1_GRUPO, B1_XBLANK, C9_LOCAL, B1_EMIN
	
	) V
	
	ORDER BY QTDPROD DESC
	
	
	
EndSql

//������������������������������������������������������������������������Ŀ
//�Metodo EndQuery ( Classe TRSection )                                    �
//�                                                                        �
//�Prepara o relatorio para executar o Embedded SQL.                       �
//�                                                                        �
//�ExpA1 : Array com os parametros do tipo Range                           �
//�                                                                        �
//��������������������������������������������������������������������������
oReport:Section(1):EndQuery()

//������������������������������������������������������������������������Ŀ
//�Inicio da impressao do fluxo do relatorio                               �
//��������������������������������������������������������������������������
dbSelectArea(cAlias)
oReport:SetMeter((cAlias)->(RecCount()))

oSection1:Init()


While !oReport:Cancel() .And. !(cAlias)->(Eof())
	
	If oReport:Cancel()
		Exit
	EndIf
	
	nAux := (cAlias)->QTDPROD * (MV_PAR09/100)
	nAux += (cAlias)->QTDPROD
	
	oSection1:Cell("QTDPROD"):SetValue(nAux)
	
	oSection1:PrintLine()
	
	dbSelectArea(cAlias)
	(cAlias)->(dbSkip())
	
EndDo
oSection1:Finish()

Return NIL


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSx1 �Autor  �Stanko              � Data �  29/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function AjustaSx1(cPerg)
Local aRegs 	:= {}

aAdd(aRegs,{cPerg,"01","Produto De?"    ,"","","mv_ch1","C",30,00,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"02","Produto Ate?"   ,"","","mv_ch2","C",30,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"03","Blank De?"    ,"","","mv_ch3","C",30,00,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"04","Blank Ate?"   ,"","","mv_ch4","C",30,00,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"05","Armazem De?"  ,"","","mv_ch5","C",02,00,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Armazem Ate?" ,"","","mv_ch6","C",02,00,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Entrega De?"  ,"","","mv_ch7","D",08,00,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Entrega Ate?" ,"","","mv_ch8","D",08,00,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09","% Acresc. Prod.?" ,"","","mv_ch9","N",6,02,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})


ValidPerg(aRegs,cPerg,.F.)

Return Nil

