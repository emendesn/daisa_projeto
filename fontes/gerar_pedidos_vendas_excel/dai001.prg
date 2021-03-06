#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF Chr(13)+Chr(10)

USER FUNCTION DAI001()

LOCAL cDirDocs   := MsDocPath()
Local aStru		:= {}
Local cArquivo := CriaTrab(,.F.)
Local cPath		:= AllTrim(GetTempPath())
Local oExcelApp
Local nX := 0
Local aTbr := {}

PRIVATE cPerg	:= Padr("EXPEDI", 10) 


/*BEGINDOC
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴훂�
//쿎ria tabela tempor�ria para alimentar o par�metro "status" das perguntas�
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴훂�
ENDDOC*/
  
 
/*BEGINDOC
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴횯8�@�x�[�
//쿌limenta a tabela tempor�ria�
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴횯8�@�x�[�
ENDDOC*/

/*DbSelectArea("TRB") 
DbGoTop()           
RECLOCK("TRB",.T.) 
DbSelectArea("TRB")
TRB->Campo1 := "Liberado para Faturar" 
TRB->Campo2 := "Faturado" 
TRB->Campo3 := "Bloqueado - Credito"
TRB->Campo4 := "Aguardando a expedicao"
TRB->Campo5 := "Bloqueado - Estoque"
TRB->Campo6 := "Rejeitado"
TRB->Campo7 := "Todos" 
MSUNLOCK()*/ 

AjustaSx1(cPerg)
IF !Pergunte(cPerg, .T.)
   RETURN
ENDIF
aStru := {	;
{"PEDIDO"   , "C", 06, 0},;
{"CLIENTE", "C", 06, 0},;
{"LOJA"		, "C", 02, 0},;
{"NOME"		, "C", 50, 0},;
{"PEDCLI"	, "C", 15, 0},;
{"EMISSAO" 	, "D", 08, 0},;
{"ENTREGA" 	, "D", 08, 0},;
{"ESTATUS"	, "C", 15, 0},;
{"CODDAISA"	, "C", 30, 0},;
{"QUANT"	, "N", 17, 2},;
{"PRECO"	, "N", 17, 2},;
{"VLR_TABELA"	, "N", 17, 2},;
{"VALOR"	, "N", 17, 2},;
{"IPI"	, "N", 17, 2},;
{"ICMS"	, "N", 17, 2},;
{"ICMST"	, "N", 17, 2},;
{"DESCCLI"	, "N", 06, 2},;
{"DESCPED"	, "N", 06, 2},;
{"DESCPED2"	, "N", 06, 2},;
{"DESCPED3"	, "N", 06, 2},;
{"DESCPED4"	, "N", 06, 2},;
{"DESCIT"	, "N", 06, 2},;
{"VENDEDOR"	, "C", 40, 0},;
{"COMISSAO"	, "N", 06, 2},;
{"TIPO"	 	, "C", 15, 0},;
{"TES"		, "C", 03, 0},;
{"CFOP"	, "C", 04, 0}   ,;
{"DCFOP"	, "C", 25, 0}   }

dbCreate(cDirDocs+"\"+cArquivo,aStru,"dbfcdxads")
dbUseArea(.T.,"dbfcdxads",cDirDocs+"\"+cArquivo,cArquivo,.F.,.F.)

cQuery := " "

if SELECT ("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea("TRB1")
endif

cQuery += " SELECT DISTINCT C5_CLIENTE COD, C5_LOJACLI  LOJA, A1_NOME NOME, C5_PEDCLI PEDCLI,C5_EMISSAO EMISSAO,C6_ENTREG ENTREGA,C5_NUM PEDIDO,C6_ITEM ITEM,C5_TIPO TIPOP, C5_TIPOCLI TIPOC, "+CRLF

//cQuery += " case  when C5_NOTA = '' AND C5_LIBEROK = '' AND C5_BLQ 		= '' then 'Aberto'  " +CRLF
//cQuery += "       when C5_NOTA <> '' AND C5_LIBEROK = 'E' AND C5_BLQ = '' then 'Encerrado'  " +CRLF
//cQuery += "       when C5_NOTA = '' AND C5_LIBEROK != '' AND C5_BLQ = '' then  'Liberado'   "+CRLF
//cQuery += "       when C5_BLQ <> '' then  'Bloqueado'  end ESTATUS, "+CRLF

cQuery += " case  when C9_BLEST ='  ' And C9_BLCRED = '  ' And (C9_BLWMS >= '05' OR C9_BLWMS = '  ') then 'Liberado para Faturar'  " +CRLF
cQuery += "       when (C9_BLCRED ='10' And C9_BLEST  = '10') Or (C9_BLCRED ='ZZ' And C9_BLEST  = 'ZZ') then 'Faturado'  " +CRLF
cQuery += "       when C9_BLCRED NOT IN ('  ','09','10','ZZ') then 'Bloqueado - Credito'    "+CRLF
cQuery += "       when C9_BLEST ='XX' AND C9_BLCRED NOT IN ('09','10','ZZ') then 'Aguardando a expedicao'    "+CRLF
cQuery += "       when C9_BLCRED NOT IN ('09') AND C9_BLEST NOT IN ('  ','10','ZZ') then 'Bloqueado - Estoque'    "+CRLF
cQuery += "       when C9_BLCRED = '09' then  'Rejeitado'  end ESTATUS, "+CRLF


cQuery += " C6_XCODANT CODDAISA, C6_PRODUTO PRODUTO, "+CRLF
cQuery += " C6_QTDVEN QUANT, C6_PRUNIT PRECO, DA1_PRCVEN UNITARIO, C6_VALOR VALOR, "+CRLF
//cQuery += " C6_VALIPI IPI, C6_VALICM ICM, C6_VALICM-C6_ICMSRET ICMST,  "+CRLF
cQuery += " A1_DESC DESCCLI, C5_DESC1 DESCPED,C5_DESC2 DESCPED2,C5_DESC3 DESCPED3,C5_DESC4 DESCPED4,  C6_DESCONT DESCIT, "+CRLF
cQuery += " A3_NOME VENDEDOR, C5_COMIS1 COMISSAO, "+CRLF
cQuery += " case  "+CRLF
cQuery += "     when C5_TIPOCLI = 'F' then 'Cons. Final'  "+CRLF
cQuery += "     when C5_TIPOCLI = 'L' then 'Prod. Rural'  "+CRLF
cQuery += "     when C5_TIPOCLI = 'R' then 'Revendedor'  "+CRLF
cQuery += "     when C5_TIPOCLI = 'S' then 'Solidario'  "+CRLF
cQuery += "     when C5_TIPOCLI = 'X' then 'Exportacao/Importacao'  "+CRLF
cQuery += "   end TIPO, "+CRLF
cQuery += " C6_TES TES, C6_CF CFOP, X5_DESCRI DESC_CFOP,C5_LIBEROK LIBERA "+CRLF
cQuery += " FROM "+ RetSqlName("SC5") +"  SC5, "+ RetSqlName("SC9") +"  SC9, "+ RetSqlName("DA1") +"  DA1, "+  RetSqlName("SA1") +" SA1,"+ RetSqlName("SC6") +" SC6, "+ RetSqlName("SA3") +" SA3, "+ RetSqlName("SB1") +" SB1,"+ RetSqlName("SX5") +" SX5 "+CRLF
cQuery += " WHERE SC5.D_E_L_E_T_ <> '*' AND SA1.D_E_L_E_T_ <> '*' AND DA1.D_E_L_E_T_ <> '*' AND SC9.D_E_L_E_T_ <> '*' AND SC6.D_E_L_E_T_ <> '*' AND SA3.D_E_L_E_T_ <> '*' AND SB1.D_E_L_E_T_ <> '*'  "+CRLF
cQuery += " AND SC5.C5_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+CRLF
cQuery += " AND SC6.C6_ENTREG BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' "+CRLF
cQuery += " AND SC5.C5_CLIENTE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SC5.C5_VEND1 BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF  
cQuery += " AND SC5.C5_CLIENTE = SA1.A1_COD "+CRLF
cQuery += " AND SC5.C5_LOJACLI = SA1.A1_LOJA "+CRLF

cQuery += " AND SC5.C5_NUM = SC6.C6_NUM "+CRLF
cQuery += "  AND SC6.C6_NUM = SC9.C9_PEDIDO  "+CRLF
cQuery += "  AND SC6.C6_PRODUTO = SC9.C9_PRODUTO "+CRLF
cQuery += "  AND SC6.C6_ITEM    = SC9.C9_ITEM    "+CRLF

cQuery += " AND SA3.A3_COD = SC5.C5_VEND1  "+CRLF
cQuery += " AND SC6.C6_PRODUTO = SB1.B1_COD "+CRLF
cQuery += " AND SC5.C5_TIPO NOT IN ('B','D') "+CRLF
cQuery += " AND SC6.C6_PRODUTO = DA1.DA1_CODPRO "+CRLF
cQuery += " AND DA1.DA1_ATIVO = '1'           "+CRLF
cQuery += " AND DA1.DA1_CODTAB = SC5.C5_TABELA "+CRLF
cQuery += " AND SX5.X5_TABELA = '13' AND X5_CHAVE = SC6.C6_CF "+CRLF

//VALIDA QUERY
cQryOk:=cQuery
cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.)
nItem:=0

TRB1->(dbGotop())
While TRB1->(!Eof())
	
	VAL_IPI 	:= 0
	VAL_TOT 	:= 0
	VAL_ST  	:= 0
	ST_AUX  	:= 0
	
	nItem:=1
	MaFisSave()                                  
	MaFisEnd()
	
	MaFisIni((TRB1->COD),;// 1-Codigo Cliente/Fornecedor
	TRB1->LOJA,;		// 2-Loja do Cliente/Fornecedor
	"C",;				// 3-C:Cliente , F:Fornecedor
	TRB1->TIPOP,;				// 4-Tipo da NF
	TRB1->TIPOC,;		// 5-Tipo do Cliente/Fornecedor
	Nil,;
	Nil,;
	Nil,;
	Nil,;
	"MATA641")
	
	MaFisAdd(TRB1->PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
	TRB1->TES,;	   	// 2-Codigo do TES ( Opcional )
	TRB1->QUANT,;  	// 3-Quantidade ( Obrigatorio )
	TRB1->UNITARIO,;		  	// 4-Preco Unitario ( Obrigatorio )
	TRB1->DESCIT,; 	// 5-Valor do Desconto ( Opcional )
	"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
	"",;				// 7-Serie da NF Original ( Devolucao/Benef )
	0,;					// 8-RecNo da NF Original no arq SD1/SD2
	0,;					// 9-Valor do Frete do Item ( Opcional )
	0,;					// 10-Valor da Despesa do item ( Opcional )
	0,;					// 11-Valor do Seguro do item ( Opcional )
	0,;					// 12-Valor do Frete Autonomo ( Opcional )
	TRB1->VALOR,;			// 13-Valor da Mercadoria ( Obrigatorio )
	0)					// 14-Valor da Embalagem ( Opiconal )
	
	VAL_IPI 	:= MaFisRet(nItem,"IT_VALIPI")
	VAL_TOT 	:= MaFisRet(nItem,"IT_VALICM")
	VAL_ST  	:= IIF(MaFisRet(nItem,"IT_VALSOL")>0,MaFisRet(nItem,"IT_VALSOL"),0)
	
	//IF MV_PAR09 == ESTATUS
	RecLock(cArquivo, .T.)
	(cArquivo)->CLIENTE	:= TRB1->COD
	(cArquivo)->LOJA	:= TRB1->LOJA
	(cArquivo)->NOME	:= TRB1->NOME
	(cArquivo)->PEDCLI	:= TRB1->PEDCLI
	(cArquivo)->EMISSAO	:= STOD(TRB1->EMISSAO)
	(cArquivo)->ENTREGA	:= STOD(TRB1->ENTREGA)
	(cArquivo)->PEDIDO	:= TRB1->PEDIDO
	(cArquivo)->ESTATUS	:= TRB1->ESTATUS
	(cArquivo)->CODDAISA:= TRB1->CODDAISA    
	(cArquivo)->QUANT	:= TRB1->QUANT
	(cArquivo)->PRECO	:= TRB1->PRECO
	(cArquivo)->VLR_TABELA	:= TRB1->UNITARIO
	(cArquivo)->VALOR	:= TRB1->VALOR
	(cArquivo)->ICMS 	:= VAL_TOT
	(cArquivo)->ICMST	:= VAL_ST
	(cArquivo)->IPI  	:= VAL_IPI
	(cArquivo)->DESCCLI	:= TRB1->DESCCLI
	(cArquivo)->DESCPED	:= TRB1->DESCPED
	(cArquivo)->DESCPED2	:= TRB1->DESCPED2
	(cArquivo)->DESCPED3 := TRB1->DESCPED3
	(cArquivo)->DESCPED4	:= TRB1->DESCPED4
	(cArquivo)->DESCIT	:= TRB1->DESCIT
	(cArquivo)->VENDEDOR:= TRB1->VENDEDOR
	(cArquivo)->COMISSAO:= TRB1->COMISSAO
	(cArquivo)->TIPO	:= TRB1->TIPO
	(cArquivo)->CFOP	:= TRB1->CFOP
	(cArquivo)->DCFOP	:= TRB1->DESC_CFOP
	(cArquivo)->TES		:= TRB1->TES
 //	END IF
	TRB1->(dbSkip())
	
ENDDO

dbSelectArea(cArquivo)
dbCloseArea()

CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , "C:\TEMP\", .T. )

__CopyFIle("C:\TEMP\"+cArquivo+".DBF", "C:\TEMP\"+cArquivo+".XLS")

Ferase("C:\TEMP\"+cArquivo+".DBF")

If ! ApOleClient( "MsExcel" )
	MsgStop( "Ocorreu um Erro. Tente Novamente." )
	Return
EndIf

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( "c:\temp\"+cArquivo+".XLS" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)
DBSELECTAREA("TRB1")
dbclosearea()

Return 

User Function CONS()
Local oDlg, oMaps, oList, nList := 1
Local aItens := {}
AADD(aItens, 'Liberado para Faturar')
AADD(aItens, 'Bloqueado - Credito')
AADD(aItens, 'Aguardando a expedicao') 
AADD(aItens, 'Bloqueado - Estoque')
AADD(aItens, 'Rejeitado')
AADD(aItens, 'Todos') 


oDlg0 := MsDialog():New(10,10,300,300,'Status Pedido',,,,,CLR_BLACK,CLR_WHITE,,,.T.)

oList := tListBox():New(10,10,{|U|if(pCount()>0,nList:=U,nList)},aItens,100,100,,oDlg0,,,,.T.)   

oButton:= TButton():New(10,0300,"OK",oMaps,{||oMaps:End(),lContinue := .T.},40,10,,,,.T.)  

oDlg0:ACTIVATE(,,,.T.,,,)

Return  

Static Function AjustaSX1(cPerg)

Local aRea	:= GetArea()
Local aSx1	:= {}

DBSelectArea("SX1")
SX1->(DBSetOrder(1))
cPerg := PadR(cPerg, Len(SX1->X1_GRUPO))
SX1->(DBSeek(cPerg+"01"))

AADD(	aSx1,{ cPerg,"01","Emissao de"			,"mv_par01"	,"D",08,0,0,"G","", "mv_par01","","","","","","" } )
AADD(	aSx1,{ cPerg,"02","Emissao ate"			,"mv_par02"	,"D",08,0,0,"G","",	"mv_par02","","","","","","" } )
AADD(	aSx1,{ cPerg,"03","Entrega de"			,"mv_par03"	,"D",08,0,0,"G","", "mv_par03","","","","","","" } )
AADD(	aSx1,{ cPerg,"04","Entrega ate"			,"mv_par04"	,"D",08,0,0,"G","",	"mv_par04","","","","","","" } )
AADD(	aSx1,{ cPerg,"05","Cliente de"			,"mv_par05"	,"C",06,0,0,"G","", "mv_par05","","","","","SA1","" } )
AADD(	aSx1,{ cPerg,"06","Cliente ate"			,"mv_par06"	,"C",06,0,0,"G","",	"mv_par06","","","","","SA1","" } )
AADD(	aSx1,{ cPerg,"07","Vendedor de"			,"mv_par07"	,"C",06,0,0,"G","", "mv_par07","","","","","SA3","" } ) 
AADD(	aSx1,{ cPerg,"08","Vendedor ate"		,"mv_par08"	,"C",06,0,0,"G","",	"mv_par08","","","","","SA3","" } ) 
AADD(	aSx1,{ cPerg,"09","Status"	    	    ,"mv_par09"	,"C",20,0,0,"G","",	"mv_par09","","","","","","" } )//Status


If SX1->X1_GRUPO != cPerg
	For I := 1 To Len( aSx1 )
		If !SX1->( DBSeek( aSx1[I][1] + aSx1[I][2] ) )
			Reclock( "SX1", .T. )
			SX1->X1_GRUPO		:= aSx1[i][1] //Grupo
			SX1->X1_ORDEM		:= aSx1[i][2] //Ordem do campo
			SX1->X1_PERGUNT		:= aSx1[i][3] //Pergunta
			SX1->X1_PERSPA		:= aSx1[i][3] //Pergunta Espanhol
			SX1->X1_PERENG		:= aSx1[i][3] //Pergunta Ingles
			SX1->X1_VARIAVL		:= aSx1[i][4] //Variavel do campo
			SX1->X1_TIPO		:= aSx1[i][5] //Tipo de valor
			SX1->X1_TAMANHO		:= aSx1[i][6] //Tamanho do campo
			SX1->X1_DECIMAL		:= aSx1[i][7] //Formato numerico
			SX1->X1_PRESEL		:= aSx1[i][8] //Pre sele豫o do combo
			SX1->X1_GSC			:= aSx1[i][9] //Tipo de componente
			SX1->X1_VAR01		:= aSx1[i][10]//Variavel que carrega resposta
			SX1->X1_DEF01		:= "Faturaro"//aSx1[i][11]//Defini寤es do combo-box
		   	SX1->X1_DEF02		:= "Teste"//aSx1[i][12]
			SX1->X1_DEF03		:= aSx1[i][13]
			SX1->X1_DEF04		:= aSx1[i][14]
			SX1->X1_VALID		:= aSx1[i][15]
			SX1->X1_F3			:= aSx1[i][16]
			MsUnlock()
		Endif
	Next
Endif

RestArea(aRea)

Return(cPerg)
