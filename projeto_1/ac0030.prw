#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "AC0030.CH"

STATIC aRelato := StoreRelato()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออปฑฑ
ฑฑบPrograma    ณ AC0030    บAutor  ณ Vitor Daniel       บ Data ณ  27/10/10      บฑฑ
ฑฑฬออออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.       ณ IMPRIME O ORCAMENTO 											บฑฑ
ฑฑศออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION AC0030( cNumOrc )

Local cPerg	:= AllTrim( "DA_ORCAMEN" )

	//DEFININDO AS FONTS
	DEFINE FONT aRelato.oFont02 NAME "Arial" SIZE 0,09 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont03 NAME "Arial" SIZE 0,11 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont04 NAME "Arial" SIZE 0,11 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont07 NAME "Arial" SIZE 0,09 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont08 NAME "Arial" SIZE 0,09 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont09 NAME "Arial" SIZE 0,16 OF aRelato.oPrn BOLD
	
    //Define o Numero de Linhas por Pagina
	aRelato.nTotLinPag := 2200
	
	AjustaSx1(cPerg)
	IF Pergunte( cPerg, .T. )
		
		aRelato.oPrn := TMSPrinter():New( "Impressใo de Or็amento Instrument" )
		IF aRelato.oPrn:Setup()
		
			RegOrc()
			
			aRelato.oPrn:SetLAndScape()			
			
			aRelato.oPrn:Preview()
			
			aRelato.oPrn:End()
			
			Ms_Flush()
			
		EndIf
		
	EndIf
			
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRegOrc     บAutor  ณVitor Daniel        บ Data ณ  05/05/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Dados do Orcamento Contemp                                  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                             บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC PROCEDURE RegOrc()

Local cQuery

	cQuery := " SELECT ORC.CJ_NUM ORCA, ORC.CJ_FILIAL FILIAL, "
	cQuery += "   CASE WHEN (ORC.CJ_CLIENTE <> '000000') THEN CLI.A1_EST ELSE PROSP.US_EST end ESTADO, "
	cQuery += "   CASE WHEN (ORC.CJ_CLIENTE <> '000000') THEN CLI.A1_INSCR ELSE PROSP.US_INSCR end INSCR, "
	cQuery += "   CASE WHEN (ORC.CJ_CLIENTE <> '000000') THEN CLI.A1_TIPO ELSE PROSP.US_TIPO end DESTINO, "
	cQuery += "   SUBSTRING(CJ_EMISSAO,7,2) + '/' + SUBSTRING(CJ_EMISSAO,5,2) + '/' + SUBSTRING(CJ_EMISSAO,1,4) EMISSAO, "
	cQuery += "   ORC.CJ_CLIENTE CODCLI, "
	cQuery += "   ORC.CJ_LOJA LOJACLI, "
	//cQuery += "   CASE WHEN (ORC.CJ_CLIENTE <> '000000') THEN CLI.A1_NOME WHEN ORC.CJ_PROSPE = '' THEN CLI.A1_NOME ELSE PROSP.US_NOME END CLIENTE, "
	cQuery += "   CASE WHEN (ORC.CJ_CLIENTE <> '000000') AND ORC.CJ_PROSPE IN (' ','F') THEN CLI.A1_NOME ELSE PROSP.US_NOME END CLIENTE, "
	cQuery += "   CLI.A1_DESCREG REGIAO, "
	cQuery += "   CONT.U5_CONTAT CONTATO, "
	cQuery += "   ' ( ' + RTRIM(CONT.U5_DDD) + ' ) ' + RTRIM(CONT.U5_FONE) FONE_CONTATO, "
	cQuery += "   CONT.U5_EMAIL EMAIL_CONTATO, "
	cQuery += "   VEND.A3_NOME VENDEDOR, "
	cQuery += "   VEND.A3_TEL TEL_VEND, "
	cQuery += "   VEND.A3_EMAIL EMAIL_VEND, "
	cQuery += "   ORC.CJ_EMITENT EMITENTE, "
	cQuery += "   ORC.CJ_CODOBS CODOBS, "
	cQuery += "   COND.E4_DESCRI COND_PAGTO, "
	cQuery += "	  ORC.CJ_COTCLI PEDCLI, "
	cQuery += "   CASE WHEN ORC.CJ_PROSPE IN (' ','F') THEN CLI.A1_EST ELSE PROSP.US_EST END ESTCLI "
	cQuery += " FROM  "
	cQuery += RetSqlName("SCJ") + " ORC "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SA1") + " CLI "
	cQuery += " ON "
	cQuery += "   CLI.A1_COD = ORC.CJ_CLIENTE "
	cQuery += "   AND CLI.A1_LOJA = ORC.CJ_LOJA "
	cQuery += "   AND CLI.D_E_L_E_T_ = '' "
	cQuery += "   AND ORC.D_E_L_E_T_ = '' "
	cQuery += "   AND A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SE4") + " COND "
	cQuery += " ON "
	cQuery += "   COND.E4_CODIGO = ORC.CJ_CONDPAG "
	cQuery += "   AND COND.D_E_L_E_T_ = '' "
	cQuery += "   AND E4_FILIAL = '" + xFilial("SE4") + "'"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SA3") + " VEND "
	cQuery += " ON "
	cQuery += "   VEND.A3_COD = ORC.CJ_CODVEND "
	cQuery += "   AND A3_FILIAL = '" + xFilial("SA3") + "'"
	cQuery += "   AND VEND.D_E_L_E_T_ = '' "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SU5") + " CONT "
	cQuery += " ON "
	cQuery += "   CONT.U5_CODCONT = ORC.CJ_CODCONT "
	cQuery += "   AND CONT.D_E_L_E_T_ = '' "
	cQuery += "   AND U5_FILIAL = '" + xFilial("SU5") + "'"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SUS") + " PROSP "
	cQuery += " ON "
	cQuery += "   PROSP.US_COD = ORC.CJ_CLIENTE"//ORC.CJ_PROSPE "
	cQuery += "   and PROSP.D_E_L_E_T_ = '' "
	cQuery += "   AND US_FILIAL = '" + xFilial("SUS") + "'"
	cQuery += " WHERE  "
	cQuery += " ORC.CJ_NUM >= '" + MV_PAR01 + "' AND"
	cQuery += " ORC.CJ_NUM <= '" + MV_PAR02 + "' "
	cQuery += "   AND ORC.CJ_FILIAL = '" + xFilial("SCJ") + "' "
	cQuery += "   AND ORC.D_E_L_E_T_ = '' "
	
	If Select("TRB1") > 0
		TRB1->(DbCloseArea())
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	DbSelectArea("SCJ")
	SCJ->( DbSetOrder(1) )
	SCJ->( DbSeek( xFilial("SCJ")+TRB1->ORCA ) )
	
	WHILE TRB1->( ! EOF() )
		aRelato.oPrn:StartPage()
		
		aRelato.nPagina := 0
		
		LayOutOP()
		
		aRelato.oPrn:EndPage()
		
		TRB1->(dbSkip())
				
	ENDDO
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLayOutOP  บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Layout do Orcamento                           			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTFR0001                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC PROCEDURE LayOutOP()

Local nPos
Local cObs
Local cQuery
Local nVTmerc	 := 0
Local nQtdPeso	 := 0
Local nItem		 := 0

PRIVATE cTam      := 50
PRIVATE lRod      := .T.
PRIVATE cNomeUser := ""

	//CABECALHO
	Cabec()
	
	lRod := .F.
	cCol := 430
	
	aRelato.oPrn:Say(cCol,0100,"Cliente:", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,0350,TRB1->CODCLI + ' - ' + TRB1->CLIENTE, aRelato.oFont03 )                    //CLIENTE
	
	//aRelato.oPrn:Say(cCol,2300,"Regiใo:", aRelato.oFont04)
	//aRelato.oPrn:Say(cCol,2450,TRB1->REGIAO, aRelato.oFont03 )
	
	cCol += 60
	aRelato.oPrn:Say( cCol, 0100, "A/C:", aRelato.oFont04)
	aRelato.oPrn:Say( cCol, 0350, TRANSFORM( TRB1->CONTATO, PesqPict("SU5","U5_CONTAT", TamSx3("U5_CONTAT")[1] ) ), aRelato.oFont03 )
	aRelato.oPrn:Say( cCol, 1700, "Fone:", aRelato.oFont04)
	aRelato.oPrn:Say( cCol, 1850, TRB1->FONE_CONTATO, aRelato.oFont03)
	aRelato.oPrn:Say( cCol, 2300, "E-mail:", aRelato.oFont04)
	aRelato.oPrn:Say( cCol, 2450, TRANSFORM( TRB1->EMAIL_CONTATO, PesqPict("SU5","U5_EMAIL", TamSx3("U5_EMAIL")[1] ) ), aRelato.oFont03)
	
	cCol += 60
	aRelato.oPrn:Line(cCol,0080,cCol,3150)
	
	cCol += 40
	aRelato.oPrn:Say( cCol, 0100, "Representante:", aRelato.oFont04)
	aRelato.oPrn:Say( cCol, 0400, TRANSFORM( TRB1->VENDEDOR, PesqPict("SA3","A3_NOME", TamSx3("A3_NOME")[1] ) ), aRelato.oFont03)
	aRelato.oPrn:Say( cCol, 1700, "Fone:", aRelato.oFont04)
	aRelato.oPrn:Say( cCol, 1850, TRANSFORM( TRB1->TEL_VEND, PesqPict("SA3","A3_TEL", TamSx3("A3_TEL")[1] ) ), aRelato.oFont03)
	aRelato.oPrn:Say( cCol, 2300, "E-mail:", aRelato.oFont04)
	aRelato.oPrn:Say( cCol, 2450, TRANSFORM( TRB1->EMAIL_VEND, PesqPict("SA3","A3_EMAIL", TamSx3("A3_EMAIL")[1] ) ), aRelato.oFont03)
	
	cCol += 60
	
	DbSelectArea("SU7")
	SU7->( DbSetOrder(1) )
	If SU7->( DbSeek(xFilial("SU7") + TRB1->EMITENTE ) )
		cNomeUser := SU7->U7_NOME
	EndIf
	
	//PEGA OS DADOS DO CFOP
	cQuery := " SELECT DISTINCT "
	cQuery += "   CK_NUM ORCAMENTO, "
	cQuery += "   CK_CLASFIS CF, "
	cQuery += "   F4_TEXTO TEXTO "
	cQuery += " FROM "
	cQuery += RetSqlName("SCK") + " PED "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SF4") + " TES "
	cQuery += " ON "
	cQuery += "   F4_CODIGO = CK_TES "
	cQuery += "   AND TES.D_E_L_E_T_ = '' "
	cQuery += "   AND F4_FILIAL = '" + xFilial("SF4") + "' "
	cQuery += " WHERE "
	cQuery += "   CK_NUM = '" + TRB1->ORCA + "' "
	cQuery += "   AND PED.D_E_L_E_T_ = '' "
	cQuery += "   AND PED.CK_FILIAL  = '" + xFilial("SCK") + "' "
	cQuery += " ORDER BY 2 "
	
	If SELECT ("TRB5") > 0
		DbSelectArea("TRB5")
		DbCloseArea("TRB5")
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB5',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	aRelato.oPrn:Say(cCol,0100,"Emitente:", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,0400,cNomeUser, aRelato.oFont03 )
	
	cCol += 80
	aRelato.oPrn:Line(cCol,0080,cCol,3150)
	
	//VERIFICA SE O CLIN ATINGE 2400
	fVerPag()
	
	//CABECALHO ITENS DO ORCAMENTO
	cCol += 10
	
	//PARTE 4
	aRelato.oPrn:Say(cCol,0100,"Item", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,0200,"C๓digo", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,0600,"Descri็ใo", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,1800,"Qtd.", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,1970,"Apr.", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,2200,"Val. Unit.", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,2400,"% ICMS", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,2600,"Val. Total", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,2850,"% IPI", aRelato.oFont08)
	aRelato.oPrn:Say(cCol,2980,"Item Cli.", aRelato.oFont08)
	
	cCol += 50
	aRelato.oPrn:Line(cCol,0080,cCol,3150)
	
	cQuery := " SELECT "
	cQuery += "   CK_NUM ORCAMENTO, "
	cQuery += "   CK_ITEM ITEM, "
	cQuery += "   RTRIM(I_ORC.CK_PRODUTO) COD_PRODUTO, "
	cQuery += "   RTRIM(B1_XCODCAT)CODIGO, "
	cQuery += "   RTRIM(B1_DESCOMP) PRODUTO, "
	cQuery += "   B1_UM UNIDADE, "
	cQuery += "   CK_QTDVEN QTDE, "
	cQuery += "   CK_PRCVEN VAL_UNIT, "
	cQuery += "   CK_VALOR VALOR, "
	cQuery += "   CK_ITECLI ITEM, "
	cQuery += "   CASE WHEN F4_IPI = 'S' THEN B1_IPI ELSE 0 END IPI, "
	cQuery += "   B1_PICM ICMS, "
	cQuery += "   CJ_DESC1 DESCONTO, "//CK_DESC DESCONTO, "
	cQuery += "   F4_ICM ICM, "
	cQuery += "   B1_POSIPI CLASSFISC "
	cQuery += " FROM "
	cQuery += RetSqlName("SCK") + " I_ORC "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SB1") + " PROD "
	cQuery += " ON "
	cQuery += "   PROD.B1_COD = I_ORC.CK_PRODUTO "
	cQuery += "   AND B1_FILIAL = '" + xFilial("SB1") + "'"
	cQuery += "   AND PROD.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SCJ") + " ORC "
	cQuery += " ON "
	cQuery += "   ORC.CJ_NUM = I_ORC.CK_NUM "
	cQuery += "   AND CJ_FILIAL = '" + xFilial("SCJ") + "'"
	cQuery += "   AND ORC.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SF4") + " TES "
	cQuery += " ON "
	cQuery += "   TES.F4_CODIGO = I_ORC.CK_TES "
	cQuery += "   AND TES.D_E_L_E_T_ = '' "
	cQuery += "   AND F4_FILIAL = '" + xFilial("SF4") + "'"
	cQuery += " WHERE "
	cQuery += "   I_ORC.D_E_L_E_T_ = '' "
	cQuery += "   and CK_NUM = '" + TRB1->ORCA+ "' "      //PEGAR O NUMERO DO ORCAMENTO
	cQuery += "   and CK_FILIAL = '" + TRB1->FILIAL+ "' " //PEGAR A FILIAL DO ORCAMENTO
	cQuery += " ORDER BY CK_NUM, CK_ITEM"
	
	If Select("TRB2") > 0
		TRB2->(DbCloseArea())
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB2',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณLOOPING PARA PEGAR ITENS DO ORCAMENTOณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//	nPorc := TRB2->DESCONTO
	While TRB2->( .Not. Eof() ) .And. TRB2->ORCAMENTO == TRB1->ORCA
		
		cColu := 0
		
		//VERIFICA SE O CLIN ATINGE 2400
		//		Iif( cCol+100 > 2350, (cCol:=2351), NIL)  //teste se vai caber o item na pagina
		Iif( cCol+100 > aRelato.nTotLinPag, (cCol := 2351, lRod := .F. ), NIL)  //teste se vai caber o item na pagina
		fVerPag()
		
		nPerRet   := 0                // Percentual de retorno
		cEstado   := GetMV("MV_ESTADO")
		tNorte    := GetMV("MV_NORTE")
		
		cEstCli   := TRB1->ESTADO
		cInscrCli := TRB1->INSCR
		
		If TRB2->ICM == "S"
			If TRB1->DESTINO == "F" .and. Empty(cInscrCli)
				nPerRet := iif(TRB2->ICMS>0,TRB2->ICMS,GetMV("MV_ICMPAD"))
			Elseif TRB1->DESTINO == "F" .and. ALLTRIM(UPPER(cInscrCli)) == "ISENTO"
				nPerRet := iif(TRB2->ICMS>0,TRB2->ICMS,GetMV("MV_ICMPAD"))
			Elseif TRB2->ICMS > 0 .And. cEstCli == cEstado
				nPerRet := TRB2->ICMS
			Elseif cEstCli == cEstado
				nPerRet := GetMV("MV_ICMPAD")
			Elseif cEstCli $ tNorte .And. At(cEstado,tNorte) == 0
				nPerRet := 7
			Elseif TRB1->DESTINO == "X"
				nPerRet := 13
			Else
				nPerRet := 12
			Endif
		Endif
		
		//ITEM
		aRelato.oPrn:Say(cCol+cTam,0120,TRB2->ITEM, aRelato.oFont07)
		
		//CODIGO PRODUTO
		cCodCli := POSICIONE("SA7",1,xFilial("SA7")+TRB1->CODCLI+TRB1->LOJACLI+TRB2->COD_PRODUTO,"A7_CODCLI")
		cCodCli := IIF( Empty( cCodCli ), POSICIONE("SB1",1,xFilial("SB1")+TRB2->COD_PRODUTO,"B1_COD"), cCodCli )
		aRelato.oPrn:Say( cCol+cTam, 0200, TRANSFORM( cCodCli, PesqPict("SB1","B1_COD", TamSx3("B1_COD")[1] ) ), aRelato.oFont07)
		
		//VERIFICA QUANTIDADE DE CARACTERES
		cCodDesc := Alltrim(TRB2->PRODUTO)
		
		//DESCRICAO DO PRODUTO
		If Len( Alltrim(TRB2->PRODUTO) ) <= 100 // 45
			aRelato.oPrn:Say(cCol+cTam,0610, TRANSFORM( cCodDesc, PesqPict("SB1","B1_DESCOMP", TamSx3("B1_DESCOMP")[1] ) ), aRelato.oFont07)
			cColu := cCol+cTam
		ElseIf Len( Alltrim(TRB2->PRODUTO) ) <= 110
			aRelato.oPrn:Say(cCol+cTam,0610,     TRANSFORM( SUBSTR( cCodDesc,  1, 45), PesqPict("SB1","B1_DESCOMP", TamSx3("B1_DESCOMP")[1] ) ), aRelato.oFont07)
			aRelato.oPrn:Say(cCol+cTam+cTam,0610,TRANSFORM( SUBSTR( cCodDesc, 46, 45), PesqPict("SB1","B1_DESCOMP", TamSx3("B1_DESCOMP")[1] ) ), aRelato.oFont07)
			cColu := cCol+cTam+cTam
		Else
			aRelato.oPrn:Say(cCol+cTam,0610,           TRANSFORM( SUBSTR( cCodDesc,  1, 45), PesqPict("SB1","B1_DESCOMP", TamSx3("B1_DESCOMP")[1] ) ), aRelato.oFont07)
			aRelato.oPrn:Say(cCol+cTam+cTam,0610,      TRANSFORM( SUBSTR( cCodDesc, 46, 45), PesqPict("SB1","B1_DESCOMP", TamSx3("B1_DESCOMP")[1] ) ), aRelato.oFont07)
			aRelato.oPrn:Say(cCol+cTam+cTam+cTam,0610, TRANSFORM( SUBSTR( cCodDesc, 91, 45), PesqPict("SB1","B1_DESCOMP", TamSx3("B1_DESCOMP")[1] ) ), aRelato.oFont07)
			cColu := cCol+cTam+cTam+cTam
		EndIf
		
		aRelato.oPrn:Say( cCol+cTam, 1800, TRANSFORM( TRB2->QTDE,     "@ 999,999.99" ),  aRelato.oFont07)                                        //QTDE
		aRelato.oPrn:Say( cCol+cTam, 2000, TRANSFORM( TRB2->UNIDADE,  PesqPict("SB1","B1_UM", TamSx3("B1_UM")[1] ) ),  aRelato.oFont07)         //UNIDADE
		aRelato.oPrn:Say( cCol+cTam, 2170, TRANSFORM( TRB2->VAL_UNIT, PesqPict("SCK","CK_PRCVEN", TamSx3("CK_PRCVEN")[1] ) ),  aRelato.oFont07) //VALOR UNITARIO
		aRelato.oPrn:Say( cCol+cTam, 2430, TRANSFORM( nPerRet,        PesqPict("SB1","B1_PICM", TamSx3("B1_PICM")[1] ) ),  aRelato.oFont07)     //ICMS
		aRelato.oPrn:Say( cCol+cTam, 2600, TRANSFORM( TRB2->VALOR,    PesqPict("SCK","CK_VALOR", TamSx3("CK_VALOR")[1] ) ),  aRelato.oFont07)   //VALOR TOTAL
		aRelato.oPrn:Say( cCol+cTam, 2850, TRANSFORM( TRB2->IPI,      PesqPict("SB1","B1_IPI", TamSx3("B1_IPI")[1] ) ),  aRelato.oFont07)       //IPI
		aRelato.oPrn:Say( cCol+cTam, 3010, TRANSFORM( TRB2->ITEM,     PesqPict("SCK","CK_ITEM", TamSx3("CK_ITEM")[1] ) ),  aRelato.oFont07)	    //CODIGO CLIENTE
		
		cCol := cColu + 50
		
		aRelato.oPrn:LINE(cCol,0080,cCol,3150)
		
		cCol := cCol - 20
		TRB2->(dbSkip())
	End
	
	//VERIFICA SE O CLIN ATINGE 2400
	fVerPag()
	
	cCol := cCol+30
	
	//TOTAL ITENS DO ORCAMENTO
	cQuery := " SELECT "
	cQuery += "   SA1.A1_COD CODCLI , "
	cQuery += "   SA1.A1_LOJA LOJA, "
	cQuery += "   SA1.A1_TIPO TIPOCLI, "
	cQuery += "   SCJ.CJ_FRETE FRETE, "
	cQuery += "   SCJ.CJ_DESPESA, "
	cQuery += "   SCJ.CJ_TIPLIB TIPO, "
	cQuery += "   SCJ.CJ_NUM ORCAMENTO, "
	cQuery += "   SCK.CK_ITEM ITEM_ORC, "
	cQuery += "   SCK.CK_PRODUTO PRODUTO, "
	cQuery += "   SCK.CK_TES TES, "
	cQuery += "   SCK.CK_QTDVEN QUANTIDADE, "
	cQuery += "   SCK.CK_PRCVEN PRECO,"
	cQuery += "   ((SCJ.CJ_DESC1*SCK.CK_VALOR)/100) DESCONTO, " //cQuery3  += "   SCK.CK_VALDESC DESCONTO,"
	cQuery += "   SCK.CK_VALOR VALOR"
	cQuery += " FROM "
	cQuery += RetSqlName("SCJ") + " SCJ, "
	cQuery += RetSqlName("SCK") + " SCK, "
	cQuery += RetSqlName("SA1") + " SA1 "
	cQuery += " WHERE   SCJ.CJ_NUM = SCK.CK_NUM "
	cQuery += "   AND SCJ.CJ_CLIENTE = SA1.A1_COD AND SCJ.CJ_LOJA = SA1.A1_LOJA AND SCJ.D_E_L_E_T_ = ''"
	cQuery += "   AND SA1.D_E_L_E_T_ = '' AND SCK.D_E_L_E_T_ = ''
	cQuery += "   AND CK_NUM = '" + TRB1->ORCA+ "'"
	cQuery += "   AND CK_FILIAL = '" + xFilial("SCK") + "'"
	cQuery += "   AND CJ_FILIAL = '" + xFilial("SCJ") + "'"
	
	If Select("TRB3") > 0
		TRB3->(DbCloseArea())
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB3',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	VAL_SUF		:= 0
	VAL_PRD 	:= 0
	VAL_IPI 	:= 0
	VAL_TOT 	:= 0
	VAL_ST  	:= 0
	VAL_FER	    := 0
	ST_AUX		:= 0
	VAL_FRETE	:= TRB3->FRETE
	VAL_DESPESA := TRB3->CJ_DESPESA
	VAL_DESCONTO:= 0
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณcalculo dos valores fiscais                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicializa a funcao fiscal                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nTOT_ST := 0
	DBSelectArea("SB1")
	WHILE TRB3->( .Not. Eof() )
		
		nfreteIt := (TRB3->VALOR / nVTmerc)* TRB3->FRETE
		
		nItem++
		MaFisSave()
		MaFisEnd()
		MaFisIni( (TRB3->CODCLI),; // 1-Codigo Cliente/Fornecedor
		           TRB3->LOJA,;    // 2-Loja do Cliente/Fornecedor
		           "C",;           // 3-C:Cliente , F:Fornecedor
		           "N",;
		           TRB3->TIPOCLI,; // 5-Tipo do Cliente/Fornecedor
		           Nil,;
		           Nil,;
		           Nil,;
		           Nil,;
		           "MATA641")
		
		
		MaFisAdd( TRB3->PRODUTO,;       // 1-Codigo do Produto ( Obrigatorio )
		          TRB3->TES,;           // 2-Codigo do TES ( Opcional )
		          TRB3->QUANTIDADE,;  	 // 3-Quantidade ( Obrigatorio )
		          TRB3->PRECO,;		  	 // 4-Preco Unitario ( Obrigatorio )
		          0,; //TRB3->DESCONTO,; // 5-Valor do Desconto ( Opcional )
		          "",;                   // 6-Numero da NF Original ( Devolucao/Benef )
		          "",;                   // 7-Serie da NF Original ( Devolucao/Benef )
		          0,;                    // 8-RecNo da NF Original no arq SD1/SD2
		          0,;                    // 9-Valor do Frete do Item ( Opcional )
		          0,;                    // 10-Valor da Despesa do item ( Opcional )
		          0,;                   // 11-Valor do Seguro do item ( Opcional )
		          0,;                   // 12-Valor do Frete Autonomo ( Opcional )
		          TRB3->VALOR,;         // 13-Valor da Mercadoria ( Obrigatorio )
		          0)                    // 14-Valor da Embalagem ( Opiconal )
		
		SB1->(DbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+TRB3->PRODUTO))
			nQtdPeso := TRB3->QUANTIDADE*SB1->B1_PESO
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAltera peso para calcular frete              ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		MaFisAlt("IT_PESO",nQtdPeso,nItem)
		MaFisAlt("IT_PRCUNI",TRB3->PRECO,nItem)
		MaFisAlt("IT_VALMERC",TRB3->VALOR,nItem)
		
		//nValFrete:=TRB3->VALOR_FRETE/nItem
		
		MaFisAlt("NF_FRETE",nfreteIt)
		MaFisWrite(1)
		
		ST_AUX := MaFisRet(,"NF_VALSOL")
		
		DbSelectArea("SF4")
		SF4->(DbSetOrder(1))
		If SF4->(DbSeek(xFilial("SF4")+TRB3->TES))
			If SF4->F4_ART274 $ "2/ "
				nTOT_ST += ST_AUX
			EndIf
		EndIf
		
		VAL_FER      += MaFisRet(1,"LF_ICMSRET")
		VAL_PRD 	 += MaFisRet(,"NF_VALMERC")
		VAL_IPI 	 += MaFisRet(,"NF_VALIPI")
		VAL_TOT 	 += MaFisRet(,"NF_TOTAL")
		VAL_ST  	 += ST_AUX//MaFisRet(,"NF_VALSOL")
		VAL_SUF		 += MaFisRet(,"NF_DESCZF")
		//VAL_DESCONTO += TRB3->DESCONTO//MaFisRet(,"NF_DESCONTO")
		//VAL_FRETE    += MaFisRet(,"NF_FRETE")
		//VAL_DESPESA  += MaFisRet(,"NF_DESPESA")
		
		TRB3->(DBSKIP())
	END
	
	aRelato.oPrn:Say(cCol,0100,"Subtotal ", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,0500,"Frete ", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,0900,"Despesa ", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,1300,"IPI ", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,1700,"S.T. ", aRelato.oFont04)
	aRelato.oPrn:Say(cCol,2900,"Total Geral ", aRelato.oFont04)
	cCol += 50
	
	nTOTAL := VAL_PRD + VAL_FRETE + VAL_DESPESA + VAL_IPI + nTOT_ST-VAL_SUF
	
	aRelato.oPrn:Say(cCol,0100,Transform(VAL_PRD,     "@E 999,999,999.99"), aRelato.oFont03)
	aRelato.oPrn:Say(cCol,0500,Transform(VAL_FRETE,   "@E 999,999,999.99"), aRelato.oFont03)
	aRelato.oPrn:Say(cCol,0900,Transform(VAL_DESPESA, "@E 999,999,999.99"), aRelato.oFont03)
	aRelato.oPrn:Say(cCol,1300,Transform(VAL_IPI,     "@E 999,999,999.99"), aRelato.oFont03)
	If SCJ->CJ_PROSPE
		For nPos := 1 to Len( aObj[8]:AARRAY )
			If aObj[8]:AARRAY[ nPos ][1] == "ICR"
				aRelato.oPrn:Say(cCol,1700, Transform( aObj[8]:AARRAY[ nPos ][5], "@E 999,999,999.99"), aRelato.oFont03)
			EndIf
		Next
	Else
		aRelato.oPrn:Say(cCol,1700,Transform(VAL_ST,      "@E 999,999,999.99"), aRelato.oFont03)
	EndIf
	//aRelato.oPrn:Say(cCol,1700,Transform(,      "@E 999,999,999.99"), aRelato.oFont03)
	//aRelato.oPrn:Say(cCol,2100,Transform(VAL_DESCONTO,"@E 999,999,999.99"), aRelato.oFont03)
	//aRelato.oPrn:Say(cCol,2500,Transform(VAL_SUF,	  "@E 999,999,999.99"), aRelato.oFont03)
	aRelato.oPrn:Say(cCol,2900,Transform(nTOTAL,      "@E 999,999,999.99"), aRelato.oFont03)
	cCol += 50
	//fVerPag()
	aRelato.oPrn:LINE(cCol,0080,cCol,3150)
	
	IF cCol+450 >= aRelato.nTotLinPag // 2350   //30/05/12-Marcio Aflitos-Aqui testa se vai caber o rodape final com todas as observa็๕es
		cCol := 2351
		lRod := .F.
	ENDIF
	fVerPag()
	
	//OBSERVACAO PADRAO
	cCol += 80
	aRelato.oPrn:Say(cCol,0100,"Observa็๕es Or็amento", aRelato.oFont04)
	cCol+= 50
	
	//If TRB->ESTCLI == "SP"
	nValObs := 1200.00
	//Else
	//	nValObs := 800.00
	//EndIf
	
	cValObs := Alltrim(Transform(nValObs,"@E 999,999,999.99"))
	DbSelectArea("SCJ")
	If SCJ->( DbSeek(xFilial("SCJ")+TRB1->ORCA) )
		cObs := "Validade da proposta: " + TRANSFORM( SCJ->CJ_VALIDA, PesqPict("SCJ","CJ_VALIDA", TamSx3("CJ_VALIDA")[1] ) )+chr(13) + chr(10)+;
		"Faturamento Mํnimo: R$ "+cValObs+" (valor lํquido)"+chr(13) + chr(10)+;
		"Favor verificar se os itens e quantidades cotados estใo de acordo com o solicitado."+chr(13) + chr(10)
		
		If .Not. Empty( SCJ->CJ_OBSFAB )
			cObs += SCJ->CJ_OBSFAB
		EndIf
	EndIf
	
	cColu := cCol
	
	//USANDO O MEMOLINE PARA IMPRESSAO
	If .Not. Empty(cObs)
		cJ  := 200	//TAMANHO DA QUEBRA
		
		t_linhas := MlCount( AllTrim(cObs),cJ,3,.t.)
		
		For nPos := 1 TO t_linhas
			aRelato.oPrn:Say(cColu,0100,MemoLine(cObs,cJ,nPos,3,.t.), aRelato.oFont07) //SINTAXE = MEMOLINE(CAMPO,TAMANHO_QUEBRA,LINHA_IMPRESSA,3,.T.)
			cColu += 50
			cCol  := cColu
			fVerPag()
		Next
	EndIf
	
	cCol += 30
	aRelato.oPrn:LINE(cCol,0080,cCol,3150)
	
	cCol += 30
	
	//VERIFICA SE O CLIN ATINGE 2400
	fVerPag()
	
	aRelato.oPrn:Say(cCol,0100,"Sauda็๕es:", aRelato.oFont08)
	
	cCol += 210
	
	//LINHA DO USUARIO
	aRelato.oPrn:Line(cCol,0080,cCol,1000)
	
	aRelato.oPrn:Say(cCol,0110,SM0->M0_NOMECOM, aRelato.oFont03)
		
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec     บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cabecario dos Orcamentos                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTFR0001                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC PROCEDURE Cabec()

	//IMPRESSAO DO DESENHO(LOGO)
	DO CASE
		Case xFilial("SCJ") == "01"//DAISA MATRIZ
			cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SCJ") == "02"//FUNDICAO
			cLogo  := '\system\logo_fundicao.jpg'
		Case xFilial("SCJ") == "03"//DAIBRAS
			cLogo  := '\system\logo_daibras.jpg'
		Case xFilial("SCJ") == "04"//DAISA INDUSTRIAL
			cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SCJ") == "05"//DAISA COMERCIO
			cLogo  := '\system\logo_daisa.bmp'
		Case xFilial("SCJ") == "99"//EMPRESA TESTE
			cLogo  := '\system\logo_daisa.bmp'
	ENDCASE
	
	aRelato.oPrn:SayBitmap( 0080, 0100,alltrim(cLogo),0480,0200)
	
	DbSelectArea("SM0")
	aRelato.oPrn:Say(0080,0810,SM0->M0_NOMECOM, aRelato.oFont09)
	
	aRelato.oPrn:Say(0200,0810,Alltrim(SM0->M0_ENDENT) + ' - BAIRRO: ' + Alltrim(SM0->M0_BAIRENT) + ' - CIDADE: ' + Alltrim(SM0->M0_CIDENT) + ' - CEP: ' + Alltrim(SM0->M0_CEPENT), aRelato.oFont07)
	
	//aRelato.oPrn:Say(0250,2780,"Or็amento Nบ:", aRelato.oFont04)
	//aRelato.oPrn:Say(0250,2930,TRB1->ORCA, aRelato.oFont04)                  	  //NUMERO ORCAMENTO
	
	aRelato.oPrn:Say(0250,0810,'ESTADO: ' + Alltrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + SM0->M0_TEL + ' - FAX: ' + SM0->M0_FAX, aRelato.oFont07)
	aRelato.oPrn:Say(0300,0810,'CNPJ - ' + Transform(SM0->M0_CGC,"@r 99.999.999/9999-99") + ' - INSCR. ESTADUAL: ' + Transform(SM0->M0_INSC,"@r 999.999.999.999"), aRelato.oFont07)
	
	aRelato.oPrn:Say(0350,0100,"Or็amento Nบ:", aRelato.oFont09)
	aRelato.oPrn:Say(0350,0500,TRB1->ORCA, aRelato.oFont09)                  	  //NUMERO ORCAMENTO
	
	aRelato.oPrn:Say(0200,2780,"Data:", aRelato.oFont04)
	aRelato.oPrn:Say(0200,2930,TRB1->EMISSAO, aRelato.oFont03)                    //DATA EMISSAO
	
    aRelato.nPagina += 1
	aRelato.oPrn:Say(0360,2780,"Pแgina: ", aRelato.oFont04)
	aRelato.oPrn:Say(0360,2930,AllTrim(Str(aRelato.nPagina)), aRelato.oFont03) //NUMERO PAGINA
	
	aRelato.oPrn:Line(0420,0080,0420,3150)
	
	//CABECALHO ITENS DO ORCAMENTO
	If .Not. lRod
		lRod := .T.
		cCol := cCol+30
		
		aRelato.oPrn:Say(cCol,0100,"Item", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,0200,"C๓digo", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,0600,"Descri็ใo", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,1800,"Qtd.", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,1970,"Apr.", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2200,"Val. Unit.", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2400,"% ICMS", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2600,"Val. Total", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2850,"% IPI", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2980,"Item Cli.", aRelato.oFont08)
		
		/*
		aRelato.oPrn:Say(cCol,0100,"Item", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,0200,"Produto", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,1500,"Qtd.", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,1700,"Apr.", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,1800,"Val. Unit.", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2100,"% ICMS", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2300,"% Desc", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2500,"Val. Total", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2700,"% IPI", aRelato.oFont08)
		aRelato.oPrn:Say(cCol,2900,"Item Cli.", aRelato.oFont08)
		*/
		cCol += 50
		aRelato.oPrn:Line(cCol,0080,cCol,3150)
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfVerPag   บAutor  ณMarcel Medeiros     บ Data ณ  05/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para analise de paginas                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ faturamento/Orcamento                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC PROCEDURE fVerPag()

	If ( cCol >= aRelato.nTotLinPag )
		aRelato.oPrn:EndPage()
		cCol  := 0400
		aRelato.oPrn:StartPage()
		Cabec()
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA415MNU  บAutor  ณMarcel Medeiros     บ Data ณ  05/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณP.E para adicionar botao no Orcamento Faturamento           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ faturamento/Orcamento                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MA415MNU()
	aAdd(aRotina,{"Imprime Daisaaa","U_AC0030"  	, 0 , 4, 0,NIL})
Return (aRotina)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณ Vitor Daniel       บ Data ณ  07/05/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunte da tela                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ faturamento/Orcamento                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure AjustaSX1(cPerg)

Local aRegs := {}

	aAdd(aRegs,{cPerg, "01","Nบ Orcamento de  ?" ,"Nบ Orcamento de  ?" ,"Nบ Orcamento de  ?" ,"MV_CHA" ,"C",06,0,0,"G","" ,"MV_PAR01" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg, "02","Nบ Orcamento ate ?" ,"Nบ Orcamento ate ?" ,"Nบ Orcamento ate ?" ,"MC_CHA" ,"C",06,0,0,"G","" ,"MV_PAR02" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})

	ValidPerg(aRegs,cPerg)
	
Return
