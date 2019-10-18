#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DAI002   ³ Autor ³ Edilson Nascimento    ³ Data ³ 29.05.13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa utilizado para a extracao de pedidos.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Void DAI001(void)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Faturamento                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
USER FUNCTION DAI002()

Local cQuery
Local cDirDocs  := MsDocPath()
Local aStru		:= {}
Local cArquivo  := CriaTrab(,.F.)
Local cPath		:= AllTrim(GetTempPath())
Local oExcelApp
Local cPerg	    := AllTrim( "EXFATI" )


	AjustaSx1(cPerg)
	IF Pergunte(cPerg, .T.)
		
		If Select("TRB1") > 0
			DbSelectArea("TRB1")
			DbCloseArea("TRB1")
		EndIf
		
		cQuery := " SELECT D2_CLIENTE COD, D2_LOJA LOJA, A1_NOME NOME, D2_EMISSAO EMISSAO,D2_PEDIDO PEDIDO,D2_DOC NF,F2_TIPO TIPOP,F2_TIPOCLI TIPOC, F2_FRETE FRETE, "+CRLF
		//cQuery += " case  when C5_NOTA <> '' then 'Faturado'  else 'Liberado'  end ESTATUS, "+CRLF
		cQuery += " B1_XCODCAT CODDAISA, D2_COD PRODUTO, "+CRLF
		cQuery += " D2_QUANT  QUANT, D2_PRCVEN PRECO, D2_TOTAL VALOR, "+CRLF
		cQuery += " D2_VALIPI IPI, D2_VALICM ICMS,
		cQuery += " case  "+CRLF
		cQuery += " when D2_ICMSRET = 0 then 0 "+CRLF
		cQuery += " when D2_VALICM<D2_ICMSRET then D2_ICMSRET "+CRLF
		cQuery += " when D2_VALICM>D2_ICMSRET then D2_VALICM-D2_ICMSRET end ICMST, "+CRLF
		//cQuery += " A1_DESC DESCCLI, C5_DESC1 DESCPED, C6_DESCONT DESCIT, "+CRLF
		cQuery += " A3_NOME VENDEDOR, D2_COMIS1 COMISSAO, "+CRLF
		cQuery += " case  "+CRLF
		cQuery += "     when F2_TIPOCLI = 'F' then 'Cons. Final'  "+CRLF
		cQuery += "     when F2_TIPOCLI = 'L' then 'Prod. Rural'  "+CRLF
		cQuery += "     when F2_TIPOCLI = 'R' then 'Revendedor'  "+CRLF
		cQuery += "     when F2_TIPOCLI = 'S' then 'Solidario'  "+CRLF
		cQuery += "     when F2_TIPOCLI = 'X' then 'Exportacao/Importacao'  "+CRLF
		cQuery += "   end TIPO, "+CRLF
		cQuery += " D2_TES TES,D2_CF CFOP, X5_DESCRI DESC_CFOP "+CRLF
		cQuery += " FROM "+ RetSqlName("SD2") +" SD2, "+ RetSqlName("SA1") +" SA1,"+ RetSqlName("SF2") +" SF2, "+ RetSqlName("SA3") +" SA3, "+ RetSqlName("SB1") +" SB1,"+ RetSqlName("SX5") +" SX5 "+CRLF
		cQuery += " WHERE SD2.D_E_L_E_T_ = '' AND SA1.D_E_L_E_T_ = '' AND SF2.D_E_L_E_T_ = '' AND SA3.D_E_L_E_T_ = '' AND SB1.D_E_L_E_T_ = ''  "+CRLF
		cQuery += " AND SF2.F2_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+CRLF
		//cQuery += " AND SD2.D2_ENTREG BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' "+CRLF
		cQuery += " AND SF2.F2_CLIENTE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
		cQuery += " AND SF2.F2_VEND1 BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF
		cQuery += " AND SF2.F2_CLIENTE = SA1.A1_COD "+CRLF
		cQuery += " AND SF2.F2_LOJA = SA1.A1_LOJA "+CRLF
		cQuery += " AND SF2.F2_DOC = SD2.D2_DOC "+CRLF
		cQuery += " AND SA3.A3_COD = SF2.F2_VEND1  "+CRLF
		cQuery += " AND SD2.D2_COD = SB1.B1_COD "+CRLF
		cQuery += " AND SD2.D2_CF NOT IN ('5901','6901') "+CRLF
		cQuery += " AND SD2.D2_TIPO NOT IN ('B','D','I') "+CRLF
		cQuery += " AND SX5.X5_TABELA = '13' AND X5_CHAVE = SD2.D2_CF "+CRLF
		
		//VALIDA QUERY
		cQuery := ChangeQuery(cQuery)
		MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.)},"Selecionando Registros...") //"Selecionando Registros..."	
		
		//{"ENTREGA" 	, "D", 08, 0},;
		//{"ESTATUS"	, "C", 15, 0},;
		//{"CODDAISA"	, "C", 30, 0},;
		//{"DESCCLI"	, "N", 06, 2},;
		//{"DESCPED"	, "N", 06, 2},;
		//{"DESCIT"	, "N", 06, 2},;
		
		aStru := {	;
                    {"NF" 	  , "C", 09, 0},;
                    {"PEDIDO"   , "C", 06, 0},;
                    {"CLIENTE", "C", 06, 0},;
                    {"LOJA"		, "C", 02, 0},;
                    {"NOME"		, "C", 50, 0},;
                    {"EMISSAO" 	, "D", 08, 0},;
                    {"PRODUTO"	, "C", 30, 0},;
                    {"PRODUTO2"	, "C", 30, 0},;
                    {"QUANT"	, "N", 17, 2},;
                    {"PRECO"	, "N", 17, 2},;
                    {"VALOR"	, "N", 17, 2},;
                    {"FRETE"	, "N", 17, 2},;
                    {"IPI"	, "N", 17, 2},;
                    {"ICMS"	, "N", 17, 2},;
                    {"ICMST"	, "N", 17, 2},;
                    {"VENDEDOR"	, "C", 40, 0},;
                    {"COMISSAO"	, "N", 06, 2},;
                    {"TIPO"	 	, "C", 15, 0},;
                    {"TES"		, "C", 03, 0},;
                    {"CFOP"	, "C", 04, 0}   ,;
                    {"DCFOP"	, "C", 25, 0}   }
		
		DbCreate(cDirDocs+"\"+cArquivo,aStru,"dbfcdxads")
		DbUseArea(.T.,"dbfcdxads",cDirDocs+"\"+cArquivo,cArquivo,.F.,.F.)
		
		TRB1->(dbGotop())
		While TRB1->(!Eof())
			
			VAL_IPI := 0
			VAL_TOT := 0
			VAL_ST  := 0
			ST_AUX  := 0
			
			nItem   := 1
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
			         TRB1->PRECO   ,;		  	// 4-Preco Unitario ( Obrigatorio )
			         0,; 	// 5-Valor do Desconto ( Opcional )
			         "",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
			         "",;				// 7-Serie da NF Original ( Devolucao/Benef )
			         0,;					// 8-RecNo da NF Original no arq SD1/SD2
			         0,;					// 9-Valor do Frete do Item ( Opcional )
			         0,;					// 10-Valor da Despesa do item ( Opcional )
			         0,;					// 11-Valor do Seguro do item ( Opcional )
			         0,;					// 12-Valor do Frete Autonomo ( Opcional )
			         TRB1->VALOR,;			// 13-Valor da Mercadoria ( Obrigatorio )
			         0)					// 14-Valor da Embalagem ( Opiconal )
			
			VAL_IPI := MaFisRet( nItem, "IT_VALIPI")
			VAL_TOT := MaFisRet( nItem, "IT_VALICM")
			VAL_ST  := Iif(MaFisRet( nItem, "IT_VALSOL") > 0, MaFisRet( nItem, "IT_VALSOL" ), 0 )
			
			RecLock(cArquivo, .T.)
			(cArquivo)->CLIENTE	:= TRB1->COD
			(cArquivo)->LOJA	:= TRB1->LOJA
			(cArquivo)->NOME	:= TRB1->NOME
			(cArquivo)->EMISSAO	:= STOD(TRB1->EMISSAO)
			//	(cArquivo)->ENTREGA	:= STOD(TRB1->ENTREGA)
			(cArquivo)->PEDIDO	:= TRB1->PEDIDO
			(cArquivo)->NF     	:= TRB1->NF
			(cArquivo)->PRODUTO := TRB1->CODDAISA
			(cArquivo)->PRODUTO2 := TRB1->PRODUTO
			(cArquivo)->QUANT	:= TRB1->QUANT
			(cArquivo)->PRECO	:= TRB1->PRECO
			//	(cArquivo)->UNITA	:= TRB1->UNITARIO
			(cArquivo)->VALOR	:= TRB1->VALOR
			(cArquivo)->FRETE	:= TRB1->FRETE
			(cArquivo)->ICMS 	:= VAL_TOT
			(cArquivo)->ICMST	:= VAL_ST
			(cArquivo)->IPI  	:= TRB1->IPI
			//	(cArquivo)->DESCCLI	:= TRB1->DESCCLI
			//	(cArquivo)->DESCPED	:= TRB1->DESCPED
			//	(cArquivo)->DESCIT	:= TRB1->DESCIT
			(cArquivo)->VENDEDOR:= TRB1->VENDEDOR
			(cArquivo)->COMISSAO:= TRB1->COMISSAO
			(cArquivo)->TIPO	:= TRB1->TIPO
			(cArquivo)->TES		:= TRB1->TES
			(cArquivo)->CFOP	:= TRB1->CFOP
			(cArquivo)->DCFOP	:= TRB1->DESC_CFOP
			
			TRB1->(dbSkip())
			
		ENDDO
		
		DbSelectArea(cArquivo)
		DbCloseArea()
		
		CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , "C:\TEMP\", .T. )
		
		__CopyFIle("C:\TEMP\"+cArquivo+".DBF", "C:\TEMP\"+cArquivo+".XLS")
		
		FErase("C:\TEMP\"+cArquivo+".DBF")
		
		If ApOleClient( "MsExcel" )
			
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( "c:\temp\"+cArquivo+".XLS" ) // Abre uma planilha
			oExcelApp:SetVisible(.T.)
			DbSelectArea("TRB1")
			dbclosearea()
			
		Else
			MsgStop( "Ocorreu um Erro. Tente Novamente." )
		Endif
		
	EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³ Vitor Daniel       º Data ³  07/05/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pergunte da tela                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ DAI002                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Procedure AjustaSX1(cPerg)

Local nPos
Local aRea:= GetArea()
Local aSx1	:= {}

	DBSelectArea("SX1")
	SX1->(DBSetOrder(1))
	IF .NOT. SX1->( DBSeek( cPerg ) ) //+"01" ) )
		
		AADD(	aSx1,{ cPerg,"01","Emissao de"			,"mv_par01"	,"D",08,0,0,"G","", "mv_par01","","","","","","" } )
		AADD(	aSx1,{ cPerg,"02","Emissao ate"			,"mv_par02"	,"D",08,0,0,"G","",	"mv_par02","","","","","","" } )
		AADD(	aSx1,{ cPerg,"03","Entrega de"			,"mv_par03"	,"D",08,0,0,"G","", "mv_par03","","","","","","" } )
		AADD(	aSx1,{ cPerg,"04","Entrega ate"			,"mv_par04"	,"D",08,0,0,"G","",	"mv_par04","","","","","","" } )
		AADD(	aSx1,{ cPerg,"05","Cliente de"			,"mv_par05"	,"C",06,0,0,"G","", "mv_par05","","","","","SA1","" } )
		AADD(	aSx1,{ cPerg,"06","Cliente ate"			,"mv_par06"	,"C",06,0,0,"G","",	"mv_par06","","","","","SA1","" } )
		AADD(	aSx1,{ cPerg,"07","Vendedor de"			,"mv_par07"	,"C",06,0,0,"G","", "mv_par07","","","","","SA3","" } )
		AADD(	aSx1,{ cPerg,"08","Vendedor ate"		,"mv_par08"	,"C",06,0,0,"G","",	"mv_par08","","","","","SA3","" } )
		
		//If SX1->X1_GRUPO != cPerg
		For nPos := 1 To Len( aSx1 )
			If !SX1->( DBSeek( aSx1[ nPos ][1] + aSx1[ nPos ][2] ) )
				Reclock( "SX1", .T. )
				SX1->X1_GRUPO   := aSx1[ nPos ][1] //Grupo
				SX1->X1_ORDEM   := aSx1[ nPos ][2] //Ordem do campo
				SX1->X1_PERGUNT := aSx1[ nPos ][3] //Pergunta
				SX1->X1_PERSPA  := aSx1[ nPos ][3] //Pergunta Espanhol
				SX1->X1_PERENG  := aSx1[ nPos ][3] //Pergunta Ingles
				SX1->X1_VARIAVL := aSx1[ nPos ][4] //Variavel do campo
				SX1->X1_TIPO    := aSx1[ nPos ][5] //Tipo de valor
				SX1->X1_TAMANHO := aSx1[ nPos ][6] //Tamanho do campo
				SX1->X1_DECIMAL := aSx1[ nPos ][7] //Formato numerico
				SX1->X1_PRESEL  := aSx1[ nPos ][8] //Pre seleção do combo
				SX1->X1_GSC     := aSx1[ nPos ][9] //Tipo de componente
				SX1->X1_VAR01   := aSx1[ nPos ][10]//Variavel que carrega resposta
				SX1->X1_DEF01   := aSx1[ nPos ][11]//Definições do combo-box
				SX1->X1_DEF02   := aSx1[ nPos ][12]
				SX1->X1_DEF03   := aSx1[ nPos ][13]
				SX1->X1_DEF04   := aSx1[ nPos ][14]
				SX1->X1_VALID   := aSx1[ nPos ][15]
				SX1->X1_F3      := aSx1[ nPos ][16]
				MsUnlock()
			Endif
		Next
	Endif
	
	RestArea(aRea)
	
Return(cPerg)
                   																																