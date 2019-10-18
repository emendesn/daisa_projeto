#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF Chr(13)+Chr(10)

USER FUNCTION DAI003()

LOCAL cDirDocs   := MsDocPath()
Local aStru		:= {}
Local cArquivo := CriaTrab(,.F.)
Local cPath		:= AllTrim(GetTempPath())
Local oExcelApp
Local nX := 0

PRIVATE cPerg	:= Padr("EXFADD", 10)

AjustaSx1(cPerg)
Pergunte(cPerg, .T.)
//{"ENTREGA" 	, "D", 08, 0},;
//{"ESTATUS"	, "C", 15, 0},;
//{"DESCCLI"	, "N", 06, 2},;
//{"DESCPED"	, "N", 06, 2},;
//{"DESCIT"	, "N", 06, 2},;

aStru := {	{"CLIENTE", "C", 06, 0},;
{"LOJA"		, "C", 02, 0},;
{"NOME"		, "C", 50, 0},;
{"EMISSAO" 	, "D", 08, 0},;
{"PEDIDO"   , "C", 06, 0},;
{"PRODUTO"	, "C", 30, 0},;
{"QUANT"	, "N", 17, 2},;
{"PRECO"	, "N", 17, 2},;
{"VALOR"	, "N", 17, 2},;
{"IPI"	, "N", 17, 2},;
{"ICM"	, "N", 17, 2},;
{"ICMST"	, "N", 17, 2},;
{"VENDEDOR"	, "C", 40, 0},;
{"COMISSAO"	, "N", 06, 2},;
{"TIPO"	 	, "C", 15, 0},;
{"TES"		, "C", 03, 0},;
{"GRUPO"	, "C", 04, 0}   }

dbCreate(cDirDocs+"\"+cArquivo,aStru,"dbfcdxads")
dbUseArea(.T.,"dbfcdxads",cDirDocs+"\"+cArquivo,cArquivo,.F.,.F.)

cQuery := " "

if SELECT ("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea("TRB1")
endif

cQuery += " SELECT D1_FORNECE COD, D1_LOJA LOJA, A2_NOME NOME, D1_EMISSAO EMISSAO,D1_PEDIDO PEDIDO,D1_DOC NF, "+CRLF
//cQuery += " case  when C5_NOTA <> '' then 'Faturado'  else 'Liberado'  end ESTATUS, "+CRLF
cQuery += " D1_COD   PRODUTO, "+CRLF
cQuery += " D1_QUANT  QUANT, D1_VUNIT  PRECO, D1_TOTAL VALOR, "+CRLF
cQuery += " D1_VALIPI IPI, D1_VALICM ICM, D1_VALICM-D1_ICMSRET ICMST, "+CRLF
//cQuery += " A1_DESC DESCCLI, C5_DESC1 DESCPED, C6_DESCONT DESCIT, "+CRLF
//cQuery += " A3_NOME VENDEDOR, D1_COMIS1 COMISSAO, "+CRLF
//cQuery += " case  "+CRLF
//cQuery += "     when F1_TIPOCLI = 'F' then 'Cons. Final'  "+CRLF
//cQuery += "     when F1_TIPOCLI = 'L' then 'Prod. Rural'  "+CRLF
//cQuery += "     when F1_TIPOCLI = 'R' then 'Revendedor'  "+CRLF
//cQuery += "     when F1_TIPOCLI = 'S' then 'Solidario'  "+CRLF
//cQuery += "     when F1_TIPOCLI = 'X' then 'Exportacao/Importacao'  "+CRLF
//cQuery += "   end TIPO, "+CRLF
cQuery += " D1_TES TES "+CRLF
cQuery += " FROM "+ RetSqlName("SD1") +" SD1, "+ RetSqlName("SA2") +" SA2,"+ RetSqlName("SF1") +" SF1, "+ RetSqlName("SB1") +" SB1 "+CRLF
cQuery += " WHERE SD1.D_E_L_E_T_ <> '*' AND SA2.D_E_L_E_T_ <> '*' AND SF1.D_E_L_E_T_ <> '*'  AND SB1.D_E_L_E_T_ <> '*'  "+CRLF
cQuery += " AND SF1.F1_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+CRLF
//cQuery += " AND SD2.D2_ENTREG BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' "+CRLF
cQuery += " AND SF1.F1_FORNECE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
//cQuery += " AND SF2.F2_VEND1 BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF
cQuery += " AND SF1.F1_FORNECE = SA2.A2_COD "+CRLF
cQuery += " AND SF1.F1_LOJA = SA2.A2_LOJA "+CRLF
cQuery += " AND SF1.F1_DOC = SD1.D1_DOC "+CRLF
//cQuery += " AND SA3.A3_COD = SF2.F2_VEND1  "+CRLF
cQuery += " AND SD1.D1_COD = SB1.B1_COD "+CRLF
cQuery += " AND SF1.F1_TIPO = 'D' "+CRLF

//VALIDA QUERY
cQryOk:=cQuery
cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.)

TRB1->(dbGotop())
While TRB1->(!Eof())
	RecLock(cArquivo, .T.)
	(cArquivo)->CLIENTE	:= TRB1->COD
	(cArquivo)->LOJA	:= TRB1->LOJA
	(cArquivo)->NOME	:= TRB1->NOME
	(cArquivo)->EMISSAO	:= STOD(TRB1->EMISSAO)
//	(cArquivo)->ENTREGA	:= STOD(TRB1->ENTREGA)
	(cArquivo)->PEDIDO	:= TRB1->PEDIDO
//	(cArquivo)->ESTATUS	:= TRB1->ESTATUS
	(cArquivo)->PRODUTO := TRB1->PRODUTO 
	(cArquivo)->QUANT	:= TRB1->QUANT
	(cArquivo)->PRECO	:= TRB1->PRECO
//	(cArquivo)->UNITA	:= TRB1->UNITARIO
	(cArquivo)->VALOR	:= TRB1->VALOR
	(cArquivo)->ICM  	:= TRB1->ICM  
	(cArquivo)->ICMST	:= TRB1->ICMST
	(cArquivo)->IPI  	:= TRB1->IPI  
//	(cArquivo)->DESCCLI	:= TRB1->DESCCLI
//	(cArquivo)->DESCPED	:= TRB1->DESCPED
//	(cArquivo)->DESCIT	:= TRB1->DESCIT
//	(cArquivo)->VENDEDOR:= TRB1->VENDEDOR
//	(cArquivo)->COMISSAO:= TRB1->COMISSAO
//	(cArquivo)->TIPO	:= TRB1->TIPO
	(cArquivo)->TES		:= TRB1->TES
	
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

Static Function AjustaSX1(cPerg)

Local aRea	:= GetArea()
Local aSx1	:= {}

DBSelectArea("SX1")
SX1->(DBSetOrder(1))
cPerg := PadR(cPerg, Len(SX1->X1_GRUPO))
SX1->(DBSeek(cPerg+"01"))

AADD(	aSx1,{ cPerg,"01","Emissao de"			,"mv_par01"	,"D",08,0,0,"G","", "mv_par01","","","","","","" } )
AADD(	aSx1,{ cPerg,"02","Emissao ate"			,"mv_par02"	,"D",08,0,0,"G","",	"mv_par02","","","","","","" } )
AADD(	aSx1,{ cPerg,"05","Cliente de"			,"mv_par05"	,"C",06,0,0,"G","", "mv_par05","","","","","SA2","" } )
AADD(	aSx1,{ cPerg,"06","Cliente ate"			,"mv_par06"	,"C",06,0,0,"G","",	"mv_par06","","","","","SA2","" } )
//AADD(	aSx1,{ cPerg,"07","Vendedor de"			,"mv_par07"	,"C",06,0,0,"G","", "mv_par07","","","","","SA3","" } )
//AADD(	aSx1,{ cPerg,"08","Vendedor ate"		,"mv_par08"	,"C",06,0,0,"G","",	"mv_par08","","","","","SA3","" } )
//AADD(	aSx1,{ cPerg,"03","Entrega de"			,"mv_par03"	,"D",08,0,0,"G","", "mv_par03","","","","","","" } )
//AADD(	aSx1,{ cPerg,"04","Entrega ate"			,"mv_par04"	,"D",08,0,0,"G","",	"mv_par04","","","","","","" } )

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
			SX1->X1_PRESEL		:= aSx1[i][8] //Pre seleção do combo
			SX1->X1_GSC			:= aSx1[i][9] //Tipo de componente
			SX1->X1_VAR01		:= aSx1[i][10]//Variavel que carrega resposta
			SX1->X1_DEF01		:= aSx1[i][11]//Definições do combo-box
			SX1->X1_DEF02		:= aSx1[i][12]
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
