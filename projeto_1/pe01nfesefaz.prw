#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PE01NFESEFAZ³ Autor ³ Edilson Nascimento  ³ Data ³23.07.2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ponto de entrada para manipulação dos dados do produto      ³±±
±±³          ³como mensagens adicionais, destinatarios e dados da nota.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Array com os dados manipulados.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³aProd := PARAMIXB[1] := cMensCli                            ³±±
±±³          ³         PARAMIXB[2] := cMensFis                            ³±±
±±³          ³         PARAMIXB[3] := aDest                               ³±±
±±³          ³         PARAMIXB[4] := aNota                               ³±±
±±³          ³         PARAMIXB[5] := aInfoItem                           ³±±
±±³          ³         PARAMIXB[6] := aDupl                               ³±±
±±³          ³         PARAMIXB[7] := aTransp                             ³±±
±±³          ³         PARAMIXB[8] := aEntrega                            ³±±
±±³          ³         PARAMIXB[9] := aRetirada                           ³±±
±±³          ³         PARAMIXB[10]:= aVeiculo                            ³±±
±±³          ³         PARAMIXB[11]:= aReboque                            ³±±
±±³          ³         PARAMIXB[12]:= Tipo da NF                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
USER FUNCTION PE01NFESEFAZ

Local cQuery
Local cDaisa_CFOP := {}
Local aRetValue   := ACLone( ParamIXB )

	// TRATAMENTO PARA PEGAR O VALOR TOTAL DOS IMPOSTOS POR CFOP
	cQuery := " SELECT "
	cQuery += "   D2_CF CFOP, "
	cQuery += "   SUM(D2_BASEICM) BASE_ICMS, "
	cQuery += "   SUM(D2_VALICM) VALOR_ICMS, "
	cQuery += "   SUM(D2_VALIPI) VALOR_IPI, "
	cQuery += "   SUM(D2_TOTAL) TOTAL_PRODUTO "
	cQuery += " FROM "
	cQuery += RetSqlName("SD2") + " SD2 "
	cQuery += " WHERE "
	cQuery += "   D2_DOC = '" + ALLTRIM(SF2->F2_DOC) + "' "
	cQuery += "   AND D2_SERIE = '" + ALLTRIM(SF2->F2_SERIE) + "' "
	cQuery += "   AND SD2.D_E_L_E_T_ = '' "
	cQuery += " GROUP BY "
	cQuery += "   D2_CF "
	cQuery += " ORDER BY "
	cQuery += "   D2_CF "
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB_PE01NFESEFAZ',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
	
	While TRB_PE01NFESEFAZ->( .NOT. Eof())
		If ASCAN( cDaisa_CFOP, ALLTRIM( TRB_PE01NFESEFAZ->CFOP ) ) == 0
		    AADD( cDaisa_CFOP, ALLTRIM( TRB_PE01NFESEFAZ->CFOP ) )
			aRetValue[2] += CHR(13)+CHR(10)
			aRetValue[2] += " Total CFOP: " + ALLTRIM( TRB_PE01NFESEFAZ->CFOP )
			aRetValue[2] += " B.Calc.ICMS: " + ALLTRIM( TRANSFORM( TRB_PE01NFESEFAZ->BASE_ICMS, PesqPict("SD2","D2_BASEICM", TamSx3("D2_BASEICM")[1] ) ) )
			aRetValue[2] += " ICMS: " + ALLTRIM( TRANSFORM( TRB_PE01NFESEFAZ->VALOR_ICMS, PesqPict("SD2","D2_VALICM", TamSx3("D2_VALICM")[1] ) ) )
			aRetValue[2] += " IPI: " + ALLTRIM( TRANSFORM( TRB_PE01NFESEFAZ->VALOR_IPI, PesqPict("SD2","D2_VALIPI", TamSx3("D2_VALIPI")[1] ) ) )
			aRetValue[2] += " Total Produto: " + ALLTRIM( TRANSFORM( TRB_PE01NFESEFAZ->TOTAL_PRODUTO, PesqPict("SD2","D2_TOTAL", TamSx3("D2_TOTAL")[1] ) ) )
		EndIf
		TRB_PE01NFESEFAZ->(dbSkip())
	EndDo
	TRB_PE01NFESEFAZ->( DBCloseArea() )
	
	//INCLUSAO DA MENSAGEM NUMERO DO PEDIDO DAISA
	aRetValue[2] += CHR(13)+CHR(10)
	aRetValue[2] += " Pedido DAISA: "+ ALLTRIM(SC5->C5_NUM)
	
	//INCLUSAO DA MENSAGEM NUMERO DO PEDIDO CLIENTE
	If .NOT. EMPTY( SC5->C5_PEDCLI )
		aRetValue[2] += CHR(13)+CHR(10)
		aRetValue[2] += " Pedido Cliente: "+ ALLTRIM(SC5->C5_PEDCLI)
	EndIf
	
	//INCLUSAO DA MENSAGEM OBSERVACAO NOTA FISCAL
	If .NOT. EMPTY(SC5->C5_OBSNFE)
		aRetValue[2] += CHR(13)+CHR(10)
		aRetValue[2] += ALLTRIM(SC5->C5_OBSNFE)
	EndIf
	
	// IMPRESSAO DO CAMPO FORMULA DO CADASTRO DE CLIENTE
	If .Not. Empty( SA1->A1_FORMULA )
		aArea := GetArea()
		DBSelectArea("SM4")
		SM4->( DBSetOrder(1) )
		IF SM4->( DBSeek( xFilial() + SA1->A1_FORMULA ) )
			aRetValue[2] += CHR(13)+CHR(10)
			aRetValue[2] += SM4->M4_FORMULA
		EndIf
		RestArea( aArea )
	EndIf
	
	// IMPRESSAO DO CODIGO DA SUFRAMA
	If .Not. Empty( SA1->A1_SUFRAMA )
		aRetValue[2] += CHR(13)+CHR(10)
		aRetValue[2] += "SUFRAMA :"
		aRetValue[2] += SA1->A1_SUFRAMA
	EndIf
				
RETURN( aRetValue )