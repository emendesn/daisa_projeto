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
User Function CARTEIRA()
Local oReport

// Criação das perguntas 
PutSx1( "CARTEIRA", "01","Data de?","","","mv_ch1","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1( "CARTEIRA", "02","Data até?","","","mv_ch2","D",8,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1( "CARTEIRA", "03","capacidade Diaria","","","mv_ch3","N",8,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")
// Icicia a interface de perguntas/ parametrização
If TRepInUse()
	Pergunte("CARTEIRA",.F.)
	
	oReport:= ReportDef()
	oReport:PrintDialog()
	
EndIf

Return

Static Function ReportDef()
Local oReport
Local oSection
Local oSection2 
Local oSection3

oReport := TReport():New("CARTEIRA","RELATORIO CARTEIRA DE PEDIDOS","CARTEIRA",{|oReport| PrintReport(oReport)},"RELATORIO CARTEIRA DE PEDIDOS")

oSection := TRSection():New(oReport,"CARTEIRA",)  
//oSection2 := TRSection():New(oReport,"FATURAMENTO",{"SD2"})
//oSection3 := TRSection():New(oReport,"FATURAMENTO",{"SD2"})

// Cria as celulas/ colunas do relatório 
TRCell():New(oSection,"ENTREGA",,"ENTREGA",,11)
TRCell():New(oSection,"PEDIDO" ,,"PEDIDO",,15)
TRCell():New(oSection,"VALOR" ,,"VALOR","@E 999,999,999.99",15)
TRCell():New(oSection,"QUANTIDADE",,"QUANTIDADE","@E 999,999,999.99",15)
TRCell():New(oSection,"TAMPOES",,"TAMPÕES","",10) 
TRCell():New(oSection,"DIA",,"Dia da Semana","",10)
TRCell():New(oSection,"CAPDIA",,"Capacidade Diária Fábrica","@E 999,999,999.99",15)
TRCell():New(oSection,"SALDO",,"Saldo Quantidade Data de Entrega Atual","@E 999,999,999.99",15)


Return oReport

Static Function PrintReport(oReport)
Local oSection  := oReport:Section(1) 
Local cData01   := DTOS(MV_PAR01)
Local cData02   := DTOS(MV_PAR02)
Local cQuery    := "" 
Local cQuery2   := ""
Local nLin      := 0


oReport:SetTitle("CARTEIRA DE PEDIDOS")// Titulo do relatório

		
		//query valor bruto
		cQuery := "SELECT C6_ENTREG ENTREGA, SUM(C6_VALOR) VALOR, SUM(C6_QTDVEN) QUANTIDADE, C6_NUM PEDIDO FROM "+RetSqlName("SC6")+" SC6 "
		cQuery += " WHERE C6_ENTREG BETWEEN  '"+cData01+"' AND '"+cData02+"'"
		cQuery += " GROUP BY SC6.C6_NUM, SC6.C6_ENTREG"   
		cQuery += " ORDER BY SC6.C6_NUM"
	
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"QRY",.T.,.F.)  
		
		cQuery2 := "SELECT C6_ENTREG ENTREGA, SUM(C6_VALOR) VALOR, SUM(C6_QTDVEN) QUANTIDADE, C6_NUM PEDIDO FROM "+RetSqlName("SC6")+" SC6 "
		cQuery2 += " WHERE C6_ENTREG BETWEEN  '"+cData01+"' AND '"+cData02+"' AND SC6.C6_PRODUTO LIKE 'MT%'"
		cQuery2 += " GROUP BY SC6.C6_NUM, SC6.C6_ENTREG"   
		cQuery2 += " ORDER BY SC6.C6_NUM"
	
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),"QRY2",.T.,.F.) 	
	    
		DbSelectArea("QRY2") 
	    While !EOF() 
		oSection:Cell("TAMPOES"):SetValue(QRY2->VALOR)  
		 DbSkip()
		dbSelectArea("QRY")
	   
		oReport:IncMeter()
		oSection:Init()
		oSection:Cell("ENTREGA"):SetValue(STOD(QRY->ENTREGA))
		oSection:Cell("PEDIDO"):SetValue(QRY->PEDIDO)
		oSection:Cell("VALOR"):SetValue(QRY->VALOR)
		oSection:Cell("QUANTIDADE"):SetValue(QRY->QUANTIDADE) 
		oSection:Cell("DIA"):SetValue("DIA DA SEMANA") 
		oSection:Cell("CAPDIA"):SetValue(MV_PAR03)
		oSection:Cell("SALDO"):SetValue(QRY->VALOR - MV_PAR03) 
		oSection:PrintLine()
	    
	   //	If oReport:Cancel()
		 //	Exit
	   //	EndIf 
	   DbSkip()
       EndDo
      oSection:Finish()
     dbSelectArea("QRY")
     DBCLOSEAREA("QRY") 
     dbSelectArea("QRY2")
     DBCLOSEAREA("QRY2")
	
	
		
	
		
	Return
	
