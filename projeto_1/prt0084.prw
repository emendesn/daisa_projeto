#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPRT0084   บAutsor  ณMarcos Santos      บ Data ณ  30-08-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de identifica็ใo de perdas no processo           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออsอออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PRT0084()  
Local cPerg         := "MV_PRT0084"
Local cQuery        := nil
Local cDIni         := nil
Local cDFim         := nil
Local cTpMovto      := nil                       

Local cInd
Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Relat๓rio de identifica็ใo de perdas no processo"
Local cPict         := ""
Local titulo        := "Relat๓rio de identifica็ใo de perdas no processo"
Local nLin          := 80
Local Cabec1        := "  OP/LOTE        COD.DAISA          COD.PROTHEUS        DESCRICAO                               QTDE         DATA"
Local Cabec2        := Space(82)
Local imprime       := .T.
Local aOrd          := {}
Local cPerda        := nil   

Private cString     := ""
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "M"
Private nomeprog    := "PRT0084" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "PRT0084" // Coloque aqui o nome do arquivo usado para impressao em disco

//grupo de perguntas
AjustaSX1(cPerg)
If Pergunte(cPerg,.T.)
	
	//carrego o parametro dos TMs de perda
	cPerda := SuperGetMV("MV_TMPERDA",.F.,"1")
	
	//executo a query com os filtros do grupo de pergunta
	CQUERY := " SELECT SF5.F5_TEXTO,SD3.D3_OP OP,SB1.B1_CODANT,SB1.B1_COD, "
	CQUERY += " SB1.B1_DESC,SUM(SD3.D3_QUANT) QTDE,SD3.D3_EMISSAO,SD3.D3_LOCAL,SD3.D3_LOTECTL "
	CQUERY += " FROM "+ RETSQLNAME('SD3')+" SD3 "
	CQUERY += "  JOIN "+ RETSQLNAME('SF5')+" SF5 "
	//CQUERY += "    ON SD3.D3_FILIAL = SF5.F5_FILIAL "
	CQUERY += "    ON SD3.D3_TM = SF5.F5_CODIGO "
	CQUERY += "    AND SF5.D_E_L_E_T_ <> '*'"
	CQUERY += "  JOIN "+ RETSQLNAME('SB1')+" SB1 "
	//CQUERY += "    ON SD3.D3_FILIAL = SB1.B1_FILIAL "
	CQUERY += "    ON SD3.D3_COD = SB1.B1_COD "
	CQUERY += "    AND SB1.D_E_L_E_T_ <> '*'"
	CQUERY += " WHERE SD3.D_E_L_E_T_ <> '*' "
	CQUERY += " AND SD3.D3_FILIAL = '"+CFILANT+"'"
	CQUERY += " AND SD3.D3_TM IN ("+CPERDA+")"
	
	IF .Not. EMPTY(MV_PAR01) .And. .Not. EMPTY(MV_PAR02)
		CQUERY += " AND SB1.B1_COD BETWEEN '"+ALLTRIM(MV_PAR01)+"' AND '"+ALLTRIM(MV_PAR02)+"'
	ENDIF
	
	If .Not. EMPTY(MV_PAR03) .And. .Not. EMPTY(MV_PAR04)
		//trato as datas
		cDIni  := DTOC(MV_PAR03)
		cDFim  := DTOC(MV_PAR04)
		cDIni  := SUBSTR(cDIni,7,4) + SUBSTR(cDIni,4,2) + SUBSTR(cDIni,1,2)
		cDFim  := SUBSTR(cDFim,7,4) + SUBSTR(cDFim,4,2) + SUBSTR(cDFim,1,2)
		
		If LEN(cDIni) == 6
			cDIni := "20" + cDIni
		Endif
		
		If LEN(cDFim) == 6
			cDFim := "20" + cDFim
		Endif
		
		CQUERY += " AND SD3.D3_EMISSAO BETWEEN '" + cDIni + "' AND '" + cDFim + "'
	Endif
	
	IF !EMPTY(MV_PAR05) .AND. !EMPTY(MV_PAR06)
		CQUERY += " AND SD3.D3_LOTECTL BETWEEN '"+ALLTRIM(MV_PAR05)+"' AND '"+ALLTRIM(MV_PAR06)+"'
	ENDIF
	
	CQUERY += " GROUP BY SF5.F5_TEXTO,SD3.D3_OP,SB1.B1_CODANT,SB1.B1_COD,SB1.B1_DESC,SD3.D3_EMISSAO,SD3.D3_LOCAL,SD3.D3_LOTECTL"
	
	DO CASE
		CASE MV_PAR07 = 1      //CODIGO DAISA
			CQUERY += " ORDER BY SF5.F5_TEXTO, SB1.B1_CODANT"
		CASE MV_PAR07 = 2      //DATA
			CQUERY += " ORDER BY SF5.F5_TEXTO, SD3.D3_EMISSAO"
		OTHERWISE                 //ALMOXARIFADO
			CQUERY += " ORDER BY SF5.F5_TEXTO, SD3.D3_LOCAL"
	ENDCASE
	
	//memowrite("c:\marcos.sql",cQuery)
	
	VerTabela("TMPRT84")
	TCQuery cQuery New Alias "TMPRT84"
	
	//Monta a interface padrao com o usuario...
	wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
	
Endif

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunReport บAutsor  ณMarcos Santos      บ Data ณ  30-08-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Montagem do relatorio                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local nNTotal   := 0
Local nSubTotal := 0
Local cTipMov   := nil

	TMPRT84->(DbGotop())
	While TMPRT84->( .Not. Eof() )
		//Verifica o cancelamento pelo usuario...
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		//Impressao do cabecalho do relatorio. . .
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif
		
		// Coloque aqui a logica da impressao do seu programa...
		If EMPTY(cTipMov)
			@nLin,00 PSAY "TM: " + ALLTRIM(TMPRT84->F5_TEXTO)
			cTipMov := AllTrim(TMPRT84->F5_TEXTO)
			nLin    += 1
		ElseIf AllTrim(cTipMov) <> ALLTRIM(TMPRT84->F5_TEXTO)
			@nLin,00 PSAY "TOTAL TM:" + cTipMov
			@nLin,96 PSAY nSubTotal PICTURE "@E 9999.99"
			nLin    += 2
			
			@nLin,00 PSAY "TM: " + ALLTRIM(TMPRT84->F5_TEXTO)
			cTipMov   := ALLTRIM(TMPRT84->F5_TEXTO)
			nSubTotal := 0
			nLin      += 1
		Endif
		
		@nLin,3  PSAY IIF( EMPTY(TMPRT84->D3_LOTECTL),'0',ALLTRIM(TMPRT84->D3_LOTECTL))
		@nLin,18 PSAY IIF( EMPTY(TMPRT84->B1_CODANT),'0',ALLTRIM(TMPRT84->B1_CODANT))
		@nLin,37 PSAY ALLTRIM(TMPRT84->B1_COD)
		@nLin,57 PSAY SUBSTR(ALLTRIM(TMPRT84->B1_DESC),1,35)
		
		@nLin,96 PSAY TMPRT84->QTDE PICTURE "@E 9999.99"
		nSubTotal += TMPRT84->QTDE
		nNTotal   += TMPRT84->QTDE
		
		@nLin,107 PSAY Substr(TMPRT84->D3_EMISSAO,7,2)+'/'+Substr(TMPRT84->D3_EMISSAO,5,2)+'/'+Substr(TMPRT84->D3_EMISSAO,1,4)
		
		nLin += 1
		
		TMPRT84->(DBSkip())
	EndDo
	
	//ultimo subtotal
	@nLin,00 PSAY "TOTAL TM:" + ALLTRIM(cTipMov)
	@nLin,96 PSAY nSubTotal PICTURE "@E 9999.99"
	nLin += 2
	
	//total geral
	@nLin,00 PSAY "TOTAL GERAL"
	@nLin,96 PSAY nNTotal PICTURE "@E 9999.99"
	
	//fecho a temporaria
	TMPRT84->(DBCloseArea())
	
	//Finaliza a execucao do relatorio...
	SET DEVICE TO SCREEN
	
	//Se impressao em disco, chama o gerenciador de impressao...
	If aReturn[5] == 1
		DBCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerTabela บAutsor ณMarcos Santos       บ Data ณ  30-08-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica a exitencia da tabela temporaria aberta           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure VerTabela(tab)
	If SELECT(tab) > 0
		dbSelectArea(tab)
		dbCloseArea(tab)
	Endif
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutsor ณMarcos Santos       บ Data ณ  30-08-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica a existencia do grupo de perguntas.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure AjustaSX1(cPerg)        

Local aArea := GetArea()
Local nPos    

	//limpo a memoria
	DBSelectArea("SX1")
	SX1->( DBSetOrder(1) )
	For nPos := 1 To 7
		If SX1->( DBSeek( PADR(cPerg,10) + PadL( cValToChar(nPos), 2, "0" ) ) )
			Reclock("SX1",.F.)
			SX1->X1_CNT01 := ""
			SX1->(MsUnlock())
		Endif
	Next
	
	PutSx1(cPerg,"01","Produto de: "," "," ", "mv_ch1","C",15,0,0 ,"G","","SB1","","","mv_par01","","","","","","","","","","","","",""," "," "," ",{"Produto de"},{"Produto de"},{"Produto de"})
	PutSx1(cPerg,"02","Produto ate: "," "," ","mv_ch2","C",15,0,0 ,"G","","SB1","","","mv_par02","","","","","","","","","","","","",""," "," "," ",{"Produto ate"},{"Produto ate"},{"Produto ate"})
	PutSx1(cPerg,"03","Data de: "," "," ",    "mv_ch3","D",8,0,0 ,"G","","","","",    "mv_par03","","","","","","","","","","","","",""," "," "," ",{"Periodo Inicial"},{"Periodo Inicial"},{"Periodo Inicial"})
	PutSx1(cPerg,"04","Data ate:"," "," ",    "mv_ch4","D",8,0,0 ,"G","","","","",    "mv_par04","","","","","","","","","","","","",""," "," "," ",{"Periodo Final"},{"Periodo Final"},{"Periodo Final"})
	PutSx1(cPerg,"05","Lote de: "," "," ",    "mv_ch5","C",15,0,0 ,"G","","","","",   "mv_par05","","","","","","","","","","","","",""," "," "," ",{"Lote de"},{"Lote de"},{"Lote de"})
	PutSx1(cPerg,"06","Lote ate: "," "," ",   "mv_ch6","C",15,0,0 ,"G","","","","",   "mv_par06","","","","","","","","","","","","",""," "," "," ",{"Lote ate"},{"Lote ate"},{"Lote ate"})
	PutSx1(cPerg,"07","Ordenar por: "," "," ","mv_ch7","N",1,0,2 ,"C","","","","",    "mv_par07","Produto Daisa","Produto Daisa","Produto Daisa","","Data","Data","Data","Almoxarifado","Almoxarifado","Almoxarifado","","","","","","",{"Ordenar por"},{"Ordenar por"},{"Ordenar por"})
	
	RestArea(aArea)
	
Return

