#INCLUDE "PROTHEUS.CH"
#INCLUDE "PRT0088.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPRT0088   บAutor  ณMarcos Santos       บ Data ณ  06-09-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Minuta de Despacho                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PRT0088()

PRIVATE aRelato := StoreRelato()

	//grupo de perguntas
	AjustaSX1( "MV_PRT0088" )
	If Pergunte( "MV_PRT0088", .T. )
		
		//Variaveis tipo Private padrao de todos os relatorios
		aRelato.oPrn := TMSPrinter():New( "PRT0088 - Minuta de Despacho/Protocolo de Entrega " )
		
		If aRelato.oPrn:Setup()
			
			aRelato.oPrn:SetPortrait()
			
			RptStatus({|lEnd| Processo() },"PRT0088 - IMPRIMINDO ...")
			
			aRelato.oPrn:Preview()
			
			aRelato.oPrn:End()
			
			Ms_Flush()
			
			TRB_PRT0088_1->( DBCloseArea() )
			TRB_PRT0088_2->( DBCloseArea() )
			
		EndIf
	ElseIf VAL(MV_PAR02) <= 0
		Alert("Preencha o Campo 'Nota at้' !!")
	ElseIf VAL(MV_PAR01) > VAL(MV_PAR02)
		Alert("Valor de 'Nota at้' deve ser Superior เ 'Nota de' !!")
	EndIf
	
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณProcesso  บAutor  ณMarcos Santos       บ Data ณ  06-09-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Seleciona os registro para impressao.                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure Processo()

Local cQuery

PRIVATE nLinha       := 0

	//fa็o algumas consistencias
	If empty(MV_PAR01) .And. !empty(MV_PAR02)
		MV_PAR01 := MV_PAR02
	ElseIf !empty(MV_PAR01) .And. empty(MV_PAR02)
		MV_PAR02 := MV_PAR01
	Endif
	
	//executo a query com os filtros do grupo de pergunta
	cQuery := "SELECT SF2.F2_DOC,SF2.F2_SERIE,SF2.F2_CLIENTE,SF2.F2_VOLUME1,SF2.F2_PBRUTO,SF2.F2_TRANSP, SF2.F2_TIPO, "
	cQuery += "       SA1.A1_ENDENT,SA1.A1_NOME,SA1.A1_BAIRROE,SA1.A1_MUNE,SA1.A1_ESTE,SA1.A1_CEPE,SA1.A1_DDD,SA1.A1_TEL, "
	cQuery += "       SA1.A1_END,SA1.A1_BAIRRO,SA1.A1_MUN,SA1.A1_EST,SA1.A1_CEP "
	cQuery += "  FROM "
	cQuery += RetSqlName("SF2") + " SF2 "
	cQuery += "  JOIN "
	cQuery += RetSqlName("SA1") + " SA1 "
//    cQuery += "    ON SF2.F2_FILIAL = SA1.A1_FILIAL "
	cQuery += "    ON SF2.F2_CLIENTE = SA1.A1_COD AND SF2.F2_LOJA=SA1.A1_LOJA AND SA1.D_E_L_E_T_ = ''"
	cQuery += " WHERE SF2.F2_FILIAL = '" + xFilial("SF2") + "' AND"
	cQuery += "       SF2.D_E_L_E_T_ = '' AND"
	cQuery += "       SF2.F2_DOC BETWEEN '" + AllTrim( MV_PAR01 ) + "' AND '" + AllTrim( MV_PAR02 ) + "'
	cQuery += " ORDER BY SF2.F2_DOC "
	
	If Select("TRB_PRT0088_1") > 0
		TMP1->(DBCloseArea())
	EndIf
	
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB_PRT0088_1",.F.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	aRelato.nPagina := 1
	
	TRB_PRT0088_1->(DBGotop())
	While TRB_PRT0088_1->( .Not. Eof() )
		Imprime()
		
		TRB_PRT0088_1->(DBSkip())
	EndDo
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImprime   บAutor  ณMarcos Santos       บ Data ณ  06-09-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza a impressao da Minuta.                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure Imprime()

Local cQuery
Local cVrAux       := nil
Local cVrAux1      := nil
Local cVrAux2      := nil
Local cVrAux3      := nil

// defini็ใo das margens. Esse relatorio precisa ser impresso em A3 e em A4.
Local nVertical
Local nHorizontal
Local nFimV      := 40
Local nFimH      := 70

	DEFINE FONT aRelato.oFont16  NAME "Arial" SIZE 13,13 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont16N NAME "Arial" SIZE 13,13 OF aRelato.oPrn
	DEFINE FONT aRelato.oFont20N NAME "Arial" SIZE 20,20 OF aRelato.oPrn BOLD

	//Inicializacao da pagina do objeto grafico
	If aRelato.nPagina % 2 > 0
		aRelato.oPrn:StartPage()
		nLinha := 80
	Else
		nLinha += 100
	Endif
	
	nHorizontal := aRelato.oPrn:nHorzRes()
	nHorizontal *= (300/aRelato.oPrn:nLogPixelX())   
	nVertical   := aRelato.oPrn:nVertRes()
	nVertical   *= (300/aRelato.oPrn:nLogPixelY())
	nFimV       := nVertical-nFimV
	nFimH       := nHorizontal-nFimH

	//Imprime o Logo no Relatorio
	DO CASE
		Case cFilAnt == "01"//DAISA MATRIZ
			cLogo  := '\system\logo_daisa.jpg'
		Case cFilAnt == "02"//FUNDICAO
			cLogo  := '\system\logo_fundicao.jpg'
		Case cFilAnt == "03"//DAIBRAS
			cLogo  := '\system\logo_daibras.jpg'
		Case cFilAnt == "04"//DAISA INDUSTRIAL
			cLogo  := '\system\logo_daisa.jpg'
		Case cFilAnt == "05"//DAISA COMERCIO
			cLogo  := '\system\logo_daisa.jpg'
		Case cFilAnt == "99"//EMPRESA TESTE
			cLogo  := '\system\logo_daisa.jpg'
	ENDCASE	
	aRelato.oPrn:SayBitmap( nLinha, 0050, ALLTRIM( cLogo ), 0480, 0200 )

	//Dados da Empresa
    DBSelectArea("SM0")
    SM0->(DBSetOrder(1))
    SM0->(DBSeek(cEmpAnt + cFilAnt) )
    	
	aRelato.oPrn:SAY( nLinha, 0600, AllTrim(SM0->M0_NOME), aRelato.oFont20N)
	
	nLinha += 80
	aRelato.oPrn:SAY( nLinha, 0700, AllTrim(SM0->M0_CIDENT), aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1300, AllTrim(SM0->M0_ESTENT), aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1500, TRANSFORM( SM0->M0_CEPENT, "@r 99999-999"), aRelato.oFont16)
	
	nLinha += 80
	aRelato.oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 20
	aRelato.oPrn:SAY(nLinha,0550,"Minuta de Despacho/Protocolo de Entrega", aRelato.oFont20N)
	xNome:=''
	nLinha += 150
	
	DbSelectArea('SA4')
	SA4->( DbSetOrder(1) )
	If SA4->( Dbseek( xfilial('SA4') + TRB_PRT0088_1->F2_TRANSP ) )
		If Alltrim(SA4->A4_NOME) == "PROPRIO"//IF ALLTRIM(TRB_PRT0088_1->F2_TRANSP) = ''

			//IF TRB_PRT0088_1->F2_TIPO <> 'B'
			aRelato.oPrn:SAY( nLinha, 0080, "ENTREGAMOS A:", aRelato.oFont16N )
			aRelato.oPrn:SAY( nLinha, 0490, TRANSFORM( TRB_PRT0088_1->A1_NOME, PesqPict("SA1","A1_NOME", TamSx3("A1_NOME")[1] ) ), aRelato.oFont16N )

			xNome:=AllTrim(TRB_PRT0088_1->A1_NOME)

			//endere็o
			nLinha += 100
			If !empty(TRB_PRT0088_1->A1_ENDENT)
				cVrAux := AllTrim(TRB_PRT0088_1->A1_ENDENT)
			Else
				cVrAux := AllTrim(TRB_PRT0088_1->A1_END)
			Endif
			aRelato.oPrn:SAY( nLinha, 0080, "Endere็o: ", aRelato.oFont16)
			aRelato.oPrn:SAY( nLinha, 0300, TRANSFORM( cVrAux, PesqPict("SA1","A1_END", TamSx3("A1_END")[1] ) ), aRelato.oFont16 )
			
			//bairro,municipio,estado,cep
			nLinha += 60
			If .Not. Empty( TRB_PRT0088_1->A1_BAIRROE )
				cVrAux := AllTrim( TRB_PRT0088_1->A1_BAIRROE )
			Else
				cVrAux := AllTrim( TRB_PRT0088_1->A1_BAIRRO )
			Endif
			
			If .Not. Empty( TRB_PRT0088_1->A1_MUNE )
				cVrAux1 := AllTrim( TRB_PRT0088_1->A1_MUNE )
			Else
				cVrAux1 := AllTrim( TRB_PRT0088_1->A1_MUN )
			Endif
			
			If .Not. Empty( TRB_PRT0088_1->A1_ESTE )
				cVrAux2 := AllTrim( TRB_PRT0088_1->A1_ESTE)
			Else
				cVrAux2 := AllTrim( TRB_PRT0088_1->A1_EST)
			Endif
			
			If .Not. Empty( TRB_PRT0088_1->A1_CEPE )
				cVrAux3 := Transform( TRB_PRT0088_1->A1_CEPE, "@r 99999-999" )
			Else
				cVrAux3 := Transform( TRB_PRT0088_1->A1_CEP,"@r 99999-999")
			Endif
			aRelato.oPrn:SAY( nLinha, 0080, "Bairro: " +cVrAux + "  -  Municํpio: " + cVrAux1 + " - UF: " + cVrAux2 + "   - CEP: " + cVrAux3, aRelato.oFont16)
			
			//telefone
			nLinha += 60
			If .Not. Empty( TRB_PRT0088_1->A1_DDD )
				aRelato.oPrn:SAY( nLinha, 0080, "Fone: (" + AllTrim(TRB_PRT0088_1->A1_DDD) + ") " + Transform( TRB_PRT0088_1->A1_TEL,"@r 9999-9999"), aRelato.oFont16)
			Else
				aRelato.oPrn:SAY( nLinha, 0080, "Fone: " + Transform( TRB_PRT0088_1->A1_TEL, "@r 9999-9999"), aRelato.oFont16)
			Endif
			
		/*ELSE
			DBSELECTAREA('SA2')
			DBSETORDER(1)
			
			dbseek(xfilial('SA2')+TRB_PRT0088_1->F2_CLIENTE)
			
			aRelato.oPrn:SAY(nLinha,0080,"ENTREGAMOS A: "+ SA2->A2_NOME, aRelato.oFont16N )
			xNome:=AllTrim(SA2->A2_NOME)
			
			//endere็o
			nLinha += 100
			cVrAux := AllTrim(SA2->A2_END)
			aRelato.oPrn:SAY(nLinha,0080,"Endere็o: " +cVrAux, aRelato.oFont16)
			
			//bairro,municipio,estado,cep
			nLinha += 60
			cVrAux := AllTrim(SA2->A2_BAIRRO)
			
			cVrAux1 := AllTrim(SA2->A2_MUN)
			
			cVrAux2 := AllTrim(SA2->A2_EST)
			
			cVrAux3 := Transform(SA2->A2_CEP,"@r 99999-999")
			
			aRelato.oPrn:SAY(nLinha,0080,"Bairro: " +cVrAux + "  -  Municํpio: " + cVrAux1 + " - UF: " + cVrAux2 + "   - CEP: " + cVrAux3, aRelato.oFont16)
			
			//telefone
			nLinha += 60
			aRelato.oPrn:SAY(nLinha,0080,"Fone: " + Transform(SA2->A2_TEL,"@r 9999-9999"), aRelato.oFont16)
			DBSELECTAREA('TRB_PRT0088_1')
			nLinha += 100
			aRelato.oPrn:SAY(nLinha,0080,"Cliente: ", aRelato.oFont16)
			aRelato.oPrn:SAY(nLinha,0300,AllTrim(SA2->A2_NOME), aRelato.oFont16N )
		ENDIF*/

		ELSE
			
			aRelato.oPrn:SAY( nLinha, 0080, "ENTREGAMOS A:", aRelato.oFont16N )
			aRelato.oPrn:SAY( nLinha, 0490, TRANSFORM( SA4->A4_NOME, PesqPict("SA4","A4_NOME", TamSx3("A4_NOME")[1] ) ), aRelato.oFont16N )
			xNome := AllTrim(SA4->A4_NOME)

			//endere็o
			nLinha += 100
			cVrAux := AllTrim(SA4->A4_END)
			aRelato.oPrn:SAY( nLinha, 0080, "Endereco:", aRelato.oFont16)
			aRelato.oPrn:SAY( nLinha, 0300, TRANSFORM( cVrAux, PesqPict("SA4","A4_END", TamSx3("A4_END")[1] ) ), aRelato.oFont16)
			
			//bairro,municipio,estado,cep
			nLinha += 60
			cVrAux := AllTrim( SA4->A4_BAIRRO )
			
			cVrAux1 := AllTrim( SA4->A4_MUN )
			
			cVrAux2 := AllTrim( SA4->A4_EST )
			
			cVrAux3 := Transform(SA4->A4_CEP,"@r 99999-999")
			
			aRelato.oPrn:SAY( nLinha, 0080, "Bairro: " +cVrAux + "  -  Municํpio: " + cVrAux1 + " - UF: " + cVrAux2 + "   - CEP: " + cVrAux3, aRelato.oFont16)
			
			//telefone
			nLinha += 60
			aRelato.oPrn:SAY( nLinha, 0080, "Fone: " + Transform(SA4->A4_TEL,"@r 9999-9999"), aRelato.oFont16)
			
		ENDIF
	Else
		aRelato.oPrn:SAY( nLinha, 0080, "ENTREGAMOS A: "+"TRANSP. NAO ENCONTRADA, CONTATE O ADMINISTRADOR DO SISTEMA", aRelato.oFont16N )
		xNome:="TRANSP. NAO ENCONTRADA, CONTATE O ADMINISTRADOR DO SISTEMA"
		//endere็o
		nLinha += 100
		cVrAux := ""
		aRelato.oPrn:SAY(nLinha,0080,"Endere็o: " +cVrAux, aRelato.oFont16)
		
		//bairro,municipio,estado,cep
		nLinha += 60
		cVrAux := ""
		
		cVrAux1 := ""
		
		cVrAux2 := ""
		
		cVrAux3 := Transform("","@r 99999-999")
		
		aRelato.oPrn:SAY(nLinha,0080,"Bairro: " +cVrAux + "  -  Municํpio: " + cVrAux1 + " - UF: " + cVrAux2 + "   - CEP: " + cVrAux3, aRelato.oFont16)
		
		//telefone
		nLinha += 60
		aRelato.oPrn:SAY(nLinha,0080,"Fone: " + Transform("","@r 9999-9999"), aRelato.oFont16)
		
	EndIf
	
	DBSelectArea('TRB_PRT0088_1')
	nLinha += 100
	aRelato.oPrn:SAY( nLinha, 0080, "Cliente: ", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0250, TRANSFORM( TRB_PRT0088_1->A1_NOME, PesqPict("SA1","A1_NOME", TamSx3("A1_NOME")[1] ) ), aRelato.oFont16N)
	
	nLinha += 60
	aRelato.oPrn:SAY( nLinha, 0080, "Volume:", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0200, TRANSFORM( TRB_PRT0088_1->F2_VOLUME1, PesqPict("SF2","F2_VOLUME1", TamSx3("F2_VOLUME1")[1] ) ), aRelato.oFont16)	
	aRelato.oPrn:SAY( nLinha, 1100, "Peso:", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1200, TRANSFORM( TRB_PRT0088_1->F2_PBRUTO, PesqPict("SF2","F2_PBRUTO", TamSx3("F2_PBRUTO")[1] ) ), aRelato.oFont16)
	
	//numero do pedido cliente e pedido daisa
	cQuery := "SELECT DISTINCT SD2.D2_PEDIDO,SC6.C6_PEDCLI "
	cQuery += " FROM "
	cQuery += RetSqlName("SD2")+" SD2 "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SC6")+" SC6 "
	cQuery += " ON SD2.D2_FILIAL = SC6.C6_FILIAL AND"
	cQuery += "    SD2.D2_DOC = SC6.C6_NOTA AND"
	cQuery += "    SD2.D2_SERIE = SC6.C6_SERIE AND"
	cQuery += "    SC6.D_E_L_E_T_ = ''"
	cQuery += " WHERE SD2.D2_FILIAL = '" + xFilial("SD2") + "' AND"
	cQuery += "       SD2.D_E_L_E_T_ = '' AND"
	cQuery += "       SD2.D2_DOC = '" + AllTrim(TRB_PRT0088_1->F2_DOC) +"' AND"
	cQuery += "       SD2.D2_SERIE = '" + AllTrim(TRB_PRT0088_1->F2_SERIE) + "'
	
	If Select("TRB_PRT0088_2") > 0
		TRB_PRT0088_2->(DbCloseArea())
	EndIf
	
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB_PRT0088_2",.F.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	nLinha += 60
	aRelato.oPrn:SAY( nLinha, 0080, "Referente a NF:", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0430, TRANSFORM( TRB_PRT0088_1->F2_DOC, PesqPict("SF2","F2_DOC", TamSx3("F2_DOC")[1] ) ), aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0700, "Serie: ", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0830, TRANSFORM( TRB_PRT0088_1->F2_SERIE, PesqPict("SF2","F2_SERIE", TamSx3("F2_SERIE")[1] ) ), aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1100, "- Referente  ao  Seu  Pedido  N:", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1780, TRANSFORM( TRB_PRT0088_2->C6_PEDCLI, PesqPict("SC6","C6_PEDCLI", TamSx3("C6_PEDCLI")[1] ) ), aRelato.oFont16)
	
	//Agrupando os Pedidos
	cPedido := ""
	TRB_PRT0088_2->( DBGoTop () )
	While TRB_PRT0088_2->( .Not. Eof() )
		cPedido += Iif( Empty( cPedido ), "", "/" )
		cPedido += TRB_PRT0088_2->D2_PEDIDO
		TRB_PRT0088_2->( DBSkip() )
	EndDo
	
	nLinha += 60
	aRelato.oPrn:SAY( nLinha, 1100, "- Referente ao Pedido DAISA N:", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1780, TRANSFORM( cPedido, PesqPict("SD2","D2_PEDIDO", TamSx3("D2_PEDIDO")[1] ) ), aRelato.oFont16)
	
	//----------------------------------------------------------------------------
	
	nLinha += 120
	aRelato.oPrn:SAY( nLinha, 0080, "Entrega (      )", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0400, "Coleta (      )", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 0700, "Disponivel desde:  ___/___/_____", aRelato.oFont16)
	aRelato.oPrn:SAY( nLinha, 1420, "OBS:  ________________________________", aRelato.oFont16)
	
	//----------------------------------------------------------------------------
	
	nLinha += 150
	aRelato.oPrn:SAY(nLinha,0080,"N๚mero da Coleta:________________________" + Space(20) + "Data:_____/_____/________", aRelato.oFont16)
	
	nLinha += 100
	aRelato.oPrn:SAY(nLinha,0080,"______________________________" + Space(30) + "_____________________________", aRelato.oFont16)
	
	nLinha += 60
	aRelato.oPrn:SAY(nLinha,0200,"Transportadora" + Space(80) + "Cliente", aRelato.oFont16)
	
	nLinha += 150
	aRelato.oPrn:Line(nLinha,0080,nLinha,2300)
	
	//fim do relatorio
	If aRelato.nPagina % 2 = 0
		aRelato.oPrn:EndPage()
	Endif
	
	aRelato.nPagina += 1
	
Return

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

	aAdd( aRegs,{cPerg, "01","Nota de: "," "," ",  "mv_ch1","C",9,0,0 ,"G","u_Validacao(1)","SF2","","","MV_PAR01","","","","","","","","","","","","",""," "," "," ",{"Nota de"},{"Nota de"},{"Nota de"}})
	aAdd( aRegs,{cPerg, "02","Nota ate: "," "," ", "mv_ch2","C",9,0,0 ,"G","u_Validacao(2)","SF2","","","MV_PAR02","","","","","","","","","","","","",""," "," "," ",{"Nota ate"},{"Nota ate"},{"Nota ate"}})

	ValidPerg(aRegs,cPerg)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidacao บAutor  ณ Vitor Daniel       บ Data ณ  07/05/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunte da tela                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ faturamento/Orcamento                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Validacao(i)
Local Validacao := .T.
	/*if i == 1
		if VAL(MV_PAR01) <= 0
			Validacao := .F.
			Alert("Preencha o Campo 'Nota de' !!")
		elseif VAL(MV_PAR01) > VAL(MV_PAR02) .AND. !Empty(MV_PAR02)
			Validacao := .F.
			Alert("Valor de 'Nota at้' deve ser Superior เ 'Nota de' !!")
		endif
	else
		if VAL(MV_PAR02) <= 0
			Validacao := .F.
			Alert("Preencha o Campo 'Nota at้' !!")
		elseif VAL(MV_PAR01) > VAL(MV_PAR02)
			Validacao := .F.
			Alert("Valor de 'Nota at้' deve ser Superior เ 'Nota de' !!")
		endif
	endif*/

Return(Validacao)
