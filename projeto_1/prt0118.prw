#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PRT0118  บAutor  ณFelipe Basso        บ Data ณ  16-09-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Etiqueta para a Tela de Expedi็ใo                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PRT0118(vFil, vPed, vVoLi, vVolF)
	LOCAL 	aArea 	:= SC9->(GetArea())
	PRIVATE vFilial := vFil
	PRIVATE vPedido := vPed
	PRIVATE vVolIni := vVoli
	PRIVATE vVolFim := vVolF
	 
	If vSelect()
		Alert("Pedido nใo Existe!!")
	Else       
		RptStatus({|lEnd| Processo()},"PRT0118 - IMPRIMINDO ...")

		//-- Fecha a Tabela Temporแria --------------------------------------------------
		PRT0118->(DBCloseArea())
		//-------------------------------------------------------------------------------

		RestArea(aArea)
	Endif
Return(.T.)

Static Function VerTabela(tab)
	If SELECT(tab) > 0
  		dbSelectArea(tab)
  		dbCloseArea(tab)
 	Endif
Return

Static Function vSelect()
	Local vQuery := nil

	VerTabela("PRT0118")
	VerTabela("PRT0118_2") 
	
	//-- Executa a query com os filtros do grupo de pergunta ----------------------------
	vQuery := "SELECT MAX(ZD.ZD_VOLUME) TOTAL";
			+ " FROM " + RetSQLName("SZD") + " ZD";
			+ " INNER JOIN " + RetSQLName("SC6") + " C6 ON C6.C6_FILIAL = ZD.ZD_FILIAL AND C6.C6_NUM 	= ZD.ZD_PEDIDO AND C6.C6_ITEM = ZD.ZD_ITEMPV";
			+ " INNER JOIN " + RetSQLName("SA1") + " A1 ON A1.A1_FILIAL = '"+xFilial("SA1")+"' AND A1.A1_COD 	= C6.C6_CLI AND A1.A1_LOJA = C6.C6_LOJA";
			+ " INNER JOIN " + RetSQLName("SB1") + " B1 ON B1.B1_FILIAL = '"+xFilial("SB1")+"' AND B1.B1_COD 	= C6.C6_PRODUTO AND B1_LOCPAD = C6_LOCAL";
			+ " WHERE ZD.D_E_L_E_T_ <> '*'";
			+ " AND C6.D_E_L_E_T_ <> '*'";
			+ " AND A1.D_E_L_E_T_ <> '*'";
			+ " AND B1.D_E_L_E_T_ <> '*'";			
			+ " AND ZD.ZD_FILIAL = '" + vFilial + "'";
			+ " AND ZD.ZD_PEDIDO = '" + vPedido + "'"

	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,vQuery),"PRT0118_2",.F.,.T.)
	//-----------------------------------------------------------------------------------

	//-- Executa a query com os filtros do grupo de pergunta ----------------------------
	vQuery := "SELECT A1.A1_NOME, C6.C6_NOTA, B1.B1_COD, B1.B1_XCODCAT, C6.C6_DESCRI, ZD.ZD_QTDVOL, B1.B1_PESO PESO_LIQ, ZD.ZD_VOLUME, C5_EMISSAO";
			+ " FROM " + RetSQLName("SZD") + " ZD";
			+ " INNER JOIN " + RetSQLName("SC6") + " C6 ON C6.C6_FILIAL = ZD.ZD_FILIAL AND C6.C6_NUM 	= ZD.ZD_PEDIDO AND C6.C6_ITEM = ZD.ZD_ITEMPV";
			+ " INNER JOIN " + RetSQLName("SC5") + " C5 ON C5.C5_FILIAL = ZD.ZD_FILIAL AND C5.C5_NUM 	= ZD.ZD_PEDIDO";
			+ " INNER JOIN " + RetSQLName("SA1") + " A1 ON A1.A1_FILIAL = '"+xFilial("SA1")+"' AND A1.A1_COD 	= C6.C6_CLI AND A1.A1_LOJA = C6.C6_LOJA";
			+ " INNER JOIN " + RetSQLName("SB1") + " B1 ON B1.B1_FILIAL = '"+xFilial("SB1")+"' AND B1.B1_COD 	= C6.C6_PRODUTO AND B1_LOCPAD = C6_LOCAL";
			+ " WHERE ZD.D_E_L_E_T_ <> '*'";
			+ " AND C6.D_E_L_E_T_ <> '*'";
			+ " AND A1.D_E_L_E_T_ <> '*'";
			+ " AND B1.D_E_L_E_T_ <> '*'";			
			+ " AND ZD.ZD_FILIAL = '" + vFilial + "'";
			+ " AND ZD.ZD_PEDIDO = '" + vPedido + "'";
			+ " AND ZD.ZD_VOLUME BETWEEN '" + (vVolIni) + "' AND '" + (vVolFim) + "'";
			+ " ORDER BY ZD.ZD_VOLUME"                                   

	MemoWrite("c:\sql2.txt", vQuery)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,vQuery),"PRT0118",.F.,.T.)
	//-----------------------------------------------------------------------------------
Return(PRT0118->(EOF()))

Static Function PROCESSO()
	LOCAL	i		:= 0 
	Local   cPROD   := ""
	LOCAL	vArray	:= {}
	PRIVATE vLinha	:= 0
	PRIVATE cLogo	:= ""
	PRIVATE oProc

	//-- Inํcio do Relat๓rio ------------------------------------------------------------
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
    //-----------------------------------------------------------------------------------

	//-- Roda os Itens do Pedido --------------------------------------------------------
	PRT0118->(DbGotop())

	while PRT0118->(!EOF())   
   //  cPROD := IIF(PRT0118->C5_EMISSAO >= "20130211",PRT0118->B1_COD,IIF(Empty(PRT0118->B1_XCODCAT),PRT0118->B1_COD ,PRT0118->B1_XCODCAT))
		vDados := iif(empty(vPedido), 							".", AllTrim(vPedido)) 							+ "ฌ";
		 		+ iif(empty(cLogo), 							".", AllTrim(cLogo)) 							+ "ฌ";
				+ iif(empty(cValToChar(PRT0118_2->TOTAL)), 	".", AllTrim(cValToChar(PRT0118_2->TOTAL)))	+ "ฌ";//+ iif(empty(vVolFim), 							".", AllTrim(vVolFim)) 							+ "ฌ";
				+ iif(empty(PRT0118->A1_NOME), 				".", SubStr(AllTrim(PRT0118->A1_NOME),1,30)) 				+ "ฌ";
				+ iif(empty(cValToChar(PRT0118->C6_NOTA)), 	".", AllTrim(cValToChar(PRT0118->C6_NOTA))) 	+ "ฌ";
				+ iif(empty(PRT0118->C6_DESCRI), 				".", AllTrim(PRT0118->B1_COD))				+ "ฌ";
				+ iif(empty(cValToChar(PRT0118->ZD_QTDVOL)), 	".", AllTrim(cValToChar(PRT0118->ZD_QTDVOL))) 	+ "ฌ";
				+ iif(empty(cValToChar(PRT0118->PESO_LIQ)), 	".", AllTrim(Transform(PRT0118->PESO_LIQ, "@E 999,999.9999")))		+ "ฌ";
				+ iif(empty(cValToChar(PRT0118->ZD_VOLUME)), 	".", AllTrim(cValToChar(PRT0118->ZD_VOLUME)))						+ "ฌ";
				+ iif(empty(cValToChar(PRT0118_2->TOTAL)), 	".", AllTrim(cValToChar(PRT0118_2->TOTAL)))

		AADD(vArray, vDados)

		PRT0118->(DBSkip())
	ENDDO
	//-----------------------------------------------------------------------------------        
	
	FERASE("C:\Arquivos de programas\PGI0832\arquivo.txt")
		
	Grv_Arq_TXT("C:\Arquivos de programas\PGI0832\arquivo.txt", vArray)
		
	winexec("C:\Arquivos de programas\PGI0832\PGI0832.exe")
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrv_Arq_TXTบAutor  ณFelipe Basso       บ Data ณ  16-09-11   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava o Arquivo Texto                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure Grv_Arq_TXT(cCaminho,linha)
	Local nLin
	Local nHdl := FCREATE(cCaminho) // cria o arquivo
	
	if FERROR() # 0
		msgalert ("ERRO AO CRIAR O ARQUIVO, ERRO: " + str(ferror()))
	else
		for nLin := 1 to len(Linha)
			fwrite(nHdl,Linha[nLin] + chr(13) + chr(10))
		next

		if FERROR() # 0
			msgalert ("ERRO GRAVANDO ARQUIVO, ERRO: " + str(ferror()))
		else
			fClose(nHdl)        // grava o arquivo Texto
		endif
	endif
Return