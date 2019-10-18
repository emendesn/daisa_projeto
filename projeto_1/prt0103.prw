#INCLUDE "PROTHEUS.CH"
#INCLUDE "PRT0103.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออปฑฑ
ฑฑบPrograma  ณ PRT0103   บAutor  ณVitor Daniel        บ Data ณ  25/10/10      บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.     ณ IMPRIME O PEDIDO DE COMPRA                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION PRT0103()

Local cPerg	:= AllTrim( "DA_PEDCOMP" )

PRIVATE aRelato := StoreRelato()

	//DEFININDO AS FONTS
	DEFINE FONT aRelato.oFont01 NAME "Arial" SIZE 0,14 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont02 NAME "Arial" SIZE 0,20 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont03 NAME "Arial" SIZE 0,08 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont04 NAME "Arial" SIZE 0,10 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont07 NAME "Arial" SIZE 0,08 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont08 NAME "Arial" SIZE 0,08 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont09 NAME "Arial" SIZE 0,12 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont10 NAME "Arial" SIZE 0,07 OF aRelato.oPrn BOLD
	
	//Titulo do Relatorio
	aRelato.cTitulo := "Impressใo de Pedido de Compra"
	
	AjustaSx1(cPerg)
	IF Pergunte( cPerg, .T. )
		
		aRelato.oPrn := TMSPrinter():New( aRelato.cTitulo )
		
		IF aRelato.oPrn:Setup()
			
			RegOrc()
			
			aRelato.oPrn:SetPortrait()
			
			aRelato.oPrn:Preview()
			
			aRelato.oPrn:End()
			
			Ms_Flush()
			
			TRB1->( DBCloseArea() )
			
		EndIf
		
	EndIf
		
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRegOrc     บAutor  ณVitor Daniel        บ Data ณ  05/05/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Dados do Pedido Autocom                                     บฑฑ
ฑฑบ          ณ                                                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณPRT0103                                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC PROCEDURE RegOrc()

Local cQuery

	If Select("TRB1") > 0
		DBSelectArea("TRB1")
		DBCloseArea("TRB1")
	EndIf
	
	cQuery := " SELECT DISTINCT "
	cQuery += "	  C7_FILIAL,"
	cQuery += "   C7_NUM PEDIDO, "
	cQuery += "   C7_EMISSAO EMISSAO, "
	cQuery += "   C7_FORNECE COD_FOR, "
	cQuery += "   CASE WHEN (C7_QUJE = 0 AND C7_QTDACLA = 0 AND C7_CONAPRO <> 'B') THEN 'S' ELSE 'N' END APROV," // Se o pedido de compra foi aprovado
	cQuery += "   A2_NOME FORNECEDOR, "   
	cQuery += "   C7_USER USUARIO, "
	cQuery += "   C7_COND CONDICAO1,"
	cQuery += "   C7_NUMCOT COTACAO,"
	cQuery += "	  C7_MOEDA MOEDA, "
	cQuery += "   E4_DESCRI CONDICAO2, "
	cQuery += "   A2_END ENDER, "
	cQuery += "   A2_BAIRRO BAIRRO, "
	cQuery += "   A2_MUN MUN, "
	cQuery += "   A2_EST ESTADO, "
	cQuery += "   A2_CEP CEP, "
	cQuery += "   A2_DDD DDD, "
	cQuery += "   A2_TEL FONE, "
	cQuery += "   A2_FAX FAX, "
	cQuery += "   A2_CGC CGC_CPF, "
	cQuery += "   A2_INSCR IE_RG, "
	cQuery += "   A2_EMAIL EMAIL, "
	cQuery += "   A2_CONTATO CONTATO, "
	cQuery += "   A4_NOME TRANSP, " 
	cQuery += "   A4_DDD DDD_TRANSP, "
	cQuery += "   A4_TEL TEL_TRANSP, "
	cQuery += "   A4_END END_TRANSP, "
	cQuery += "   A4_BAIRRO BAIR_TRANSP, "
	cQuery += "   A4_MUN MUN_TRANSP, "
	cQuery += "   A4_EST EST_TRANSP, "
	cQuery += "   A4_CEP CEP_TRANSP, "
	cQuery += "   case "
	cQuery += "     when C7_TPFRETE = 'C' then 'CIF - Emitente' "
	cQuery += "     else 'FOB - Destinatario' "
	cQuery += "   end TIPO_FRETE, "
	cQuery += "   YA_DESCR PAIS, "
	cQuery += "   C7_GRUPCOM, "
	cQuery += "   C7_TIPO, "
	cQuery += "   C7_FILIAL "
	cQuery += " FROM "
	cQuery += RetSqlName("SC7") + " SC7 "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SA2") + " SA2 "
	cQuery += " ON "
	cQuery += "   SA2.A2_FILIAL = '" + xFilial("SA2") + "' AND "
	cQuery += "   SA2.A2_COD = SC7.C7_FORNECE AND "
	cQuery += "   SA2.A2_LOJA = SC7.C7_LOJA AND "
	cQuery += "	  SA2.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SYA") + " SYA "
	cQuery += " ON "
	cQuery += "   YA_CODGI = A2_PAIS "
	cQuery += "   AND YA_FILIAL = '"+xFilial("SYA")+"'"
	cQuery += "   AND SYA.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SE4") + " COND "
	cQuery += " ON "
	cQuery += "   COND.E4_CODIGO = SC7.C7_COND "
	cQuery += "   AND COND.E4_FILIAL = '"+xFilial("SE4")+"'"
	cQuery += "   AND COND.D_E_L_E_T_  = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SA4") + " TRANSP "
	cQuery += " ON "
	cQuery += "   TRANSP.A4_COD = SA2.A2_TRANSP "
	cQuery += "   AND TRANSP.A4_FILIAL = '"+xFilial("SA4")+"'"
	cQuery += "   AND TRANSP.D_E_L_E_T_ = ''"
	cQuery += " WHERE "
	cQuery += "   SC7.D_E_L_E_T_ = '' "
	cQuery += "   and C7_NUM >= '"+MV_PAR01+"'"
	cQuery += "   and C7_NUM <= '"+MV_PAR02+"'"
	cQuery += " order by 1 "
	
	//VALIDA QUERY
	//memowrite("c:\query.sql",cQuery)
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."		
	
	While .Not. TRB1->( Eof() )
	
		aRelato.oPrn:StartPage()
		
		//Define a Pagina Inicial
		aRelato.nPagina := 0	
		
		LayOutOP()
		
		aRelato.oPrn:EndPage()		
		
		TRB1->(DBSkip())
		
	ENDDO
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLayOutOP  บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do Layout do Pedido                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PRT0103                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC PROCEDURE LayOutOP()

Local cEmail := ''
Local cNome  := ''  
Local lValid := .F. 
Local cAprov := ''
Local cQuery
Local nPos

PRIVATE cTam      := 60
PRIVATE aAllUser  := AllUsers()
PRIVATE aUser     := {} 
PRIVATE lRod      := .T. 
PRIVATE cUsuario
PRIVATE cCol
PRIVATE Orc_1     := "SC7" 


	DBSelectArea("TRB1")                             
	
	aRelato.oPrn:Line(0050,0080,0050,2300)
	aRelato.oPrn:Line(0050,0080,3200,0080)
	aRelato.oPrn:Line(3200,0080,3200,2300)
	aRelato.oPrn:Line(0050,2300,3200,2300)    
	
	//CABECALHO
	Cabec(lRod)
	                    
	/*
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณDADOS FORNECEDORณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	*/
	aRelato.oPrn:Say(0350,0100,"Fornecedor:", aRelato.oFont08 )
	aRelato.oPrn:Say(0350,0350, AllTrim(TRB1->COD_FOR) + " - " + AllTrim(TRB1->FORNECEDOR), aRelato.oFont03 )
	aRelato.oPrn:Say(0350,1700,"Data:", aRelato.oFont08 )                  
	cData := SUBSTR(TRB1->EMISSAO,7,2)+'/'+SUBSTR(TRB1->EMISSAO,5,2)+'/'+SUBSTR(TRB1->EMISSAO,1,4)
	aRelato.oPrn:Say(0350,1800,cData, aRelato.oFont03 )
	//aRelato.oPrn:Say(0350,2000,"Hora:",aRelato.oFont08 )
	cHora := SUBSTR(time(),01,02) + ":" + SUBSTR(time(),04,02) + ":" + SUBSTR(time(),07,02)
	//aRelato.oPrn:Say(0350,2100,cHora,aRelato.oFont03 )
	
	aRelato.oPrn:Line(0395,0080,0395,2300)
	
	aRelato.oPrn:Say(0410,0100,"Endere็o:", aRelato.oFont08 )
	aRelato.oPrn:Say(0410,0350,TRB1->ENDER, aRelato.oFont03 )
	aRelato.oPrn:Say(0410,1400,"Bairro:", aRelato.oFont08 )
	aRelato.oPrn:Say(0410,1550,TRB1->BAIRRO, aRelato.oFont03 )
	
	aRelato.oPrn:Line(0455,0080,0455,2300)
	
	aRelato.oPrn:Say(0470,0100,"Cidade:", aRelato.oFont08 )
	aRelato.oPrn:Say(0470,0350,TRB1->MUN, aRelato.oFont03 )
	aRelato.oPrn:Say(0470,1400,"Estado:", aRelato.oFont08 )
	aRelato.oPrn:Say(0470,1550,TRB1->ESTADO,aRelato.oFont03 )
	aRelato.oPrn:Say(0470,1700,"I. Estadual:", aRelato.oFont08 )
	aRelato.oPrn:Say(0470,1900,Transform(TRB1->IE_RG,"@r 999.999.999.999"),aRelato.oFont03 )
	                       
	aRelato.oPrn:Line(0515,0080,0515,2300)
	
	aRelato.oPrn:Say(0530,0100,"CNPJ:", aRelato.oFont08 )   
	
	If Len(TRB1->CGC_CPF) = 14
		cCNPJ := Transform(TRB1->CGC_CPF,"@r 99.999.999/9999-99")
	Else
		cCNPJ := Transform(TRB1->CGC_CPF,"@r 999.999.999-99")
	EndIf
	
	aRelato.oPrn:Say(0530,0350,cCNPJ, aRelato.oFont03 )
	aRelato.oPrn:Say(0530,1400,"CEP:", aRelato.oFont08 )
	aRelato.oPrn:Say(0530,1550,Transform(TRB1->CEP,"@r 99999-999"), aRelato.oFont03 )
	
	aRelato.oPrn:Line(0575,0080,0575,2300)
	            
	aRelato.oPrn:Say(0590,0100,"Contato:", aRelato.oFont08 )
	aRelato.oPrn:Say(0590,0350,TRB1->CONTATO, aRelato.oFont03 )
	aRelato.oPrn:Say(0590,1000,"Fone:", aRelato.oFont08 )
	aRelato.oPrn:Say(0590,1100,IF( .Not. Empty(TRB1->DDD),'(' + AllTrim(TRB1->DDD) + ') '+ Transform(TRB1->FONE,"@r 9999-9999"),Transform(TRB1->FONE,"@r 9999-9999")),aRelato.oFont03 )
	aRelato.oPrn:Say(0590,1400,"Fax:", aRelato.oFont08 )
	aRelato.oPrn:Say(0590,1550,IF( .Not. Empty(TRB1->DDD),'(' + AllTrim(TRB1->DDD) + ') '+ Transform(TRB1->FAX,"@r 9999-9999"),Transform(TRB1->FAX,"@r 9999-9999")),aRelato.oFont03 )
	                       
	aRelato.oPrn:Line(0635,0080,0635,2300)
	          
	aRelato.oPrn:Say(0650,0100,"Or็amento nr.:", aRelato.oFont08 )    
	aRelato.oPrn:Say(0650,0350,TRB1->COTACAO, aRelato.oFont03 )    
	aRelato.oPrn:Say(0650,1400,"E-mail:", aRelato.oFont08 )
	aRelato.oPrn:Say(0650,1550,TRB1->EMAIL,aRelato.oFont03 )
	
	aRelato.oPrn:Line(0695,0080,0695,2300)

    IF ( nPos := ASCAN( aAllUser, { |xItem| xItem[1][1] == TRB1->USUARIO } ) ) > 0
       cNome  := aAllUser[ nPos ][1][4]
       cEmail := aAllUser[ nPos ][1][14]
    EndIf
  
/*	For nPos := 1 TO Len(aAllUser)
		If aAllUser[ nPos ][1][1] == TRB1->USUARIO
			cNome  := aAllUser[ nPos ][1][4]
			cEmail := aAllUser[ nPos ][1][14]
			Exit
		Endif
	Next */
		
	aRelato.oPrn:Say(0710,0100,"Comprador:", aRelato.oFont08 )
	aRelato.oPrn:Say(0710,0350,Upper(cNome), aRelato.oFont03 )
	aRelato.oPrn:Say(0710,1400,"E-mail:", aRelato.oFont08 )
	aRelato.oPrn:Say(0710,1550,cEmail, aRelato.oFont03 )
	
	aRelato.oPrn:Line(0755,0080,0755,2300)
	
	aRelato.oPrn:Say(0770,0100,"Local Entrega:", aRelato.oFont08 )
	aRelato.oPrn:Say(0770,0350,AllTrim(SM0->M0_ENDENT) + ' - ' + AllTrim(SM0->M0_BAIRENT) + ' - ' + AllTrim(SM0->M0_CIDENT) + ' - ' + AllTrim(SM0->M0_ESTENT) + ' - ' + Transform(SM0->M0_CEPENT,"@r 99999-999"),aRelato.oFont07 )
	
	aRelato.oPrn:Line(0815,0080,0815,2300)
	
	aRelato.oPrn:Say(0830,0100,"Local Cobran็a:", aRelato.oFont08 )
	aRelato.oPrn:Say(0830,0350,AllTrim(SM0->M0_ENDCOB) + ' - ' + AllTrim(SM0->M0_BAIRCOB) + ' - ' + AllTrim(SM0->M0_CIDCOB) + ' - ' + AllTrim(SM0->M0_ESTCOB) + ' - ' + Transform(SM0->M0_CEPCOB,"@r 99999-999"),aRelato.oFont07 )
	
	aRelato.oPrn:Line(0875,0080,0875,2300)
	
	aRelato.oPrn:Say(0890,0100,"Condi็ใo de Pagamento:", aRelato.oFont08 )
	aRelato.oPrn:Say(0890,0500,AllTrim(TRB1->CONDICAO2),aRelato.oFont03 )
	
	aRelato.oPrn:Line(0935,0080,0935,2300)
	
	//foi solicitado para retirar os campos abaixo:
	//aRelato.oPrn:Say(0950,0100,"Pagamento:", aRelato.oFont08 )
	//aRelato.oPrn:Say(0950,0500,"Vencimento:", aRelato.oFont08 )
	//aRelato.oPrn:Say(0950,0900,"Valor:", aRelato.oFont08 )
	                                       
	cCol := 1035
	
	aRelato.oPrn:Line(cCol,0080,cCol,2300)
	                        
	cCol += 20 	
	/*
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณQUADRO CABECALHO DOS ITENSณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	/*/
	aRelato.oPrn:Say(cCol,0090,"Item", aRelato.oFont08 )
	
	aRelato.oPrn:Say(cCol,0200,"Qtd.", aRelato.oFont08 )
	
	aRelato.oPrn:Say(cCol,0395,"Un", aRelato.oFont08 )
	
	aRelato.oPrn:Say(cCol,0450,"Descri็ใo", aRelato.oFont08 )
	
	aRelato.oPrn:Say(cCol,1400,"Data Entrega", aRelato.oFont08 )
	
	
	aRelato.oPrn:Say(cCol,2210,"% IPI", aRelato.oFont08 )
	
	cCol += 40 	
	
	aRelato.oPrn:Line(cCol,0080,cCol,2300)
	
	If Select("TRB2") > 0
		DBSelectArea("TRB2")
		DBCloseArea("TRB2")
	Endif
	                                                             
	cQuery := "SELECT "
	cQuery += "	C7_FILIAL,"
	cQuery += "   C7_NUM PEDIDO, "
	cQuery += "   C7_ITEM SEQ, "
	cQuery += "   C7_QUANT QUANT, "
	cQuery += "   C7_MOEDA MOEDA, "
	cQuery += "   B1_UM UNIDADE, "
	cQuery += "   B1_COD CODIGO, "
	cQuery += "   C7_DESCRI PRODUTO, "
	cQuery += "   C7_DATPRF ENTREGA, "
	cQuery += "   C7_PRECO VAL_UNIT, "
	cQuery += "   C7_TOTAL VAL_TOT, " 
	cQuery += "   C7_IPI IPI, "
	cQuery += "   C7_OBS OBSX, "
	cQuery += "   C1_OBS OBS "
	cQuery += " FROM "
	cQuery += RetSqlName("SC7") + " SC7 "
	cQuery += " LEFT OUTER JOIN "+RetSqlName("SC1")+" SC1"
	cQuery += " ON "
	cQuery += "   ( SC1.C1_FILIAL = SC7.C7_FILIAL AND "
	cQuery += "     SC1.C1_NUM = SC7.C7_NUMSC AND "
	cQuery += "     SC1.C1_ITEM = SC7.C7_ITEMSC AND "
	cQuery += "     SC1.D_E_L_E_T_ = '')"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SB1") + " SB1 "
	cQuery += " ON "
	cQuery += "   SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND "	
	cQuery += "   SB1.B1_COD = SC7.C7_PRODUTO AND "
	cQuery += "   SB1.D_E_L_E_T_ = '' " 
	cQuery += " WHERE "                          '
	cQuery += "   SC7.D_E_L_E_T_ = '' "
	cQuery += "   AND C7_FILIAL = '"+TRB1->C7_FILIAL+"'"
	cQuery += "   AND C7_NUM = '" + TRB1->PEDIDO+ "' "
	cQuery += " ORDER BY 1,2,3 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)	
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB2',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."			
	                       
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณLOOPING PARA PEGAR ITENS DO PEDIDO   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cCol  := cCol-40
	cObs  := ""
	cObsX := ""
	//Segundo o cliente se um item da cota็ใo for de uma certa moeda, todos serใo
	If TRB2->MOEDA == 1
		cMascMoeda := "(R$)"
	ElseIf TRB2->MOEDA == 2
		cMascMoeda := "(US$)"
	Else
		cMascMoeda := ""
	EndIf
	aRelato.oPrn:Say(cCol,1650,"Unit."+cMascMoeda, aRelato.oFont08 )
	
	aRelato.oPrn:Say(cCol,1900,"Total"+cMascMoeda, aRelato.oFont08 )   //mudei de 1950              
	/*
	While TRB2->(!Eof()) .And. TRB2->C7_FILIAL+TRB2->PEDIDO == TRB1->C7_FILIAL+TRB1->PEDIDO    
	  //VERIFICA SE O CLIN ATINGE 2400     
	  fVerPag(lRod)   
	  lRod  := .T.
		cColu := 0
		cIni  := cCol-20
	
		aRelato.oPrn:Say(cCol+cTam,0090,AllTrim(TRB2->SEQ),aRelato.oFont07 )								              //SEQ
		aRelato.oPrn:Say(cCol+cTam,0165,AllTrim(Transform(TRB2->QUANT,"@E 999,999,999.99")),aRelato.oFont07 )	//QUANTIDADE
		aRelato.oPrn:Say(cCol+cTam,0300,TRB2->UNIDADE,aRelato.oFont07 )									                  //UNIDADE
		
		//VERIFICA QUANTIDADE DE CARACTERES
		cCodDesc := AllTrim(TRB2->CODIGO) + " - " + AllTrim(TRB2->PRODUTO)
		if Len(cCodDesc) <= 55
			aRelato.oPrn:Say(cCol+cTam,0380,cCodDesc,aRelato.oFont07 )									//PRODUTO
			cColu := cCol+cTam
		ElseIf Len(cCodDesc) <= 110
			aRelato.oPrn:Say(cCol+cTam,0380,     SUBSTR(cCodDesc,1,55),aRelato.oFont07 )									
			aRelato.oPrn:Say(cCol+cTam+cTam,0380,SUBSTR(cCodDesc,56,55),aRelato.oFont07 )								
			cColu := cCol+cTam+cTam
		Else 
			aRelato.oPrn:Say(cCol+cTam,0380,          SUBSTR(cCodDesc,1,55),aRelato.oFont07 )									
			aRelato.oPrn:Say(cCol+cTam+cTam,0380,     SUBSTR(cCodDesc,56,55),aRelato.oFont07 )									
			aRelato.oPrn:Say(cCol+cTam+cTam+cTam,0380,SUBSTR(cCodDesc,111,55),aRelato.oFont07 )									
			cColu := cCol+cTam+cTam+cTam
		EndIf
		
		//DATA ENTREGA        
		cData := subs(TRB2->ENTREGA,7,2)+'/'+subs(TRB2->ENTREGA,5,2)+'/'+subs(TRB2->ENTREGA,1,4)
		aRelato.oPrn:Say(cCol+cTam,1400,cData,aRelato.oFont07 )		  
		
		If TRB2->MOEDA == 1 				   		      			
			aRelato.oPrn:Say(cCol+cTam,1680,'R$' + Transform(TRB2->VAL_UNIT,"@E 999,999.99"),aRelato.oFont07 )			//VALOR UNIT.
			aRelato.oPrn:Say(cCol+cTam,1900,'R$' + Transform(TRB2->VAL_TOT,"@E 999,999,999.99"),aRelato.oFont07 )		//TOTAL S/ IPI
			
		ElseIf TRB2->MOEDA == 2                                                                                   
			aRelato.oPrn:Say(cCol+cTam,1680,'US$' + Transform(TRB2->VAL_UNIT,"@E 999,999,999.99"),aRelato.oFont07 )			//VALOR UNIT.
			aRelato.oPrn:Say(cCol+cTam,1900,'US$' + Transform(TRB2->VAL_TOT,"@E 999,999,999.99"),aRelato.oFont07 )		//TOTAL S/ IPI
		EndIf
		
		aRelato.oPrn:Say(cCol+cTam,2190,Transform(TRB2->IPI,"@E 999"),aRelato.oFont07 )				//% IPI
		If .Not. Empty(cObs)
			cObs += ", "
		EndIf
		cObs  += AllTrim(TRB2->OBS)
	  cCol  := cColu+50
		           
		aRelato.oPrn:Line(cIni,0155,cCol,0155)      
		aRelato.oPrn:Line(cIni,0285,cCol,0285)
		aRelato.oPrn:Line(cIni,0355,cCol,0355)      	      
		aRelato.oPrn:Line(cIni,1375,cCol,1375)      
		aRelato.oPrn:Line(cIni,1605,cCol,1605)      
		aRelato.oPrn:Line(cIni,1845,cCol,1845)      
		aRelato.oPrn:Line(cIni,2175,cCol,2175)      
	  aRelato.oPrn:Line(cCol,0080,cCol,2300)
	     	                      	          
		TRB2->(DBSkip())
	End*/
	While .Not. TRB2->( Eof() ) .And. TRB2->C7_FILIAL == TRB1->C7_FILIAL .And. TRB2->PEDIDO == TRB1->PEDIDO    
	  //VERIFICA SE O CLIN ATINGE 2400     
	  fVerPag(lRod)   
	                     
		lRod  := .T.
		cColu := 0
		cIni  := cCol-20
	
		aRelato.oPrn:Say(cCol+cTam,0090,AllTrim(TRB2->SEQ),aRelato.oFont07 )								//SEQ
		//aRelato.oPrn:Say(cCol+cTam,0165,AllTrim(Transform(999999999.999,"@E 999,999,999.999")),aRelato.oFont07 )				//QUANTIDADE
		aRelato.oPrn:Say(cCol+cTam,0165,AllTrim(Transform(TRB2->QUANT,Iif(TRB2->UNIDADE$"KG/MT/CT/MI","@E 999,999,999.999","@E 999,999,999"))),aRelato.oFont07 )				//QUANTIDADE
		aRelato.oPrn:Say(cCol+cTam,0395,TRB2->UNIDADE,aRelato.oFont07 )									//UNIDADE
		
		//VERIFICA QUANTIDADE DE CARACTERES
		cCodDesc := AllTrim(TRB2->CODIGO) + " - " + AllTrim(TRB2->PRODUTO)
		if Len(cCodDesc) <= 55
			aRelato.oPrn:Say(cCol+cTam,0450,cCodDesc,aRelato.oFont07 )									//PRODUTO
			cColu := cCol+cTam
		ElseIf Len(cCodDesc) <= 110
			aRelato.oPrn:Say(cCol+cTam,0450,     SUBSTR(cCodDesc,1,55), aRelato.oFont07 )									
			aRelato.oPrn:Say(cCol+cTam+cTam,0450,SUBSTR(cCodDesc,56,55), aRelato.oFont07 )								
			cColu := cCol+cTam+cTam
		Else 
			aRelato.oPrn:Say(cCol+cTam,0450,          SUBSTR(cCodDesc,1,55), aRelato.oFont07 )									
			aRelato.oPrn:Say(cCol+cTam+cTam,0450,     SUBSTR(cCodDesc,56,55), aRelato.oFont07 )									
			aRelato.oPrn:Say(cCol+cTam+cTam+cTam,0450,SUBSTR(cCodDesc,111,55), aRelato.oFont07 )									
			cColu := cCol+cTam+cTam+cTam
		EndIf
	
		//DATA ENTREGA        
		cData := SUBSTR(TRB2->ENTREGA,7,2)+'/'+SUBSTR(TRB2->ENTREGA,5,2)+'/'+SUBSTR(TRB2->ENTREGA,1,4)
		aRelato.oPrn:Say(cCol+cTam,1400,cData,aRelato.oFont07 )
		
		aRelato.oPrn:Say(cCol+cTam,1615,Transform(TRB2->VAL_UNIT/*999999999.99*/,"@E 999,999,999.99"),aRelato.oFont07 )		      	//VALOR UNIT.
		aRelato.oPrn:Say(cCol+cTam,1855,Transform(TRB2->VAL_TOT/*999999999.99*/,"@E 999,999,999.99"),aRelato.oFont07 )	        	//TOTAL S/ IPI
		
		aRelato.oPrn:Say(cCol+cTam,2210,Transform(TRB2->IPI/*999.99*/,"@E 999.99"),aRelato.oFont07 )	//% IPI
	
		//If .Not. Empty(cObs)
		//	cObs += ", "
		//EndIf
		If .Not. Empty(AllTrim(TRB2->OBS))
			cObs  += TRB2->SEQ + " -> " + AllTrim(TRB2->OBS) + " "  
		EndIf
			
		If .Not. Empty(AllTrim(TRB2->OBSX))
			cObsX += TRB2->SEQ + " -> " + AllTrim(TRB2->OBSX) + " "
		EndIf 
		cCol  := cColu+50
		//Linhas a esquerda das colunas
		aRelato.oPrn:Line(cIni,0155,cCol,0155)      //Qtd
		aRelato.oPrn:Line(cIni,0385,cCol,0385)		//Un
		aRelato.oPrn:Line(cIni,0440,cCol,0440)      //Descricao
		aRelato.oPrn:Line(cIni,1375,cCol,1375)      //Data Entrega
		aRelato.oPrn:Line(cIni,1585,cCol,1585)		//Unit   (cIni,1605,cCol,1605)   
		aRelato.oPrn:Line(cIni,1830,cCol,1830)		//total      1845
		aRelato.oPrn:Line(cIni,2205,cCol,2205)      //IPI
	  aRelato.oPrn:Line(cCol,0080,cCol,2300)
	     	                      	          
		TRB2->(DBSkip())
	End
	
	//VERIFICA SE O CLIN ATINGE 2400     
	fVerPag(lRod)  
	
	If Select("TRB3") > 0
		DBSelectArea("TRB3")
		DBCloseArea("TRB3")
	EndIf
	
	//TOTAL ITENS DO PEDIDO
	cQuery := "SELECT "
	cQuery += "   C7_FILIAL,"
	cQuery += "   C7_NUM PEDIDO, "    
	cQuery += "   C7_VALFRE  VALOR_FRETE, "
	cQuery += "   C7_SEGURO  VALOR_SEGURO, "
	cQuery += "   C7_DESPESA VALOR_DESPESA, "
	cQuery += "   C7_VLDESC  VALOR_DESC, "
	cQuery += "   C7_VALIR   VALOR_IR, "
	cQuery += "   C7_TOTAL   VALOR_PRODUTO, "
	cQuery += "   C7_VALIPI  VALOR_IPI, "
	cQuery += "   C7_VALICM  VALOR_ICM, "
	cQuery += "   ((C7_TOTAL + C7_VALFRE + C7_SEGURO + C7_DESPESA + C7_VALIPI) - C7_VLDESC) VALOR_TOTAL "
	cQuery += " from "
	cQuery += RetSqlName("SC7") + " I_ORC "
	cQuery += " where 1 = 1 "
	cQuery += "	AND C7_FILIAL = '"+TRB1->C7_FILIAL+"'"
	cQuery += "   and C7_NUM = '" + TRB1->PEDIDO+ "' "
	cQuery += "   and I_ORC.D_E_L_E_T_ = ''"
	cQuery += " order by 1 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB3',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."		
	
	
	                                       
	VAL_FRETE   := 0          
	VAL_SEGURO  := 0
	VAL_DESPESA := 0
	VAL_DESC    := 0
	VAL_IR      := 0
	VAL_ISS     := 0
	VAL_PRD     := 0         
	VAL_IPI     := 0
	VAL_TOT     := 0   
	VAL_ICM     := 0   
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณLOOPING PARA PEGAR :ณ
	//ณ                    ณ
	//ณ- VALOR PRODUTO     ณ
	//ณ- VALOR DO IPI      ณ
	//ณ- VALOR TOTAL       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	While .Not. TRB3->( Eof() ) .And. TRB3->C7_FILIAL == TRB1->C7_FILIAL .And. TRB3->PEDIDO == TRB1->PEDIDO
	
		VAL_FRETE   += TRB3->VALOR_FRETE
		VAL_SEGURO  += TRB3->VALOR_SEGURO
		VAL_DESPESA += TRB3->VALOR_DESPESA
		VAL_DESC    += TRB3->VALOR_DESC
		VAL_IR      += TRB3->VALOR_IR
		VAL_ISS     += 0
		VAL_PRD     += TRB3->VALOR_PRODUTO
		VAL_IPI     += TRB3->VALOR_IPI
		VAL_TOT     += TRB3->VALOR_TOTAL
		VAL_ICM     += TRB3->VALOR_ICM                  
		TRB3->(DBSkip())
	End
	           
	cCol += 20
	aRelato.oPrn:Say(cCol,0150,"Total Frete:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,0450,Transform(VAL_FRETE,"@E 999,999.99"),aRelato.oFont07 )                                         
	
	aRelato.oPrn:Say(cCol,0850,"Total Desconto:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1150,Transform(VAL_DESC,"@E 999,999.99"),aRelato.oFont07 )                                         
	
	aRelato.oPrn:Say(cCol,1650,"Total Itens:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1950,Transform(VAL_PRD,"@E 999,999,999.99"),aRelato.oFont07 )
	
	cCol += 50
	aRelato.oPrn:Say(cCol,0150,"Total Seguro:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,0450,Transform(VAL_SEGURO,"@E 999,999.99"),aRelato.oFont07 )                                         
	
	aRelato.oPrn:Say(cCol,0850,"Total IR:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1150,Transform(VAL_IR,"@E 999,999.99"),aRelato.oFont07 )                                         
	
	aRelato.oPrn:Say(cCol-15,1650,"Total ICMS:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol-15,1950,Transform(VAL_ICM,"@E 999,999,999.99"),aRelato.oFont07 )
	
	aRelato.oPrn:Say(cCol+20,1650,"Total IPI:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol+20,1950,Transform(VAL_IPI,"@E 999,999,999.99"),aRelato.oFont07 )
	                                    
	cCol += 50
	aRelato.oPrn:Say(cCol,0150,"Total Despesa:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,0450,Transform(VAL_DESPESA,"@E 999,999.99"),aRelato.oFont07 )                                         
	
	aRelato.oPrn:Say(cCol,0850,"Total ISS:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1150,Transform(VAL_ISS,"@E 999,999.99"),aRelato.oFont07 )                                         
	
	aRelato.oPrn:Say(cCol,1650,"Total do Pedido:", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1950,Transform(VAL_TOT,"@E 999,999,999.99"), aRelato.oFont08 )
	          
	cCol += 50
	aRelato.oPrn:Line(cCol,0080,cCol,2300)
	
	cCol += 30
	aRelato.oPrn:Say(cCol,0090,"Observa็๕es - Solicita็ใo:", aRelato.oFont08 )
	    
		//QUEBRA DE LINHA DA OBSERVACAO DO PEDIDO DE COMPRA
		j := Len(cObs)                                    
		i := 1
		
		if j < 170
			cCol += 50
			aRelato.oPrn:Say(cCol,0090,cObs,aRelato.oFont03 )
		Else
			While j > 0
				cCol += 50	
				aRelato.oPrn:Say(cCol,0090,Substr(cObs,i,169), aRelato.oFont03 )	
				i+=169
				j := j-169
			End
		EndIf
	
	//=========================================================
	
	cCol += 100
	
	
	aRelato.oPrn:Say(cCol,0090,"Observa็๕es - Pedido de Compras:", aRelato.oFont08 )
	//QUEBRA DE LINHA DA OBSERVACAO DO PEDIDO DE COMPRA
	j := Len(cObsX)                                    
	i := 1
	
	if j < 170
		cCol += 50
		aRelato.oPrn:Say(cCol,0090,cObsX,aRelato.oFont03 )
	Else
		While j > 0
			cCol += 50	
			aRelato.oPrn:Say(cCol,0090,Substr(cObsX,i,169), aRelato.oFont03 )	
			i+=169
			j := j-169
		End
	EndIf	
	
	//VERIFICA SE O CLIN ATINGE 2400
	fVerPag(lRod)
             
	If cCol < 2700
		cCol := 2670
	EndIf 
	//Movido 
//      imprimo o comprador
	 aRelato.oPrn:Say(cCol, 300,cNome, aRelato.oFont08 )
	//-- Dados dos aprovantes -------------------------------------------------------------------------------------------------------
	If .Not. Empty(cNome) .AND. TRB1->APROV == "S"
	  //imprimo o comprador
	//  aRelato.oPrn:Say(cCol, 300,cNome, aRelato.oFont08 )
	  
	  //dados do coordenador
	  cTipoSC7 := IIF(TRB1->C7_TIPO == 1, "PC", "AE")
		
		vQuery := "SELECT CR_USER";
		    		+ " FROM " + RetSQLName("SCR") + " CR";
			    	+ " WHERE CR_FILIAL = '" 	+ TRB1->C7_FILIAL 	+ "'" ;
			    	+ " AND CR_NUM = '" 		+ TRB1->PEDIDO 	+ "'";
			    	+ " AND CR_TIPO = '"		+ cTipoSC7 			+ "'"

		If Select("TB1") > 0
		    DBSelectArea("TB1")
		    DBCloseArea("TB1")
	    Endif

	   	vQuery := ChangeQuery(vQuery)
	   	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,vQuery),'TB1',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
        	 
	   	aRelato.oPrn:Say(cCol, 1000,UsrFullName(TB1->CR_USER), aRelato.oFont08 ) 
		TB1->(DBCloseArea())
		
	    //dados da diretoria
  		If .Not. Empty(TRB1->C7_GRUPCOM)
		   	vQuery := "SELECT AJ_USER";
			      		+ " FROM " + RetSQLName("SAJ") + " AJ";
				      	+ " WHERE AJ_FILIAL = '" + TRB1->C7_FILIAL + "'" ;
				      	+ " AND AJ_GRCOM = '" + TRB1->C7_GRUPCOM + "'"
	
			  If Select("TB2") > 0
		      	DBSelectArea("TB2")
		      	DBCloseArea("TB2")
		      Endif
			   
		  	vQuery := ChangeQuery(vQuery)
		  	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,vQuery),'TB2',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
		  	
	    	aRelato.oPrn:Say(cCol, 1650,UsrFullName(TB2->AJ_USER), aRelato.oFont08 )
	    	TB2->(DBCloseArea())
		EndIf
	EndIf

	cCol += 40

	//LINHA DO COMPRADOR
	aRelato.oPrn:Line(cCol,0190,cCol,700)
	//LINHA DO COORDENADOR
	aRelato.oPrn:Line(cCol,0900,cCol,1400)
	//LINHA DA DIRETORIA
	aRelato.oPrn:Line(cCol,1500,cCol,2100)

	cCol += 20

	aRelato.oPrn:Say(cCol,0300,"Assinatura do Comprador", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1000,"Assinatura do Coordenador", aRelato.oFont08 )
	aRelato.oPrn:Say(cCol,1650,"Assinatura da Diretoria", aRelato.oFont08 )

	aRelato.oPrn:Say(2850,0090,"1) Este pedido de compra nใo poderแ ser alterado, nem seu atendimento transferido para terceiros sem nossa pr้via autoriza็ใo por escrito.", aRelato.oFont08 )
	aRelato.oPrn:Say(2900,0090,"2) As entregas estใo sujeitas ao controle de qualidade e quantidade no destino. A compradora se reserva o direito de devolver ao fornecedor quantidades ", aRelato.oFont08 )	
	aRelato.oPrn:Say(2950,0090,"excedentes bem como entregues com documenta็ใo irregular ou em desacordo com o especificado neste pedido de compras sendo que, as despesas ", aRelato.oFont08 )	
	aRelato.oPrn:Say(3000,0090,"incidentes ocorrerใo por conta dos fornecedores.", aRelato.oFont08 )	
	aRelato.oPrn:Say(3050,0090,"3) Para efeito de fixa็ใo da data de pagamento serแ tomada por base, a data de entrega da mercadoria. O prazo de entrega estabelecido neste Pedido de Compra", aRelato.oFont08 )	
	aRelato.oPrn:Say(3100,0090,"somente poderแ ser antecipado ou ultrapassado quando previamente por n๓s autorizados.", aRelato.oFont08 )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณ Vitor Daniel       บ Data ณ  07/05/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunte da tela                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PRT0103                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure AjustaSX1(cPerg)

Local aRegs := {}

	aAdd(aRegs,{cPerg, "01","Nบ Pedido de  ?" ,"Nบ Pedido de  ?" ,"Nบ Pedido de  ?" ,"mv_cha" ,"C",06,0,0,"G","" ,"MV_PAR01" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg, "02","Nบ Pedido ate ?" ,"Nบ Pedido ate ?" ,"Nบ Pedido ate ?" ,"mv_cha" ,"C",06,0,0,"G","" ,"MV_PAR02" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})
//	aAdd(aRegs,{cPerg, "03","Usuแrio ?"       ,"Usuแrio ?"       ,"Usuแrio ?"       ,"mv_cha" ,"C",20,0,0,"G","" ,"mv_par03" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})
	
	ValidPerg(aRegs,cPerg)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec     บAutor  ณ Vitor Daniel       บ Data ณ  07/05/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cabecario do Pedido de Venda                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PRT0103                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure Cabec(lRod )

	//IMPRESSAO DO DESENHO(LOGO)
	DO CASE
		Case xFilial("SC7") == "01"//DAISA MATRIZ
			cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SC7") == "02"//FUNDICAO
			cLogo  := '\system\logo_fundicao.jpg'
		Case xFilial("SC7") == "03"//DAIBRAS
			cLogo  := '\system\logo_daibras.jpg'
		Case xFilial("SC7") == "04"//DAISA INDUSTRIAL
			cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SC7") == "05"//DAISA COMERCIO
			cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SC7") == "99"//EMPRESA TESTE
			cLogo  := '\system\logo_daisa.jpg'
	ENDCASE
	
	aRelato.oPrn:SayBitmap( 0100, 0090,AllTrim(cLogo),0300,0180)
	
	DBSelectArea("SM0")
	aRelato.oPrn:Say(0080,0410,SM0->M0_NOMECOM, aRelato.oFont09 )
	aRelato.oPrn:Say(0180,0410,AllTrim(SM0->M0_ENDENT) + ' - BAIRRO: ' + AllTrim(SM0->M0_BAIRENT) + ' - CIDADE: ' + AllTrim(SM0->M0_CIDENT) + ' - CEP: ' + Transform(SM0->M0_CEPENT,"@r 99999-999"), aRelato.oFont03 )
	aRelato.oPrn:Say(0230,0410,'ESTADO: ' + AllTrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + SM0->M0_TEL + ' - FAX: ' + SM0->M0_FAX,aRelato.oFont03 )
	//aRelato.oPrn:Say(0230,0410,'ESTADO: ' + AllTrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + Transform(SM0->M0_TEL,"@r (99) 9999-9999") + ' - FAX: ' + Transform(SM0->M0_FAX,"@r (99) 9999-9999"),aRelato.oFont03 )
	aRelato.oPrn:Say(0280,0410,'CNPJ - ' + Transform(SM0->M0_CGC,"@r 99.999.999/9999-99") + ' - INSCR. ESTADUAL: ' + Transform(SM0->M0_INSC,"@r 999.999.999.999"),aRelato.oFont03 )
	aRelato.oPrn:Say(0080,1650,"Pedido de Compra N.", aRelato.oFont09 )
	aRelato.oPrn:Say(0080,2100,TRB1->PEDIDO, aRelato.oFont09 )
	/*
	aRelato.oPrn:Say(0080,0410,SM0->M0_NOMECOM, aRelato.oFont09 )
	aRelato.oPrn:Say(0180,0410,"RUA ALEXANDRE DUMAS, 2220 - 10บ ANDAR - BAIRRO: CHมC. STO. ANTONIO - CIDADE: SรO PAULO - CEP: 04717-000",aRelato.oFont03 )
	aRelato.oPrn:Say(0230,0410,"ESTADO: "+AllTrim(SM0->M0_ESTENT)+" - TELEFONE: "+ SM0->M0_TEL+" - FAX: " + SM0->M0_FAX,aRelato.oFont03 )
	//aRelato.oPrn:Say(0230,0410,'ESTADO: ' + AllTrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + Transform(SM0->M0_TEL,"@r (99) 9999-9999") + ' - FAX: ' + Transform(SM0->M0_FAX,"@r (99) 9999-9999"),aRelato.oFont03 )
	aRelato.oPrn:Say(0280,0410,'CNPJ - ' + Transform(SM0->M0_CGC,"@r 99.999.999/9999-99") + ' - INSCR. ESTADUAL: ' + Transform(SM0->M0_INSC,"@r 999.999.999.999"),aRelato.oFont03 )
	aRelato.oPrn:Say(0080,1650,"Pedido de Compra N.", aRelato.oFont09 )
	aRelato.oPrn:Say(0080,2100,TRB1->PEDIDO, aRelato.oFont09 )
	*/
	aRelato.nPagina += 1
	aRelato.oPrn:Say(0280,2100,"Pแgina: " + AllTrim( STR( aRelato.nPagina ) ), aRelato.oFont08 ) //NUMERO PAGINA
	
	//LINHA HORIZONTAL SUPERIOR
	aRelato.oPrn:Line(0325,0080,0325,2300)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfVerPag   บAutor  ณ Vitor Daniel       บ Data ณ  07/05/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para analise de paginas                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PRT0103                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure fVerPag(lRod)

	If ( cCol >= 2900 )
		aRelato.oPrn:EndPage()
		cCol  := 0420
		cColu := 0430
		cColf := 0555
		aRelato.oPrn:StartPage()
		
		aRelato.oPrn:Line(0050,0080,0050,2300)
		aRelato.oPrn:Line(0050,0080,3260,0080)
		aRelato.oPrn:Line(3260,0080,3260,2300)
		aRelato.oPrn:Line(0050,2300,3260,2300)
		
		Cabec( lRod )
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT120BRW  บAutor  ณ Vitor Daniel       บ Data ณ  07/05/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para incluir a opcao no menu do Pedido de compras   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PRT0103                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MT120BRW()
  //aAdd(aRotina,{"Imprimir Daisa","U_AC0028()", 0 , 8, 0,nil})  
  aAdd(aRotina,{"Imprimir Daisa","U_PRT0103()", 0 , 8, 0,nil})  
Return aRotina                                                                                         
