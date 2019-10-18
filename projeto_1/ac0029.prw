#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "AC0029.CH"

#DEFINE TOTLINPAG 3200//2350

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออปฑฑ
ฑฑบPrograma  ณ AC0029    บAutor  ณVitor Daniel        บ Data ณ  28/10/10      บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.     ณ IMPRIME O PEDIDO DE VENDA                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION AC0029(cOrigem, cNumPed)

LOCAL cPerg     := ALLTRIM( "DA_PEDIDO" )
LOCAL lContinua := .T.

PRIVATE aRelato := StoreRelato()

	//DEFININDO AS FONTS
	DEFINE FONT aRelato.oFont2 NAME "Arial" SIZE 0,09 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont3 NAME "Arial" SIZE 0,09 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont4 NAME "Arial" SIZE 0,10 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont7 NAME "Arial" SIZE /*0,09*/0,06 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont8 NAME "Arial" SIZE 0,09 OF aRelato.oPrn BOLD
	DEFINE FONT aRelato.oFont9 NAME "Arial" SIZE 0,16 OF aRelato.oPrn BOLD
	
		    aArea := SCP->( GetArea() )
		    aNumber := {}
		    For nNumber := 1 TO 19383
		    
		    IF .Not. SCP->( DBSeek( xFilial("SCP") + StrZero( nNumber ,6 ) ) )
		       AADD( aNumber, StrZero( nNumber ,6 ) )
		    EndIf
		    
		    NEXT
		    RestArea( aArea )
	
	

	AjustaSx1(cPerg)
	IF AllTrim( FunName() ) == "TMKA271" .And. TYPE( "ParamIXB" ) != "U" .And. .Not. EMPTY( ParamIXB[2] )
		Pergunte( cPerg, .F. )
		MV_PAR01 := ParamIXB[2]
		MV_PAR02 := ParamIXB[2]
		lContinua := .T.
	ElseIf Pergunte( cPerg, .T. )
		lContinua := .T.
	EndIf
	
	If lContinua
		
		aRelato.oPrn := TMSPrinter():New( "Impressใo de Pedido de Venda" )
		IF aRelato.oPrn:Setup()
			//aRelato.oPrn :SetLandscape()
			aRelato.oPrn:SetPortrait ( ) // for็a a horienta็ใo do relat๓rio em retrado
			
			RegOrc()
			
			aRelato.oPrn:Preview()
			
			aRelato.oPrn:End()
			
			Ms_Flush()
			
			TRB_AC0029_1->( DBCloseArea() )
			TRB_AC0029_2->( DBCloseArea() )
			TRB_AC0029_3->( DBCloseArea() )
			TRB_AC0029_4->( DBCloseArea() )
			TRB_AC0029_5->( DBCloseArea() )
			
		EndIf
		
	EndIf
				
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRegOrc     บAutor  ณVitor Daniel        บ Data ณ  28/10/10   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Dados do Pedido                                             บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC Procedure RegOrc()

LOCAL cQuery

	If SELECT ("TRB_AC0029_1") > 0
		DbSelectArea("TRB_AC0029_1")
		DbCloseArea("TRB_AC0029_1")
	EndIf
	
	cQuery := "SELECT "+CRLF
	cQuery += " PED.C5_NUM PEDIDO, "+CRLF
	cQuery += " CASE "+CRLF
	cQuery += "    WHEN PED.C5_TIPO = 'N' THEN '1 - Normal' "+CRLF
	cQuery += "    WHEN PED.C5_TIPO = 'C' THEN '2 - Compl. Preco' "+CRLF
	cQuery += "    WHEN PED.C5_TIPO = 'I' THEN '3 - Compl. ICMS' "+CRLF
	cQuery += "    WHEN PED.C5_TIPO = 'P' THEN '4 - Compl. IPI' "+CRLF
	cQuery += "    WHEN PED.C5_TIPO = 'D' THEN '5 - Dev. Compra' "+CRLF
	cQuery += "    WHEN PED.C5_TIPO = 'B' THEN '6 - Utiliza For.' "+CRLF
	cQuery += "  END TIPO, "    +CRLF
	cQuery += "  PED.C5_CLIENTE CODCLI, "+CRLF
	cQuery += "  PED.C5_TIPOCLI DESTINO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_EST ELSE A1_EST END ESTADO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_INSCR ELSE A1_INSCR END INSCR, "+CRLF
	cQuery += "  A1_DESCREG REGIAO, "+CRLF
	cQuery += "  CASE "+CRLF
	cQuery += "    WHEN C5_NOTA <> '' THEN 'Faturado' "+CRLF
	cQuery += "    ELSE 'Liberado' "+CRLF
	cQuery += "  END SITUACAO, "+CRLF
	cQuery += "  SUBSTRING(C5_EMISSAO,7,2) + '/' + SUBSTRING(C5_EMISSAO,5,2) + '/' + SUBSTRING(C5_EMISSAO,1,4) EMISSAO, "+CRLF
	cQuery += "  SUBSTRING(C5_PREVENT,7,2) + '/' + SUBSTRING(C5_PREVENT,5,2) + '/' + SUBSTRING(C5_PREVENT,1,4) PREVISAO, "+CRLF
	cQuery += "  PED.C5_CLIENTE COD_CLIENTE, "+CRLF
	cQuery += "  E4_DESCRI COND_PAGTO, "+CRLF
	cQuery += "  C5_DESCONT DESCONTO, "+CRLF
	cQuery += "  C5_PEDCLI PEDCLI, "+CRLF
	cQuery += "  CASE "+CRLF
	cQuery += "    WHEN C5_TIPOCLI = 'F' THEN 'Cons. Final' "+CRLF
	cQuery += "    WHEN C5_TIPOCLI = 'L' THEN 'Prod. Rural' "+CRLF
	cQuery += "    WHEN C5_TIPOCLI = 'R' THEN 'Revendedor' "+CRLF
	cQuery += "    WHEN C5_TIPOCLI = 'S' THEN 'Solidario' "+CRLF
	cQuery += "    WHEN C5_TIPOCLI = 'X' THEN 'Exportacao/Importacao' "+CRLF
	cQuery += "  END MERCADORIA, "+CRLF
	cQuery += "  CASE when (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_NOME ELSE A1_NOME end RAZAO_CLIENTE, "+CRLF
	cQuery += "  RTRIM(A4_NOME) TRANSPORTADORA, "+CRLF
	cQuery += "  RTRIM(A4_END) + ' - CEP ' + RTRIM(A4_CEP) + ' - ' + RTRIM(A4_BAIRRO) + ' - ' + RTRIM(A4_MUN) + ' - ' + RTRIM(A4_EST) + ' - Telefone: ' + RTRIM(A4_DDD) + RTRIM(A4_TEL) END_TRANSP, RTRIM(A4_CGC) END_CGC,"+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_END ELSE A1_END END ENDERECO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN RTRIM(A2_MUN) ELSE RTRIM(A1_MUN) END CIDADE, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN RTRIM(A2_EST) ELSE RTRIM(A1_EST) END ESTADO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN RTRIM(A2_BAIRRO) ELSE RTRIM(A1_BAIRRO) END BAIRRO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_CEP ELSE A1_CEP END CEP, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '(' + RTRIM(A2_DDD) + ') ' + SUBSTRING(A2_TEL,1,4) + '-' + SUBSTRING(A2_TEL,5,4) ELSE '(' + RTRIM(CLI.A1_DDD) + ') ' + SUBSTRING(CLI.A1_TEL,1,4) + '-' + SUBSTRING(CLI.A1_TEL,5,4) END FONE, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '(' + RTRIM(A2_DDD) + ') ' + SUBSTRING(A2_FAX,1,4) + '-' + SUBSTRING(A2_FAX,5,4) ELSE '(' + RTRIM(CLI.A1_DDD) + ') ' + SUBSTRING(CLI.A1_FAX,1,4) + '-' + SUBSTRING(CLI.A1_FAX,5,4) END FAX, "+CRLF
	cQuery += "  CASE "+CRLF
	cQuery += "    WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN "+CRLF
	cQuery += "      CASE "+CRLF
	cQuery += "        WHEN len(A2_CGC) = 14 THEN SUBSTRING(A2_CGC,1,2) +'.'+ SUBSTRING(A2_CGC,3,3) +'.'+ SUBSTRING(A2_CGC,6,3) +'/'+ SUBSTRING(A2_CGC,9,4) +'-'+ SUBSTRING(A2_CGC,13,2) "+CRLF
	cQuery += "        ELSE SUBSTRING(A2_CGC,1,3) +'.'+ SUBSTRING(A2_CGC,3,3) +'.'+ SUBSTRING(A2_CGC,6,3) +'-'+ SUBSTRING(A2_CGC,9,2) "+CRLF
	cQuery += "      END "+CRLF
	cQuery += "    ELSE "+CRLF
	cQuery += "    CASE "+CRLF
	cQuery += "      WHEN len(A1_CGC) = 14 then SUBSTRING(A1_CGC,1,2) +'.'+ SUBSTRING(A1_CGC,3,3) +'.'+ SUBSTRING(A1_CGC,6,3) +'/'+ SUBSTRING(A1_CGC,9,4) +'-'+ SUBSTRING(A1_CGC,13,2) "+CRLF
	cQuery += "      ELSE SUBSTRING(A1_CGC,1,3) +'.'+ SUBSTRING(A1_CGC,3,3) +'.'+ SUBSTRING(A1_CGC,6,3) +'-'+ SUBSTRING(A1_CGC,9,2) "+CRLF
	cQuery += "    END "+CRLF
	cQuery += "  END CGC_CPF, "+CRLF
	
	cQuery += "  CASE "+CRLF
	cQuery += "    WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN "+CRLF
	cQuery += "      CASE "+CRLF
	cQuery += "        WHEN len(A2_INSCR) = 12 THEN "+CRLF
	cQuery += "          SUBSTRING(A2_INSCR,1,3) +'.'+ "+CRLF
	cQuery += "          SUBSTRING(A2_INSCR,4,3) +'.'+ "+CRLF
	cQuery += "          SUBSTRING(A2_INSCR,7,3) +'.'+ "+CRLF
	cQuery += "          SUBSTRING(A2_INSCR,10,3) "+CRLF
	cQuery += "        ELSE A2_INSCR "+CRLF
	cQuery += "      END "+CRLF
	cQuery += "    ELSE "+CRLF
	cQuery += "      CASE "+CRLF
	cQuery += "        WHEN len(A1_INSCR) = 12 THEN "+CRLF
	cQuery += "          SUBSTRING(A1_INSCR,1,3) +'.'+ "+CRLF
	cQuery += "          SUBSTRING(A1_INSCR,4,3) +'.'+ "+CRLF
	cQuery += "          SUBSTRING(A1_INSCR,7,3) +'.'+ "+CRLF
	cQuery += "          SUBSTRING(A1_INSCR,10,3) "+CRLF
	cQuery += "        ELSE A1_INSCR "+CRLF
	cQuery += "      END "+CRLF
	cQuery += "  END IE_RG, "+CRLF
	cQuery += "  CASE WHEN C5_TPFRETE = 'C' THEN 'CIF' ELSE 'FOB' END TIPO_FRETE, "+CRLF
	cQuery += "  C5_FRETE VALOR_FRETE, "+CRLF
	cQuery += "  0 IPI_FRETE, "+CRLF
	cQuery += "  C5_SEGURO SEGURO, "+CRLF
	cQuery += "  VEND.A3_NOME VENDEDOR, "+CRLF
	cQuery += "  VEND.A3_DDDTEL DDDTEL, "+CRLF
	cQuery += "  VEND.A3_TEL TEL_VEND, "+CRLF
	cQuery += "  VEND.A3_EMAIL EMAIL_VEND, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_CONTATO ELSE CLI.A1_CONTATO END CONTATO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_EMAIL ELSE CLI.A1_EMAIL END EMAIL_CONTATO, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN A2_TEL ELSE CLI.A1_TEL END TEL_CONTATO, "+CRLF
	cQuery += "  PED.C5_EMITENT EMITENTE, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '' ELSE CASE WHEN A1_ENDCOB = A1_END THEN '' ELSE A1_ENDCOB END END ENDCOB , "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '' ELSE A1_ESTCOB END ESTADOCOB, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '' ELSE A1_MUNCOB END CIDADECOB, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '' ELSE A1_BAIRCOB END BAIRROCOB, "+CRLF
	cQuery += "  CASE WHEN (PED.C5_TIPO = 'D') OR (PED.C5_TIPO = 'B') THEN '' ELSE A1_CEPCOB END CEPCOB, "+CRLF
	cQuery += "  A1_ENDENT ENDENT , "+CRLF
	cQuery += "  A1_ESTE   ESTE, "+CRLF
	cQuery += "  A1_MUNE   MUNE, "+CRLF
	cQuery += "  A1_BAIRROE BAIRROE, "+CRLF
	cQuery += "  A1_CEPE CEPE, "+CRLF
	cQuery += "  C5_PBRUTO PESO_BRUTO, "+CRLF
	cQuery += "  C5_PESOL PESO_LIQUIDO, "+CRLF
	cQuery += "  C5_VOLUME1 VOLUME, "+CRLF
	cQuery += "  C5_ESPECI1 ESPECIE, "+CRLF
	cQuery += "  C5_NOTA OBSERVACAO_NF "+CRLF
	cQuery += " FROM  "+CRLF
	cQuery += RetSqlName("SC5") + " PED "+CRLF
	cQuery += " LEFT OUTER JOIN "+CRLF
	cQuery += RetSqlName("SA1") + " CLI "+CRLF
	cQuery += " ON "+CRLF
	cQuery += "   CLI.A1_COD = PED.C5_CLIENTE "+CRLF
	cQuery += "   AND CLI.A1_LOJA = PED.C5_LOJACLI "+CRLF
	cQuery += "   AND A1_FILIAL = '" + xFilial("SA1") + "'"+CRLF
	cQuery += "   AND CLI.D_E_L_E_T_ = '' "+CRLF
	cQuery += " LEFT OUTER JOIN "+CRLF
	cQuery += RetSqlName("SA2") + " FO "+CRLF
	cQuery += " ON "+CRLF
	cQuery += "   FO.A2_COD = PED.C5_CLIENTE "     +CRLF
	cQuery += "   AND A2_FILIAL = '" + xFilial("SA2") + "'"+CRLF
	cQuery += "   AND FO.D_E_L_E_T_ = '' "+CRLF
	cQuery += " LEFT OUTER JOIN "+CRLF
	cQuery += RetSqlName("SA4") + " TRANSP "+CRLF
	cQuery += " ON "+CRLF
	cQuery += "  TRANSP.A4_COD = PED.C5_TRANSP   "+CRLF
	cQuery += "   AND TRANSP.D_E_L_E_T_ = '' "+CRLF
	cQuery += "   AND A4_FILIAL = '" + xFilial("SA4") + "'"+CRLF
	cQuery += " LEFT OUTER JOIN "+CRLF
	cQuery += RetSqlName("SE4") + " COND "+CRLF
	cQuery += " ON "+CRLF
	cQuery += "   COND.E4_CODIGO = PED.C5_CONDPAG "+CRLF
	cQuery += "   AND COND.D_E_L_E_T_ = '' "     +CRLF
	cQuery += "   AND E4_FILIAL = '" + xFilial("SE4") + "'" +CRLF
	cQuery += " LEFT OUTER JOIN "+CRLF
	cQuery += RetSqlName("SA3") + " VEND "+CRLF
	cQuery += " ON "+CRLF
	cQuery += "   VEND.A3_COD = PED.C5_VEND1 "+CRLF
	cQuery += "   AND VEND.D_E_L_E_T_ = '' " +CRLF
	cQuery += "   AND A3_FILIAL = '" + xFilial("SA3") + "'"+CRLF
	cQuery += " WHERE  "+CRLF
	cQuery += "   1 = 1 "+CRLF
	cQuery += "   AND PED.D_E_L_E_T_ = '' "+CRLF
	cQuery += "   AND PED.C5_NUM >= '"+MV_PAR01+"'"+CRLF
	cQuery += "   AND PED.C5_NUM <= '"+MV_PAR02+"'"+CRLF
	cQuery += "   AND PED.C5_FILIAL = '"+xFilial("SC5")+"'"+CRLF
	cQuery += " ORDER BY  1 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB_AC0029_1',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
	
	While TRB_AC0029_1->( .NOT. Eof())
		aRelato.oPrn:StartPage()
		
		LayOutOP()
		
		TRB_AC0029_1->(dbSkip())
		
		aRelato.oPrn:EndPage()
	EndDo
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLayOutOP  บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do Layout do Pedido                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTFR0001                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC PROCEDURE LayOutOP()

Local cQuery
Local nPos
Local nItem		:= 0
Local nDesc		:= 0   
Local nDesc2	:= 0
Local nDesc3	:= 0
Local nDesc4	:= 0
Local OBS1      := ""
Local OBS2      := ""      
Local vNomeOper2 := ""

Local nQtdPeso  := 0

Private cTam      := 40
Private lRod      := .T.
Private cCol

	DbSelectArea("TRB_AC0029_1")
	
	//CABECALHO
	Cabec(lRod)
	
	cCol := 300
	
	aRelato.oPrn:Say(cCol,0100,"Contato:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0300,TRB_AC0029_1->CONTATO, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,/*1700*/0800,"Fone:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*1850*/0950,"("+SA1->A1_DDD+ ")"+TRB_AC0029_1->TEL_CONTATO, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,/*2300*/1300,"E-mail NFe:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*2550*/1500,TRB_AC0029_1->EMAIL_CONTATO, aRelato.oFont3)
	
	cCol+=50
	aRelato.oPrn:Say(cCol,0100,"Cliente:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0300,TRB_AC0029_1->CODCLI + ' - ' + TRB_AC0029_1->RAZAO_CLIENTE, aRelato.oFont3)
	//aRelato.oPrn:Say(cCol,/*2300*/1750,"Regiใo:", aRelato.oFont4)
	//aRelato.oPrn:Say(cCol,/*2550*/1950,TRB_AC0029_1->REGIAO, aRelato.oFont3)
	
	cCol+=50
	aRelato.oPrn:Say(cCol,0100,"Endere็o:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0300,TRB_AC0029_1->ENDERECO, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,/*2300*/1750,"Cidade:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*2550*/1950,TRB_AC0029_1->CIDADE, aRelato.oFont3)
	
	cCol+=50
	aRelato.oPrn:Say(cCol,0100,"Estado:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0300,TRB_AC0029_1->ESTADO, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0400,"CEP:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0500,TRB_AC0029_1->CEP, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0800,"Bairro:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0950,TRB_AC0029_1->BAIRRO, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,/*2300*/1750,"I. Estadual:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*2550*/1950,TRB_AC0029_1->IE_RG, aRelato.oFont3)
	
	cCol+=50
	aRelato.oPrn:Say(cCol,/*1700*/0100,"CNPJ:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*1850*/0300,TRB_AC0029_1->CGC_CPF, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0800,"Vendedor", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0960,TRB_AC0029_1->VENDEDOR, aRelato.oFont3)
	
	DbSelectArea("SU7")
	SU7->( DbSetOrder(1) ) //operador
	If SU7->( DbSeek(xFilial()+SUA->UA_OPERADO) )
		cNomeOper := SU7->U7_NOME
	EndIf
	SU7->( DbCloseArea() )
	
	//Next i
	cCol+=50
	aRelato.oPrn:Say(cCol,/*2300*/0100,"E-mail Vend:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*2550*/0350,TRB_AC0029_1->EMAIL_VEND, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,/*1700*/0800,"Fone Vend:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,/*1850*/1000,"("+TRB_AC0029_1->DDDTEL+") "+TRB_AC0029_1->TEL_VEND, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1750,"Atendente:", aRelato.oFont4)
		
	//Decodifica o nome do Operador no Registro
	DbSelectArea("SC5")
	SC5->( DbSetOrder(1) )
	If SC5->( DbSeek( xFilial("SC5")+TRB_AC0029_1->PEDIDO) )
		vNomeOper2 := UPPER(FWLeUserlg ("C5_USERLGI"))
		vNomeOper2 := STRTRAN(vNomeOper2,".", " ")
	EndIf
	SC5->( DbCloseArea() )
	
	aRelato.oPrn:Say(cCol,1950,vNomeOper2, aRelato.oFont3)
	//aRelato.oPrn:Say(cCol,/*1700*/1300,"Fone:", aRelato.oFont4)
	//aRelato.oPrn:Say(cCol,/*1850*/1400,SM0->M0_TEL, aRelato.oFont3)
	//aRelato.oPrn:Say(cCol,/*2300*/1750,"E-mail Atend:", aRelato.oFont4)
	//aRelato.oPrn:Say(cCol,2550,cEmail, aRelato.oFont3)
	
	cCol += 40
	aRelato.oPrn:Line(cCol,0080,cCol,2500)
	
	cCol+=10
	aRelato.oPrn:Say(cCol,0100,"Endere็o de Cobran็a:", aRelato.oFont4)
	cCol+=40
	If Empty(TRB_AC0029_1->ENDCOB)
		aRelato.oPrn:Say(cCol,0100,Alltrim(TRB_AC0029_1->ENDERECO) + ' - BAIRRO: ' + Alltrim(TRB_AC0029_1->BAIRRO) + ' - CIDADE: ' + Alltrim(TRB_AC0029_1->CIDADE) + ' - CEP: ' + Alltrim(TRB_AC0029_1->CEP) + " - " + Alltrim(TRB_AC0029_1->ESTADO), aRelato.oFont3)
	Else
		aRelato.oPrn:Say(cCol,0100,Alltrim(TRB_AC0029_1->ENDCOB) + ' - BAIRRO: ' + Alltrim(TRB_AC0029_1->BAIRROCOB) + ' - CIDADE: ' + Alltrim(TRB_AC0029_1->CIDADECOB) + ' - CEP: ' + Alltrim(TRB_AC0029_1->CEPCOB) + " - " + Alltrim(TRB_AC0029_1->ESTADOCOB), aRelato.oFont3)
	EndIf
	
	cCol += 40
	aRelato.oPrn:Line(cCol,0080,cCol,2500)
	
	cCol+=10
	aRelato.oPrn:Say(cCol,0100,"Endere็o de Entrega:", aRelato.oFont4)
	cCol+=40
	If Empty(TRB_AC0029_1->ENDENT)
		aRelato.oPrn:Say(cCol,0100,Alltrim(TRB_AC0029_1->ENDERECO) + ' - BAIRRO: ' + Alltrim(TRB_AC0029_1->BAIRRO) + ' - CIDADE: ' + Alltrim(TRB_AC0029_1->CIDADE) + ' - CEP: ' + Alltrim(TRB_AC0029_1->CEP) + " - " + Alltrim(TRB_AC0029_1->ESTADO), aRelato.oFont3)
	Else
		aRelato.oPrn:Say(cCol,0100,Alltrim(TRB_AC0029_1->ENDENT) + ' - BAIRRO: ' + Alltrim(TRB_AC0029_1->BAIRROE) + ' - CIDADE: ' + Alltrim(TRB_AC0029_1->MUNE) + ' - CEP: ' + Alltrim(TRB_AC0029_1->CEPE) + " - " + Alltrim(TRB_AC0029_1->ESTE), aRelato.oFont3)
	EndIf
	
	cCol += 40
	aRelato.oPrn:Line(cCol,0080,cCol,2500)
	
	//PEGA OS DADOS DO CFOP
	If SELECT ("TRB_AC0029_5") > 0
		DbSelectArea("TRB_AC0029_5")
		DbCloseArea("TRB_AC0029_5")
	EndIf
	
	cQuery := " SELECT DISTINCT "
	cQuery += "   C6_NUM PEDIDO, "
	cQuery += "   C6_CF CF, "
	cQuery += "   F4_TEXTO TEXTO "
	cQuery += " FROM "
	cQuery += RetSqlName("SC6") + " PED "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SF4") + " TES "
	cQuery += " ON "
	cQuery += "   F4_CODIGO = C6_TES "
	cQuery += "   AND TES.D_E_L_E_T_ = '' "
	cQuery += "   AND F4_FILIAL = '" + xFilial("SF4") + "' "
	cQuery += " WHERE "
	cQuery += "   C6_NUM = '" + TRB_AC0029_1->PEDIDO + "' "
	cQuery += "   AND PED.D_E_L_E_T_ = '' "
	cQuery += "   AND PED.C6_FILIAL  = '" + xFilial("SC6") + "' "
	cQuery += " ORDER BY 2 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB_AC0029_5',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
	
	cCFOP := ""
	While TRB_AC0029_5->( .NOT. Eof()) .And. TRB_AC0029_5->PEDIDO == TRB_AC0029_1->PEDIDO
		cCFOP += TRB_AC0029_5->CF + " - " + TRB_AC0029_5->TEXTO + ", "
		
		TRB_AC0029_5->(dbSkip())
	EndDo
	
	cCol += 10
	aRelato.oPrn:Say(cCol,0100,cCFOP, aRelato.oFont4)
	DbSelectArea("SC5")
	SC5->( DbSetOrder(1) )
	If SC5->( DbSeek( xFilial("SC5") + TRB_AC0029_1->PEDIDO /*+ TRB_AC0029_2->ITEM*/ ) )
		nDesc  := SC5->C5_DESC1
		nDesc2 := SC5->C5_DESC2
		nDesc3 := SC5->C5_DESC3
		nDesc4 := SC5->C5_DESC4
	EndIf
	SC5->( DbCloseArea() )
	
	cCol += 40
	aRelato.oPrn:Say(cCol,0700,"%Desc. Ped.", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0950,cValToChar(nDesc), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1100,"%Desc. Imp.", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1350,cValToChar(nDesc2), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1500,"%Desc. Pagto.", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1750,cValToChar(nDesc3), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1850,"%Desc. Adic.", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,2100,cValToChar(nDesc4), aRelato.oFont3)
	//cColAux := cCol  // Guarda a posi็ใo da linha para imprimir os descontos
	
	cCol += 40
	aRelato.oPrn:Line(cCol,0080,cCol,2500)
	//VERIFICA SE O CLIN ATINGE TOTLINPAG
	fVerPag(lRod)
	
	//CABECALHO ITENS DO ORCAMENTO
	cCol += 10
	
	//PARTE 4
	aRelato.oPrn:Say(cCol,0100,"Item", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,0300,"C๓digo", aRelato.oFont8)
	//aRelato.oPrn:Say(cCol,0600,"Descri็ใo", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*1400*/0700,"Entrega", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*1650*/0965,"Qtd.", aRelato.oFont8)
	//aRelato.oPrn:Say(cCol,1800,"Apr.", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*1970*/1100,"Val. Unit.", aRelato.oFont8)
	//aRelato.oPrn:Say(cCol,/*2200*/0900,"% ICMS", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*2200*/1400,"TES", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*2600*/1550,"Val. Total", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*2850*/1800,"% IPI", aRelato.oFont8)
	aRelato.oPrn:Say(cCol,/*3000*/2000,"Val. IPI", aRelato.oFont8)
	
	cCol += 40
	aRelato.oPrn:Line(cCol,0080,cCol,2500)
	nLin1 := cCol
	lAuxi := .F.
	
	//ITENS DO ORCAMENTO
	If SELECT ("TRB_AC0029_2") > 0
		DbSelectArea("TRB_AC0029_2")
		DbCloseArea("TRB_AC0029_2")
	EndIf
	
	cQuery := " SELECT "
	cQuery += "   C6_NUM PEDIDO, "
	cQuery += "   C6_ITEM ITEM, "
	cQuery += "   C6_TES TES, "
	cQuery += "   C6_PRODUTO COD_PRODUTO, "
	cQuery += "   RTRIM(B1_COD) CODIGO, "
	cQuery += "   RTRIM(B1_COD) XCODIGO, "
	cQuery += "   RTRIM(C6_DESCRI) PRODUTO, "
	cQuery += "   B1_UM UNIDADE, "
	cQuery += "   C6_QTDVEN QTDE, "
	cQuery += "   C6_PRCVEN VAL_UNIT, "
	cQuery += "   C6_ENTREG ENTREGA, "
	cQuery += "   C6_VALOR VALOR, "
	cQuery += "   CASE WHEN F4_IPI = 'S' THEN B1_IPI ELSE 0 END IPI, "
	cQuery += "   CASE WHEN F4_IPI = 'S' THEN ((C6_VALOR * B1_IPI)/100) ELSE 0 END VAL_IPI, "
	cQuery += "   C6_DESCONT DESCONTO, "
	cQuery += "   C6_CF CF, "
	cQuery += "   B1_PICM ICMS, "
	cQuery += "   F4_ICM ICM "
	cQuery += " FROM "
	cQuery += RetSqlName("SC6") + " PED "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SB1") + " PRD "
	cQuery += " ON "
	cQuery += "   B1_COD = C6_PRODUTO "
	cQuery += "   AND B1_FILIAL = '" + xFilial("SB1") + "'"
	cQuery += "	AND PRD.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SF4") + " TES "
	cQuery += " ON "
	cQuery += "   F4_CODIGO = C6_TES "
	cQuery += "   AND F4_FILIAL = '" + xFilial("SF4") + "'"
	cQuery += "   AND TES.D_E_L_E_T_ = '' "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SC9") + " LIB "
	cQuery += " ON "
	cQuery += "   C9_PEDIDO = C6_NUM "
	cQuery += "   AND C9_ITEM = C6_ITEM "
	cQuery += "   AND C9_QTDLIB = C6_QTDVEN "
	cQuery += "   AND C9_FILIAL = '" + xFilial("SC9") + "' "
	cQuery += "   AND LIB.D_E_L_E_T_ = '' "
	cQuery += " WHERE "
	cQuery += "   C6_NUM = '" + TRB_AC0029_1->PEDIDO+ "' "
	cQuery += "   AND C6_FILIAL = '" + xFilial("SC6")+ "' "
	cQuery += "   AND PED.D_E_L_E_T_ = '' "
	cQuery += " ORDER BY 2 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB_AC0029_2',.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณLOOPING PARA PEGAR ITENS DO PEDIDO   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	nVTmerc		:= 0
	nItemPed    := 0
	nVarIipi    := TRB_AC0029_2->IPI
	While TRB_AC0029_2->( .Not. Eof()) .And. TRB_AC0029_2->PEDIDO == TRB_AC0029_1->PEDIDO
		
		nItemPed+=1
		cIni  := cCol-55
		nLin2 := cCol
		
		cCol:=IIf( cCol+100 > TOTLINPAG, TOTLINPAG+1, cCol)
		//VERIFICA SE O CLIN ATINGE TOTLINPAG
		fVerPag(lRod)
		//aRelato.oPrn:Line(nLin1,0190,nLin2,0190)
		//aRelato.oPrn:Line(nLin1,0590,nLin2,0590)
		//nLin1 := cCol
		//nLin2 := cCol
		
		
		nPerRet   := 0                // Percentual de retorno
		cEstado   := GetMV("mv_estado")
		tNorte    := GetMV("MV_NORTE")
		cEstCli   := TRB_AC0029_1->ESTADO
		cInscrCli := TRB_AC0029_1->INSCR
		
		If TRB_AC0029_2->ICM == "S"
			If TRB_AC0029_1->DESTINO == "F" .And. Empty(cInscrCli)
				nPerRet := iif(TRB_AC0029_2->ICMS>0,TRB_AC0029_2->ICMS,GetMV("MV_ICMPAD"))
			Elseif TRB_AC0029_1->DESTINO == "F" .And. ALLTRIM(UPPER(cInscrCli)) == "ISENTO"
				nPerRet := iif(TRB_AC0029_2->ICMS>0,TRB_AC0029_2->ICMS,GetMV("MV_ICMPAD"))
			Elseif TRB_AC0029_2->ICMS > 0 .And. cEstCli == cEstado
				nPerRet := TRB_AC0029_2->ICMS
			Elseif cEstCli == cEstado
				nPerRet := GetMV("MV_ICMPAD")
			Elseif cEstCli $ tNorte .And. At(cEstado,tNorte) == 0
				nPerRet := 7
			Elseif TRB_AC0029_1->DESTINO == "X"
				nPerRet := 13
			Else
				nPerRet := 12
			Endif
		Endif
		
		lRod := .F.
		
		If !lAuxi
			cTam := 0
		EndIf
		
		aRelato.oPrn:Say(cCol+cTam,0120,TRB_AC0029_2->ITEM, aRelato.oFont3)                                	//ITEM
		
		aRelato.oPrn:Say(cCol+cTam,0315,TRB_AC0029_2->XCODIGO, aRelato.oFont3)
		//VERIFICA QUANTIDADE DE CARACTERES
		/* --cCodDesc := Alltrim(TRB_AC0029_2->PRODUTO)      //   Henrique
		//if Len(cCodDesc) <= 45
		//	aRelato.oPrn:Say(cCol+cTam,0610,cCodDesc, aRelato.oFont7)									//PRODUTO
		//	cColu := cCol+cTam
		//ElseIf Len(cCodDesc) <= 110
		//	aRelato.oPrn:Say(cCol+cTam,0610,     SUBSTR(cCodDesc,1,45), aRelato.oFont7)
		//	aRelato.oPrn:Say(cCol+cTam+cTam,0610,SUBSTR(cCodDesc,46,45), aRelato.oFont7)
		//	cColu := cCol+cTam+cTam
		//Else
		//	aRelato.oPrn:Say(cCol+cTam,0610,          SUBSTR(cCodDesc,1,45), aRelato.oFont7)
		//	aRelato.oPrn:Say(cCol+cTam+cTam,0610,     SUBSTR(cCodDesc,46,45), aRelato.oFont7)
		//	aRelato.oPrn:Say(cCol+cTam+cTam+cTam,0610,SUBSTR(cCodDesc,91,45), aRelato.oFont7)
		//	cColu := cCol+cTam+cTam+cTam
		//EndIf*/
		cColu := cCol+cTam//+cTam+cTam
		aRelato.oPrn:Say(cCol+cTam,/*1400*/0715,SubStr(TRB_AC0029_2->ENTREGA, 7,2) + "/" +SubStr(TRB_AC0029_2->ENTREGA, 5,2) + "/" + SubStr(TRB_AC0029_2->ENTREGA, 1,4), aRelato.oFont3)      	//QTDE
		aRelato.oPrn:Say(cCol+cTam,/*1680*/0975,Transform(TRB_AC0029_2->QTDE,"@ 999,999.99"), aRelato.oFont3)      	//QTDE
		//	aRelato.oPrn:Say(cCol+cTam,/*1830*/1220,TRB_AC0029_2->UNIDADE, aRelato.oFont7)								//UNIDADE
		aRelato.oPrn:Say(cCol+cTam,/*2000*/1110,Transform( NoRound(TRB_AC0029_2->VAL_UNIT, 2 ),"@E 999,999.99"), aRelato.oFont3)	//VALOR UNITARIO
		//	aRelato.oPrn:Say(cCol+cTam,/*2230*/0910,Transform(nPerRet,"@ 99"), aRelato.oFont7)					//ICMS
		aRelato.oPrn:Say(cCol+cTam,/*2230*/1410,Transform(TRB_AC0029_2->TES,"@ 99"), aRelato.oFont3)                 //TES
		aRelato.oPrn:Say(cCol+cTam,/*2630*/1510,Transform( NoRound(TRB_AC0029_2->VALOR, 2 ),"@E 999,999,999.99"), aRelato.oFont3)	//VALOR TOTAL
		aRelato.oPrn:Say(cCol+cTam,/*2880*/1810,Transform(TRB_AC0029_2->IPI,"@ 99"), aRelato.oFont3)					//IPI
		aRelato.oPrn:Say(cCol+cTam,/*3000*/2000,Transform(TRB_AC0029_2->VAL_IPI,"@E 999,999.99"), aRelato.oFont3)	//VALOR IPI
		
		cCol  := cColu+40 //50
		
		//aRelato.oPrn:Line(cIni,0190,cCol,0190)
		//aRelato.oPrn:Line(cIni,0590,cCol,0590)
		
		aRelato.oPrn:Line(cCol,0080,cCol,2500)
		
		cCol  := cCol - 40 //20
		cTam  := 50
		lAuxi := .T.
		
		TRB_AC0029_2->(dbSkip())
	EndDo
	
	lRod := .T.
	//VERIFICA SE O CLIN ATINGE TOTLINPAG
	cCol:=IIf( cCol+250 > TOTLINPAG, TOTLINPAG+1, cCol)
	fVerPag(lRod)
	
	cCol := cCol+50
	
	//TOTAL ITENS DO PEDIDO
	If SELECT ("TRB_AC0029_3") > 0
		dbSelectArea("TRB_AC0029_3")
		dbCloseArea("TRB_AC0029_3")
	EndIf
	
	cQuery := " SELECT DISTINCT"
	cQuery += "   C6_CLI CODCLI, "
	cQuery += "   C6_LOJA LOJA, "
	cQuery += "   C6_ITEM ITEM, "
	cQuery += "   C6_NUM PEDIDO, "
	cQuery += "   C6_PRODUTO PRODUTO, "
	cQuery += "   C6_TES TES, "
	cQuery += "   B1_PICM ICMS, "
	cQuery += "   F4_ICM ICM, "
	cQuery += "   F4_IPI IPI_, "
	cQuery += "   F7_ALIQINT INTERNA, "
	cQuery += "   F7_MARGEM IVA, "
	cQuery += "   C6_VALOR VALOR, "
	cQuery += "   C6_QTDVEN QUANTIDADE, "
	cQuery += "   C6_PRCVEN PRECO, "
	cQuery += "   C5_DESCONT DESCONTO, "
	cQuery += "   C5_DESPESA DESPESA, "
	cQuery += "   C5_FRETE FRETE, "
	cQuery += "   C5_TIPOCLI TIPOCLI, "
	cQuery += "   C5_TIPO TIPO, "
	cQuery += "   CASE WHEN F4_CREDIPI = 'S' THEN (((C6_VALOR+C5_FRETE) * B1_IPI)/100) ELSE 0 END VALOR_IPI, "
	cQuery += "   CASE WHEN F4_CREDIPI = 'S' THEN ((C6_VALOR+C5_FRETE) + (((C6_VALOR+C5_FRETE) * B1_IPI)/100)) ELSE C6_VALOR END VALOR_TOTAL, "
	cQuery += "   C6_VALOR VALOTMER,"
	cQuery += "   B1_IPI IPI "
	cQuery += " FROM "
	cQuery += RetSqlName("SC6") + " I_ORC "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SC5") + " SC5 "
	cQuery += " ON "
	cQuery += "   C5_NUM = C6_NUM "
	cQuery += "   AND C5_FILIAL = C6_FILIAL "
	cQuery += "   AND SC5.D_E_L_E_T_ = '' "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SB1") + " PRD "
	cQuery += " ON "
	cQuery += "   B1_COD = C6_PRODUTO "
	cQuery += "   AND B1_FILIAL = C6_FILIAL "
	cQuery += "	AND PRD.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SF4") + " TES "
	cQuery += " ON "
	cQuery += "   TES.F4_CODIGO = I_ORC.C6_TES "
	cQuery += "   AND F4_FILIAL = C6_FILIAL "
	cQuery += "	AND TES.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SA1") + " SA1 "
	cQuery += " ON "
	cQuery += "   A1_COD = C5_CLIENTE "
	cQuery += "   AND A1_FILIAL = C5_FILIAL "
	cQuery += "	AND SA1.D_E_L_E_T_ = ''"
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SF7") + " SF7 "
	cQuery += " ON "
	cQuery += "   F7_GRTRIB = B1_GRTRIB "
	cQuery += "   AND F7_TIPOCLI = A1_TIPO "
	cQuery += "   AND F7_EST = A1_EST "
	cQuery += "   AND F7_FILIAL = C6_FILIAL "
	cQuery += "   AND SF7.D_E_L_E_T_ = '' "
	cQuery += " WHERE 1 = 1 "
	cQuery += "   AND C6_NUM = '" + TRB_AC0029_1->PEDIDO+ "' " //PEGAR O NUMERO DO ORCAMENTO
	cQuery += "   AND I_ORC.D_E_L_E_T_ = '' "
	cQuery += "   AND C6_FILIAL = '" + xFilial("SC6") + "'"
	cQuery += " ORDER BY 1 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB_AC0029_3',.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
	
	VAL_SUF		:= 0
	VAL_PRD 	:= 0
	VAL_IPI 	:= 0
	VAL_TOT 	:= 0
	VAL_ST  	:= 0
	ST_AUX  	:= 0
	VAL_FRETE	:= 0
	VAL_DESPESA := 0
	VAL_DESCONTO:= 0
	cItemAux    := ""
	
	nTOT_ST		:= 0
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณcalculo dos valores fiscais                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicializa a funcao fiscal                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	DBSelectArea("SB1")
	WHILE !TRB_AC0029_3->(EOF())
		If cItemAux <> TRB_AC0029_3->ITEM
			VAL_FRETE	:= TRB_AC0029_3->FRETE
			VAL_DESPESA := TRB_AC0029_3->DESPESA
			VAL_DESCONTO:= TRB_AC0029_3->DESCONTO
			
			nfreteIt	:= (TRB_AC0029_3->VALOR / nVTmerc)* TRB_AC0029_3->FRETE
			
			nItem++
			MaFisSave()
			MaFisEnd()
			MaFisIni((TRB_AC0029_3->CODCLI),;                // 1-Codigo Cliente/Fornecedor
			          TRB_AC0029_3->LOJA,;		              // 2-Loja do Cliente/Fornecedor
			          IIf(TRB_AC0029_3->TIPO$'DB',"F","C"),; // 3-C:Cliente , F:Fornecedor
			          TRB_AC0029_3->TIPO,;				      // 4-Tipo da NF
			          TRB_AC0029_3->TIPOCLI,;		          // 5-Tipo do Cliente/Fornecedor
			          Nil,;
			          Nil,;
			          Nil,;
			          Nil,;
			          "MATA641")
			
			
			MaFisAdd(TRB_AC0029_3->PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
			         TRB_AC0029_3->TES,;	   	// 2-Codigo do TES ( Opcional )
			         TRB_AC0029_3->QUANTIDADE,;	// 3-Quantidade ( Obrigatorio )
			         TRB_AC0029_3->PRECO,;      // 4-Preco Unitario ( Obrigatorio )
			         TRB_AC0029_3->DESCONTO,;   // 5-Valor do Desconto ( Opcional )
			         "",;	   			        // 6-Numero da NF Original ( Devolucao/Benef )
			         "",;				        // 7-Serie da NF Original ( Devolucao/Benef )
			         0,;				        // 8-RecNo da NF Original no arq SD1/SD2
			         0,;				        // 9-Valor do Frete do Item ( Opcional )
			         0,;				        // 10-Valor da Despesa do item ( Opcional )
			         0,;				        // 11-Valor do Seguro do item ( Opcional )
			         0,;				        // 12-Valor do Frete Autonomo ( Opcional )
			         TRB_AC0029_3->VALOR,;		// 13-Valor da Mercadoria ( Obrigatorio )
			         0)					        // 14-Valor da Embalagem ( Opiconal )
			
			
			SB1->(dbSetOrder(1))
			If SB1->(MsSeek(xFilial("SB1")+TRB_AC0029_3->PRODUTO))
				nQtdPeso := TRB_AC0029_3->QUANTIDADE*SB1->B1_PESO
			Endif
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAltera peso para calcular frete              ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			
			MaFisAlt("IT_PESO",nQtdPeso,nItem)
			MaFisAlt("IT_PRCUNI",TRB_AC0029_3->PRECO,nItem)
			MaFisAlt("IT_VALMERC",TRB_AC0029_3->VALOR,nItem)
			
			//nValFrete:=TRB_AC0029_3->VALOR_FRETE/nItem
			
			MaFisAlt("NF_FRETE",nfreteIt)
			MaFisWrite(1)
			
			ST_AUX := MaFisRet(,"NF_VALSOL")
			
			DbSelectArea("SF4")
			SF4->(DbSetOrder(1))
			If SF4->(DbSeek(xFilial("SF4")+TRB_AC0029_3->TES))
				If SF4->F4_ART274 $ "2/ "
					nTOT_ST += ST_AUX
				EndIf
			EndIf
			SF4->( DbCloseArea() )
			
			VAL_PRD 	 += TRB_AC0029_3->VALOR //MaFisRet(,"NF_VALMERC")
			VAL_IPI 	 += MaFisRet(,"NF_VALIPI")
			VAL_TOT 	 += MaFisRet(,"NF_TOTAL")
			VAL_ST  	 += ST_AUX//MaFisRet(,"NF_VALSOL")
			VAL_SUF		 += MaFisRet(,"NF_DESCZF")
			//VAL_DESCONTO += MaFisRet(,"NF_DESCONTO")
			//VAL_FRETE    += MaFisRet(,"NF_FRETE")
			//VAL_DESPESA  += MaFisRet(,"NF_DESPESA")
			cItemAux := TRB_AC0029_3->ITEM
		EndIf
		TRB_AC0029_3->(DBSkip())
	ENDDO
	
	aRelato.oPrn:Say(cCol,0100,"Subtotal ", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0400,"Frete ", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0600,"Despesa ", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0900,"IPI ", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1100,"S.T. ", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1300,"Desconto ", aRelato.oFont4)
	//aRelato.oPrn:Say(cCol,2500,"Desc. Suframa", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,2000,"Total Geral ", aRelato.oFont4)
	cCol += 50
	
	nTOTAL := VAL_PRD + VAL_FRETE + VAL_DESPESA  + VAL_IPI + nTOT_ST
	// VAL_IPI += VAL_FRETE * (5/100)  //Por Henrique Pereira. Calculo correto de IPI Total dos produtos + Valor do frete * alํquota de IPI. A variแvel "nVarIipi" contem a alํquota.
	aRelato.oPrn:Say(cCol,0100,Transform(VAL_PRD,     "@E 999,999.99"), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0380,Transform(VAL_FRETE,   "@E 999,999.99"), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0600,Transform(VAL_DESPESA, "@E 999,999.99"), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0850,Transform(VAL_IPI,     "@E 999,999.99"), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1050,Transform(VAL_ST,      "@E 999,999.99"), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1300,Transform(VAL_DESCONTO,"@E 999,999.99"), aRelato.oFont3)
	//aRelato.oPrn:Say(cCol,2500,Transform(VAL_SUF,"@E 999,999.99"), aRelato.oFont3)
	aRelato.oPrn:Say(cCol,2000,Transform(nTOTAL,      "@E 999,999.99"), aRelato.oFont3)
	
	
	//TOTAL ITENS DO PEDIDO
	If SELECT ("TRB_AC0029_4") > 0
		dbSelectArea("TRB_AC0029_4")
		dbCloseArea("TRB_AC0029_4")
	EndIf
	
	cQuery := " SELECT "
	cQuery += "   SUM(C6_QTDVEN) QUANTIDADE "
	cQuery += " FROM "
	cQuery += RetSqlName("SC6") + " I_ORC "
	cQuery += " WHERE 1 = 1 "
	cQuery += "   AND C6_NUM = '" + TRB_AC0029_1->PEDIDO+ "' " //PEGAR O NUMERO DO ORCAMENTO
	cQuery += "   AND I_ORC.D_E_L_E_T_ = '' "
	cQuery += "   AND C6_FILIAL = '" + xFilial("SC6") + "'"
	cQuery += " ORDER BY 1 "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB_AC0029_4',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
	
	cCol += 50
	//fVerPag(lRod)
	aRelato.oPrn:Say(cCol,0100,"Quant. Itens:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0450,cValToChar(nItemPed), aRelato.oFont3)
	
	aRelato.oPrn:Say(cCol,0700,"Quant. Produtos:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1000,cValToChar(TRB_AC0029_4->QUANTIDADE), aRelato.oFont3)
	
	aRelato.oPrn:Say(cCol,1250,"ICMS", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1400,cValToChar(nPerRet), aRelato.oFont3)
	
	cCol:=IIF(cCol+100 > TOTLINPAG, TOTLINPAG+1, cCol)
	fVerPag(lRod, 100)
	
	cCol += 50
	aRelato.oPrn:LINE(cCol,0080,cCol,2500)
	
	fVerPag(lRod)
	cCol += 30
	aRelato.oPrn:Say(cCol,0100,"Condi็ใo Pagamento:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0550,TRB_AC0029_1->COND_PAGTO, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,0800,"Frete", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,1000,/*SC5->C5_TPFRETE*/TRB_AC0029_1->TIPO_FRETE, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1450,"No. Ped. Cliente:", aRelato.oFont4)
	//aRelato.oPrn:Say(cCol,2300,TRB_AC0029_1->PEDCLI, aRelato.oFont3)
	aRelato.oPrn:Say(cCol,1800,TRB_AC0029_1->PEDCLI, aRelato.oFont3)
	cCol += 50
	aRelato.oPrn:LINE(cCol,0080,cCol,2500)
	
	cCol:=IIf( cCol+300 > TOTLINPAG, TOTLINPAG+1, cCol)
	fVerPag(lRod)
	
	cCol += 30
	aRelato.oPrn:Say(cCol,0100,"Informa็๕es de Entrega", aRelato.oFont4)
	
	cCol += 50
	fVerPag(lRod)
	aRelato.oPrn:Say(cCol,0100,"Transportadora:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0410,TRB_AC0029_1->TRANSPORTADORA, aRelato.oFont3)
	
	cCol += 50
	fVerPag(lRod)
	aRelato.oPrn:Say(cCol,0100,"Endere็o:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0410,TRB_AC0029_1->END_TRANSP, aRelato.oFont3)
	
	cCol += 50
	fVerPag(lRod)
	aRelato.oPrn:Say(cCol,0100,"CNPJ:", aRelato.oFont4)
	aRelato.oPrn:Say(cCol,0410,Transform( TRB_AC0029_1->END_CGC, PesqPict("SA4","A4_CGC", TamSx3("A4_CGC")[1] ) ), aRelato.oFont3)
	
	cCol += 50
	aRelato.oPrn:LINE(cCol,0080,cCol,2500)
	
	// Verifica se atingiu o top da pagina
	cCol:=IIf( cCol+200 > TOTLINPAG, TOTLINPAG+1, cCol)
	
	DbSelectArea("SC5")
	If SC5->( DbSeek(xFilial("SC5")+TRB_AC0029_1->PEDIDO) )
		OBS2 := SC5->C5_OBSERVP
		OBS1 := SC5->C5_OBSNFE
	EndIf
	
	cColu := cCol
	
	//USANDO O MEMOLINE PARA IMPRESSAO
	If !EMPTY(OBS1)
		
		cJ  := 165	//TAMANHO DA QUEBRA
		t_linhas := mlcount(AllTrim(OBS1),cJ,3,.t.)
		
		cCol:=Iif( cCol+100+t_linhas > TOTLINPAG, TOTLINPAG+1, cCol)
		fVerPag(lRod)
		cCol += 30
		
		aRelato.oPrn:Say(cCol,0100,"Observa็๕es DANFE:", aRelato.oFont4)
		cCol += 60
		cColu := cCol
		
		
		For nPos := 1 To t_linhas
			
			aRelato.oPrn:Say(cColu,0100,memoline( OBS1, cJ, nPos , 3, .t.) , aRelato.oFont7) //SINTAXE = MEMOLINE(CAMPO,TAMANHO_QUEBRA,LINHA_IMPRESSA,3,.T.)
			
			cColu += 50
			cCol  := cColu
			fVerPag(lRod)
		Next
	EndIf
	
	// Verifica se atingiu o top da pagina
	cCol:=IIf( cCol+200 > TOTLINPAG, TOTLINPAG+1, cCol)
	//USANDO O MEMOLINE PARA IMPRESSAO
	If !EMPTY(OBS2)
		cCol += 30
		fVerPag(lRod)
		aRelato.oPrn:Say(cCol,0100,"Observa็๕es Pedido:", aRelato.oFont4)
		
		cCol += 60
		cColu := cCol
		
		cJ  := 165	//TAMANHO DA QUEBRA
		//	cJ  := 165	//TAMANHO DA QUEBRA
		
		t_linhas := mlcount(AllTrim(OBS2),cJ,3,.t.)
		
		For nPos := 1 To t_linhas
			//	for f:= 1 to t_linhas
			aRelato.oPrn:Say( cColu, 0100, memoline( OBS2, cJ, nPos, 3, .t.),  aRelato.oFont7) //SINTAXE = MEMOLINE(CAMPO,TAMANHO_QUEBRA,LINHA_IMPRESSA,3,.T.)
			
			cColu += 50
			cCol  := cColu
			fVerPag(lRod)
		Next
	Endif
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec     บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cabecario do Pedido de Venda                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTFR0001                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure Cabec(lRod)

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
			cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SCJ") == "99"//EMPRESA TESTE
			cLogo  := '\system\logo_daisa.jpg'
	ENDCASE
	
	aRelato.oPrn:SayBitmap( 0080, 0100,alltrim(cLogo),0480,0200)
	
	DbSelectArea("SM0")
	aRelato.oPrn:Say(0080,0810,SM0->M0_NOMECOM, aRelato.oFont9)
	
	aRelato.oPrn:Say(0100,1800,"Pedido de Venda Nบ:", aRelato.oFont4)
	aRelato.oPrn:Say(0100,2150,TRB_AC0029_1->PEDIDO, aRelato.oFont4)                  	  	//NUMERO PEDIDO
	/*
	aRelato.oPrn:Say(0200,0710,Alltrim(SM0->M0_ENDENT) + ' - BAIRRO: ' + Alltrim(SM0->M0_BAIRENT) + ' - CIDADE: ' + Alltrim(SM0->M0_CIDENT) + ' - CEP: ' + Alltrim(SM0->M0_CEPENT), aRelato.oFont7)
	*/
	aRelato.oPrn:Say(0200,1800,"Data Pedido:", aRelato.oFont4)
	aRelato.oPrn:Say(0200,2150,TRB_AC0029_1->EMISSAO, aRelato.oFont3)                    	//DATA EMISSAO
	
	//aRelato.oPrn:Say(0250,0710,'ESTADO: ' + Alltrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + SM0->M0_TEL + ' - FAX: ' + SM0->M0_FAX, aRelato.oFont7)
	//aRelato.oPrn:Say(0300,0710,'CNPJ - ' + Transform(SM0->M0_CGC,"@r 99.999.999/9999-99") + ' - INSCR. ESTADUAL: ' + Transform(SM0->M0_INSC,"@r 999.999.999.999"), aRelato.oFont7)
	
	//aRelato.oPrn:Say(0300,2500,"Previsใo Entrega:", aRelato.oFont4)
	//aRelato.oPrn:Say(0300,2850,TRB_AC0029_1->PREVISAO, aRelato.oFont3)                    				//PREVISAO ENTREGA
	
	//aRelato.nPagina += 1
	//aRelato.oPrn:Say(0200,2000,"Pagina: " + AllTrim(Str(aRelato.nPagina)), aRelato.oFont7) 	//NUMERO PAGINA
	
	aRelato.oPrn:Line(0290,0080,0290,2500)
	
	//CABECALHO ITENS DO ORCAMENTO
	If lRod = .F.
		
		cCol := cCol+5
		
		aRelato.oPrn:Say(cCol,0100,"Item", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,0300,"C๓digo", aRelato.oFont8)
		//aRelato.oPrn:Say(cCol,0600,"Descri็ใo", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*1400*/0700,"Entrega", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*1650*/0965,"Qtd.", aRelato.oFont8)
		//aRelato.oPrn:Say(cCol,1800,"Apr.", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*1970*/1100,"Val. Unit.", aRelato.oFont8)
		//aRelato.oPrn:Say(cCol,/*2200*/0900,"% ICMS", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*2200*/1400,"TES", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*2600*/1550,"Val. Total", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*2850*/1800,"% IPI", aRelato.oFont8)
		aRelato.oPrn:Say(cCol,/*3000*/2000,"Val. IPI", aRelato.oFont8)
		cCol += 50
		aRelato.oPrn:Line(cCol,0080,cCol,2500)
		nLin1 := cCol
		
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfVerPag   บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para analise de paginas                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTFR0001                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fVerPag(lRod)

Local lRet := .F.

If ( cCol >= TOTLINPAG )
	lRet := .T.
	aRelato.oPrn :EndPage()
	cCol  := 0370
	cColu := 0370
	aRelato.oPrn :StartPage()
	Cabec(lRod)
EndIf
Return (lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณ Edilson Nascimento บ Data ณ  10/07/13   บฑฑ
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

	aAdd(aRegs,{cPerg, "01","Nบ Pedido de  ?" ,"Nบ Pedido de  ?" ,"Nบ Pedido de  ?" ,"MV_CHA" ,"C",06,0,0,"G","" ,"MV_PAR01" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg, "02","Nบ Pedido ate ?" ,"Nบ Pedido ate ?" ,"Nบ Pedido ate ?" ,"MC_CHA" ,"C",06,0,0,"G","" ,"MV_PAR02" ,""         ,""        ,""         ,"" ,"",""       ,""      ,""      ,"","","" ,"","","","","","","","","","","","","",""})

	ValidPerg(aRegs,cPerg)
	
Return


