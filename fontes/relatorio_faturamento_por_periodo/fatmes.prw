#Include "Protheus.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FATMES   ³ Autor ³ Henrique F P Pereira  ³ Data ³21/06/2012³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatório Faturamento por período                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FATMES()
Local oReport

// Criação das perguntas 
PutSx1( "FATMES", "01","Data de?","","","mv_ch1","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1( "FATMES", "02","Data até?","","","mv_ch2","D",8,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")

// Icicia a interface de perguntas/ parametrização
If TRepInUse()
	Pergunte("FATMES",.F.)
	
	oReport:= ReportDef()
	oReport:PrintDialog()
	
EndIf

Return

Static Function ReportDef()
Local oReport
Local oSection
Local oSection2 
Local oSection3

oReport := TReport():New("FATMES","RELATORIO RESUMO FATURAMENTO","FATMES",{|oReport| PrintReport(oReport)},"RELATORIO RESUMO FATURAMENTO")

oSection := TRSection():New(oReport,"FATURAMENTO",{"SD2"})  
oSection2 := TRSection():New(oReport,"FATURAMENTO",{"SD2"})
oSection3 := TRSection():New(oReport,"FATURAMENTO",{"SD2"})

// Cria as celulas/ colunas do relatório 
TRCell():New(oSection,"MES","SD2","MES",,11)
TRCell():New(oSection,"BRUTO" ,"SD2","BRUTO","@E 999,999,999.99",15)
TRCell():New(oSection,"DEBITO","CT7","DEVOLUÇÕES IMPOSTOS","@E 999,999,999.99",15)
TRCell():New(oSection,"LIQUIDO","CT7","LIQUIDO","@E 9999,999,999,999.99",20) 

TRCell():New(oSection3,"FATMENSAL","SD2","                               FATURAMENTO MÉDIO",,50) 

TRCell():New(oSection2,"PERIODO","CT7","PERIODO",,11)
TRCell():New(oSection2,"PBRUTO","CT7","BRUTO","@E 9999,999,999,999.99",15)
TRCell():New(oSection2,"PDEBITO","CT7","DEVOLUÇÕES IMPOSTOS","@E 9999,999,999,999.99",15)
TRCell():New(oSection2,"PLIQUIDO","CT7","LIQUIDO","@E 9999,999,999,999.99",15)

Return oReport

Static Function PrintReport(oReport)
Local oSection  := oReport:Section(1)
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)
Local nLiquido  := 0
Local nValBruto := 0
LocaL cAno      := ""
Local nLin      := 0
Local gArea
Local gArea2
Local gArea3
Local DVOLIMP   := 0
Local nDevolT   := 0
Local nLiqT     := 0
Local nContdata := 0
Local nInd      := 0
Local nAno      := 0
Local nAno01    := 0
Local nAno02    := 0
Local cAno01    := ""
Local cAno02    := ""
Local nX        := 0
Local nMes      := 1  
// variaveis para armezanamento dos valores por 60, 36, 24 e 12 meses   
Local aValorb   := {}
Local aDevolimp := {}
Local aValorliq := {}
Local nBmes     := 0 
Local nDmes     := 0
Local nContValb := 0  
Local nContValD := 0
Local nContValL := 0
Local nFimfor   := 0 
Local nLenVal   := 0
Local n36mes    := 0


oReport:SetTitle("Movimentação por período")// Titulo do relatório

//Tratamento das divisões dos anos
nAno01 :=YEAR(MV_PAR01)// Pega o ano digitado no paramentro 1 das perguntas
nAno02 := YEAR(MV_PAR02)// Pega o ano digitado no paramentro 2 das perguntas
nAno := nAno02-nAno01

For nX:=0 To nAno
	
	IF nX == nAno
		nFim := MONTH(MV_PAR02)
	ELSE
		nFim := 12
	ENDIF 
	
// Zerando as variavei de somatóra total dos valores BRUTO, DEVOLUÇÃES E IMPOSTOS E VALOR LIQUIDO	
nDevolT   := 0 
nLiqT     := 0 
nValBruto := 0
	
	For nMes := 1 TO nFim
		
		If nX==0 .AND. nMes = 1
			cAno01 := DTOS(MV_PAR01)
			nMes := MONTH(MV_PAR01)
		EndIf
		If nX==nAno .AND. MONTH(MV_PAR02) = nMes
			cAno02 := DTOS(MV_PAR02)
		EndIf
		
		IF STRZERO(MONTH(MV_PAR01),2,0)+STRZERO(YEAR(MV_PAR01),4,0) <> STRZERO(nMes,2,0)+STRZERO(YEAR(MV_PAR01)+nX,4,0)
			cAno01 := cValToChar(nAno01+nX)+ALLTRIM(STRZERO(nMes,2,0))+"01" 
		ENDIF
		IF STRZERO(MONTH(MV_PAR02),2,0)+STRZERO(YEAR(MV_PAR02),4,0) <> STRZERO(nMes,2,0)+STRZERO(YEAR(MV_PAR01)+nX,4,0)
			cAno02 := cValToChar(nAno01+nX)+ALLTRIM(STRZERO(nMes,2,0))+"31" 
		ENDIF 
		
		//query valor bruto
		cQuery0 := "SELECT SUM(CT2_VALOR) AS VALOR, MONTH(CT2_DATA) AS MES FROM "+RetSqlName("CT2")+" CT2 "
		cQuery0 += "WHERE CT2_DATA BETWEEN  '"+cAno01+"' AND '"+cAno02+"'"
		cQuery0 += " AND CT2_CREDIT IN ('41101001','41101002','41401001')"
		cQuery0 += " AND CT2.D_E_L_E_T_ <> '*' AND CT2_FILIAL = '"+xFilial("CT2")+"'" 
		cQuery0 += " AND CT2_LOTE NOT IN ('009901','009902','009903','009904') "	
		cQuery0 += " GROUP BY MONTH(CT2_DATA)"
		cQuery0 += " ORDER BY MONTH(CT2_DATA)"	
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery0),"QRYTEMP0",.T.,.F.) 
		
		cQuery1 := "SELECT SUM(CT2_VALOR) AS VALOR, MONTH(CT2_DATA) AS MES FROM "+RetSqlName("CT2")+" CT2 "
		cQuery1 += "WHERE CT2_DATA BETWEEN '"+cAno01+"' AND '"+cAno02+"'"
		cQuery1 += " AND CT2_DEBITO IN ('41101001','41101002','41401001') "
		cQuery1 += " AND CT2.D_E_L_E_T_ <> '*' AND CT2_FILIAL = '"+xFilial("CT2")+"'"  
		cQuery1 += " AND CT2_LOTE NOT IN ('009901','009902','009903','009904') "
		cQuery1 += " GROUP BY MONTH(CT2_DATA)"
		cQuery1 += " ORDER BY MONTH(CT2_DATA)"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),"QRYTEMP1",.T.,.F.) 
		
		// Query devoluções
		cQuery2 := "SELECT SUM(CT2_VALOR) AS VALOR, MONTH(CT2_DATA) AS MES FROM "+RetSqlName("CT2")+" CT2 "
		cQuery2 += "WHERE CT2_DATA BETWEEN '"+cAno01+"' AND '"+cAno02+"'"
		cQuery2 += " AND CT2_DEBITO IN ('42101001','42102002','43101001','43101002','43101003','43101004','43101005','43101006','43101007','43101008') "
		cQuery2 += " AND CT2.D_E_L_E_T_ <> '*' AND CT2_FILIAL = '"+xFilial("CT2")+"'"
		cQuery2 += " AND CT2_LOTE NOT IN ('009901','009902','009903','009904') "
		cQuery2 += " GROUP BY MONTH(CT2_DATA)"
		cQuery2 += " ORDER BY MONTH(CT2_DATA)"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),"QRYTEMP2",.T.,.F.)
		
		cQuery3 := "SELECT SUM(CT2_VALOR) AS VALOR, MONTH(CT2_DATA) AS MES FROM "+RetSqlName("CT2")+" CT2 "
		cQuery3 += "WHERE CT2_DATA BETWEEN  '"+cAno01+"' AND '"+cAno02+"'"
		cQuery3 += " AND CT2_CREDIT IN ('42101001','42102002','43101001','43101002','43101003','43101004','43101005','43101006','43101007','43101008')"
		cQuery3 += " AND CT2.D_E_L_E_T_ <> '*' AND CT2_FILIAL = '"+xFilial("CT2")+"'"
		cQuery3 += " AND CT2_LOTE NOT IN ('009901','009902','009903','009904') "
		cQuery3 += " GROUP BY MONTH(CT2_DATA)"
		cQuery3 += " ORDER BY MONTH(CT2_DATA)"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery3),"QRYTEMP3",.T.,.F.) 
		
		dbSelectArea("QRYTEMP1")
		dbSelectArea("QRYTEMP0")
		VALORB := QRYTEMP0->VALOR - QRYTEMP1->VALOR 
		AADD(aValorb, VALORB)
		oReport:IncMeter()
		oSection:Init()
		oSection:Cell("MES"):SetValue(MESX(nMes))
		oSection:Cell("BRUTO"):SetValue(VALORB)
		If oReport:Cancel()
			Exit
		EndIf
	
		dbSelectArea("QRYTEMP2")
		
		dbSelectArea("QRYTEMP3")
		
		DVOLIMP := (QRYTEMP3->VALOR - QRYTEMP2->VALOR)*-1
		AADD(aDevolimp, DVOLIMP)
		oSection:Cell("DEBITO"):SetValue(DVOLIMP)
		
		nDevolT  += DVOLIMP
		nLiqT    += (DVOLIMP-VALORB)*-1
		
		nLiquido := (DVOLIMP-VALORB)*-1
		AADD(aValorliq, nLiquido)
		oSection:Cell("LIQUIDO"):SetValue(nLiquido)
		oSection:PrintLine()
		nValBruto += VALORB
		//FECHA QUERYES TEMPORÁRIAS
		dbSelectArea("QRYTEMP0")
		DbCloseArea("QRYTEMP0")
		dbSelectArea("QRYTEMP1")
		DbCloseArea("QRYTEMP1")  
		dbSelectArea("QRYTEMP2")
		DbCloseArea("QRYTEMP2")
		dbSelectArea("QRYTEMP3")
		DbCloseArea("QRYTEMP3")
		
		Next
		
		oSection:Cell("MES"):SetValue("Total "+SUBSTR(CAno01,0,4))
		oSection:Cell("BRUTO"):SetValue(nValBruto)
		oSection:Cell("DEBITO"):SetValue(nDevolT)
		oSection:Cell("LIQUIDO"):SetValue(nLiqT)
		oSection:PrintLine()
		oSection:Finish()
		
		
	Next 
	    
	    oReport:IncMeter()
		oSection3:Init()
	   // oSection3:Cell("FATMENSAL"):SetValue("                               FATURAMENTO MÉDIO")
		oSection3:PrintLine() 
		oSection3:Finish()
	// calculo para impressão da media faturada no período de 60, 48, 36, 24 e 12 mêses
	    nLenVal := Len(aValorb)
	    nFimfor :=  nLenVal-60 
	    n48mes  :=  nLenVal-48
	    n36mes  :=  nLenVal-36
	    n24mes  :=  nLenVal-24 
        n12mes  :=  nLenVal-12
	     
	    While nLenVal > nFimfor 
		nContValb += aValorb[nLenVal]
		nContValD += aDevolimp[nLenVal] 
	   	nContValL += aValorLiq[nLenVal]  
	   	
	    If nLenVal == n48mes
	    n48mesb := nContValb
	    n48mesD := nContValD
	    n48mesL := nContValL
	    ElseIf nLenVal == n36mes
	    n36mesb := nContValb 
	    n36mesD := nContValD
	    n36mesL := nContValL
	    ElseIf nLenVal == n24mes
	    n24mesb := nContValb
	    n24mesD := nContValD
	    n24mesL := nContValL
	    ElseIf nLenVal == n12mes
        n12mesb := nContValb
        n12mesD := nContValD
	    n12mesL := nContValL
        EndIf         
	    nLenVal-- 
		Enddo
		oReport:IncMeter()
		oSection2:Init()
		
		oSection2:Cell("PERIODO"):SetValue("60 Meses")
	    oSection2:Cell("PBRUTO"):SetValue(nContValb/60)
	    oSection2:Cell("PDEBITO"):SetValue(nContValD/60)
	    oSection2:Cell("PLIQUIDO"):SetValue(nContValL/60)
	    oSection2:PrintLine()  
	    
	    oSection2:Cell("PERIODO"):SetValue("48 Meses")
	    oSection2:Cell("PBRUTO"):SetValue(n48mesb/48)
	    oSection2:Cell("PDEBITO"):SetValue(n48mesD/48)
	    oSection2:Cell("PLIQUIDO"):SetValue(n48mesL/48)
	  	oSection2:PrintLine() 
	  	
	  	oSection2:Cell("PERIODO"):SetValue("36 Meses")
	    oSection2:Cell("PBRUTO"):SetValue(n36mesb/36)
	    oSection2:Cell("PDEBITO"):SetValue(n36mesD/36)
	    oSection2:Cell("PLIQUIDO"):SetValue(n36mesL/36)
	  	oSection2:PrintLine() 
	  	  
	  	oSection2:Cell("PERIODO"):SetValue("24 Meses")
	    oSection2:Cell("PBRUTO"):SetValue(n24mesb/24)
	    oSection2:Cell("PDEBITO"):SetValue(n24mesD/24)
	    oSection2:Cell("PLIQUIDO"):SetValue(n24mesL/24)
	  	oSection2:PrintLine()  
	  	
  		oSection2:Cell("PERIODO"):SetValue("12 Meses")
	    oSection2:Cell("PBRUTO"):SetValue(n12mesb/12)
	    oSection2:Cell("PDEBITO"):SetValue(n12mesD/12)
	    oSection2:Cell("PLIQUIDO"):SetValue(n12mesL/12)
	  	oSection2:PrintLine()  
	  	
	  	oSection2:Finish()
	  
	
	Return
	
	// Função que transforma numeros de 1 a 12 em string descrevendo o mês correspondente ao numero
	
	Static Function MESX(cVal)
	Local cValf := ""
	
	If cval == 1
		cValf := "Janeiro"
	ElseIf cVal == 2
		cValf := "Fevereiro"
	ElseIf cval == 3
		cValf := "Março"
	ElseIf cVal == 4
		cValf := "Abril"
	ElseIf cval == 5
		cValf := "Maio"
	ElseIf cVal == 6
		cValf := "Junho"
	ElseIf cval == 7
		cValf := "Julho"
	ElseIf cVal == 8
		cValf := "Agosto"
	ElseIf cVal == 9
		cValf := "Setembro"
	ElseIf cVal == 10
		cValf := "Outubro"
	ElseIf cVal == 11
		cValf := "Novembro"
	ElseIf cVal == 12
		cValf := "Dezembro"
	EndIf
	
	Return cValf
	
