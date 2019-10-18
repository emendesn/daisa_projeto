#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF Chr(13)+Chr(10)

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ DAI001   ≥ Autor ≥ Edilson    Nascimento ≥ Data ≥ 15.05.13 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Programa utilizado para a extracao de pedidos.             ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe e ≥ Void DAI001(void)                                          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ Faturamento                                                ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
USER FUNCTION DAI001()

Local cDirDocs   := MsDocPath()
Local cArquivo   := GetNextAlias()
Local oExcelApp
Local cQuery
Local cPerg	     := AllTrim( "DA_EXPEDIC" )

Local aFiltro
Local lContinua  := .T.
Local lChkAberto := .T.
Local lChkLibFat := .T.
Local lChkFatura := .T.
Local lChkBlqCre := .T.
Local lChkExpedi := .T.
Local lChkBlqEst := .T.
Local lChkRejeit := .T.
Local oChkAberto
Local oChkLibFat
Local oChkFatura
Local oChkBlqCre
Local oChkExpedi
Local oChkBlqEst
Local oChkRejeit
	

	AjustaSx1(cPerg)
	While .T.
		IF Pergunte( cPerg, .T. )
			IF MV_PAR09 == 1
				DEFINE MSDIALOG oDlg FROM 0,0 TO 220,350 PIXEL TITLE "Filtro Status"
				
				@ 10,20 CheckBox oChkAberto Var lChkAberto Prompt "Aberto"                Size 70,50 PIXEL OF oDlg
				@ 20,20 CheckBox oChkLibFat Var lChkLibFat Prompt "Liberado para Faturar" Size 70,50 PIXEL OF oDlg
				@ 30,20 CheckBox oChkFatura Var lChkFatura Prompt "Faturado"              Size 70,50 PIXEL OF oDlg
				@ 40,20 CheckBox oChkBlqCre Var lChkBlqCre Prompt "Bloqueado - Credito"   Size 70,50 PIXEL OF oDlg
				@ 50,20 CheckBox oChkExpedi Var lChkExpedi Prompt "Aguardando Expedicao"  Size 70,50 PIXEL OF oDlg
				@ 60,20 CheckBox oChkBlqEst Var lChkBlqEst Prompt "Bloqueado - Estoque"   Size 70,50 PIXEL OF oDlg
				@ 70,20 CheckBox oChkRejeit Var lChkRejeit Prompt "Rejeitado"             Size 70,50 PIXEL OF oDlg
				
				@ 90, 20 BUTTON oButton PROMPT "   Ok   " OF oDlg PIXEL ACTION ( oDlg:End(), lContinua := .T. )
				@ 90,100 BUTTON oButton PROMPT "Cancelar" OF oDlg PIXEL ACTION ( oDlg:End(), lContinua := .F. )
				ACTIVATE MSDIALOG oDlg CENTERED
				
				aFiltro := {}
				If lChkAberto
					AADD( aFiltro, "Aberto" )
				EndIf
				If lChkLibFat
					AADD( aFiltro, "Liberado para Faturar" )
				EndIf
				If lChkFatura
					AADD( aFiltro, "Faturado" )
				EndIf
				If lChkBlqCre
					AADD( aFiltro, "Bloqueado - Credito" )
				EndIf
				If lChkExpedi
					AADD( aFiltro, "Aguardando Expedicao" )
				EndIf
				If lChkBlqEst
					AADD( aFiltro, "Bloqueado - Estoque" )
				EndIf
				If lChkRejeit
					AADD( aFiltro, "Rejeitado" )
				EndIf
				Exit
			Else
				lContinua := .T.
				Exit
			EndIf
		Else
			lContinua := .F.
			Exit
		Endif
	ENDDO
	
	IF lContinua
		
		If ApOleClient( "MsExcel" )
			
			If Select("TRB1") > 0
				DBSelectArea("TRB1")
				DBCloseArea("TRB1")
			EndIf
			
			cQuery := "SELECT DISTINCT SC5.C5_CLIENTE COD, SC5.C5_LOJACLI  LOJA, SA1.A1_NOME NOME, SC5.C5_PEDCLI PEDCLI,SC5.C5_EMISSAO EMISSAO," + CRLF
			cQuery +=                 "SC6.C6_ENTREG ENTREGA,SC5.C5_NUM PEDIDO,SC6.C6_ITEM ITEM,SC5.C5_TIPO TIPOP,SC5.C5_TIPOCLI TIPOC, SC6.C6_PRODUTO CODIGO, " + CRLF
			
			cQuery += " CASE  WHEN SC5.C5_NOTA = '' AND SC5.C5_LIBEROK = '' AND SC5.C5_BLQ = '' THEN 'Aberto'  " + CRLF
			//		cQuery += "       WHEN SC5.C5_NOTA <> '' AND SC5.C5_LIBEROK = 'E' AND SC5.C5_BLQ = '' THEN 'Encerrado'  " + CRLF
			//		cQuery += "       WHEN SC5.C5_NOTA = '' AND SC5.C5_LIBEROK != '' AND SC5.C5_BLQ = '' THEN  'Liberado'   " + CRLF
			//		cQuery += "       WHEN SC5.C5_BLQ <> '' THEN  'Bloqueado'  end ESTATUS, " + CRLF
			
			cQuery += "       WHEN SC9.C9_BLEST ='  ' And SC9.C9_BLCRED = '  ' And (SC9.C9_BLWMS >= '05' OR SC9.C9_BLWMS = '  ') THEN 'Liberado para Faturar' " + CRLF
			cQuery += "       WHEN (SC9.C9_BLCRED ='10' And SC9.C9_BLEST  = '10') OR (SC9.C9_BLCRED ='ZZ' And SC9.C9_BLEST  = 'ZZ') THEN 'Faturado' "  + CRLF
			cQuery += "       WHEN SC9.C9_BLCRED NOT IN ('  ','09','10','ZZ') THEN 'Bloqueado - Credito' " + CRLF
			cQuery += "       WHEN SC9.C9_BLEST ='XX' AND SC9.C9_BLCRED NOT IN ('09','10','ZZ') THEN 'Aguardando a expedicao' " + CRLF
			cQuery += "       WHEN SC9.C9_BLCRED NOT IN ('09') AND SC9.C9_BLEST NOT IN ('  ','10','ZZ') THEN 'Bloqueado - Estoque' " + CRLF
			cQuery += "       WHEN SC9.C9_BLCRED = '09' THEN  'Rejeitado' " + CRLF
			cQuery += " END ESTATUS, " + CRLF
			
			cQuery += " SC6.C6_XCODANT CODDAISA,SC6.C6_PRODUTO PRODUTO," + CRLF
			cQuery += " SC6.C6_QTDVEN QUANT,SC6.C6_PRUNIT PRECO,SC6.C6_VALOR VALOR," + CRLF
			//		cQuery += " SC6.C6_QTDVEN QUANT,SC6.C6_PRUNIT PRECO,DA1.DA1_PRCVEN UNITARIO,SC6.C6_VALOR VALOR," + CRLF
			//		cQuery += " SC6.C6_VALIPI IPI,SC6.C6_VALICM ICM,SC6.C6_VALICM-SC6.C6_ICMSRET ICMST," + CRLF
			cQuery += " SA1.A1_DESC DESCCLI,SC5.C5_DESC1 DESCPED,SC5.C5_DESC2 DESCPED2,SC5.C5_DESC3 DESCPED3,SC5.C5_DESC4 DESCPED4,SC6.C6_DESCONT DESCIT, " + CRLF
			cQuery += " SA3.A3_NOME VENDEDOR,SC5.C5_COMIS1 COMISSAO," + CRLF
			cQuery += " CASE  " + CRLF
			cQuery += "     WHEN SC5.C5_TIPOCLI = 'F' THEN 'Cons. Final'  " + CRLF
			cQuery += "     WHEN SC5.C5_TIPOCLI = 'L' THEN 'Prod. Rural'  " + CRLF
			cQuery += "     WHEN SC5.C5_TIPOCLI = 'R' THEN 'Revendedor'  " + CRLF
			cQuery += "     WHEN SC5.C5_TIPOCLI = 'S' THEN 'Solidario'  " + CRLF
			cQuery += "     WHEN SC5.C5_TIPOCLI = 'X' THEN 'Exportacao/Importacao'  " + CRLF
			cQuery += " END TIPO, " + CRLF
			cQuery += " SC6.C6_TES TES,SC6.C6_CF CFOP,SX5.X5_DESCRI DESC_CFOP,SC5.C5_LIBEROK LIBERA " + CRLF
			cQuery += " FROM " + CRLF
			cQuery +=        RetSqlName("SC5") +"  SC5, " + CRLF
			cQuery +=        RetSqlName("SC9") +"  SC9, " + CRLF
			//		cQuery +=        RetSqlName("DA1") +"  DA1, " + CRLF
			cQuery +=        RetSqlName("SA1") +" SA1," + CRLF
			cQuery +=        RetSqlName("SC6") +" SC6, " + CRLF
			cQuery +=        RetSqlName("SA3") +" SA3, " + CRLF
			cQuery +=        RetSqlName("SB1") +" SB1, " + CRLF
			cQuery +=        RetSqlName("SX5") +" SX5 " + CRLF
			cQuery += " WHERE "
			cQuery +=        "SC5.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SA1.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SC9.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SC6.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SA3.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SB1.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SC5.C5_EMISSAO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "' AND " + CRLF
			cQuery +=        "SC6.C6_ENTREG BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' AND " + CRLF
			cQuery +=        "SC5.C5_CLIENTE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' AND " + CRLF
			cQuery +=        "SC5.C5_VEND1 BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' AND " + CRLF
			
			cQuery +=        "SC5.C5_CLIENTE = SA1.A1_COD AND " + CRLF
			cQuery +=        "SC5.C5_LOJACLI = SA1.A1_LOJA AND " + CRLF
			
			cQuery +=        "SC5.C5_NUM = SC6.C6_NUM AND " + CRLF
			cQuery +=        "SC6.C6_NUM = SC9.C9_PEDIDO AND " + CRLF
			cQuery +=        "SC6.C6_PRODUTO = SC9.C9_PRODUTO AND " + CRLF
			cQuery +=        "SC6.C6_ITEM    = SC9.C9_ITEM AND " + CRLF
			
			cQuery +=        "SA3.A3_COD = SC5.C5_VEND1 AND " + CRLF
			cQuery +=        "SC6.C6_PRODUTO = SB1.B1_COD AND " + CRLF
			cQuery +=        "SC5.C5_TIPO NOT IN ('B','D') AND " + CRLF
			//		cQuery +=        "SC6.C6_PRODUTO = DA1.DA1_CODPRO AND " + CRLF
			//		cQuery +=        "DA1.DA1_ATIVO = '1' AND          " + CRLF
			//		cQuery +=        "DA1.DA1_CODTAB = SC5.C5_TABELA AND " + CRLF
			cQuery +=        "SX5.X5_TABELA = '13' AND X5_CHAVE = SC6.C6_CF " + CRLF
			
			// query adicionada para traser os pedidos de status aberto
			cQuery += "UNION SELECT SC5.C5_CLIENTE COD,SC5.C5_LOJACLI  LOJA,SA1.A1_NOME NOME,SC5.C5_PEDCLI PEDCLI,SC5.C5_EMISSAO EMISSAO," + CRLF
			cQuery +=              "SC6.C6_ENTREG ENTREGA,SC5.C5_NUM PEDIDO,SC6.C6_ITEM ITEM,SC5.C5_TIPO TIPOP,SC5.C5_TIPOCLI TIPOC,SC6.C6_PRODUTO CODIGO, " + CRLF
			
			cQuery += " CASE WHEN SC5.C5_NOTA = '' AND SC5.C5_LIBEROK = '' AND SC5.C5_BLQ = '' THEN 'Aberto' " + CRLF
			cQuery += " END ESTATUS, " + CRLF
			
			cQuery += " SC6.C6_XCODANT CODDAISA,SC6.C6_PRODUTO PRODUTO, " + CRLF
			cQuery += " SC6.C6_QTDVEN QUANT,SC6.C6_PRUNIT PRECO,SC6.C6_VALOR VALOR, " + CRLF
			
			cQuery += " SA1.A1_DESC DESCCLI,SC5.C5_DESC1 DESCPED,SC5.C5_DESC2 DESCPED2,SC5.C5_DESC3 DESCPED3,SC5.C5_DESC4 DESCPED4,SC6.C6_DESCONT DESCIT, " + CRLF
			cQuery += " SA3.A3_NOME VENDEDOR,SC5.C5_COMIS1 COMISSAO, " + CRLF
			cQuery += " CASE " + CRLF
			cQuery +=        "WHEN SC5.C5_TIPOCLI = 'F' THEN 'Cons. Final' " + CRLF
			cQuery +=        "WHEN SC5.C5_TIPOCLI = 'L' THEN 'Prod. Rural' " + CRLF
			cQuery +=        "WHEN SC5.C5_TIPOCLI = 'R' THEN 'Revendedor' " + CRLF
			cQuery +=        "WHEN SC5.C5_TIPOCLI = 'S' THEN 'Solidario' " + CRLF
			cQuery +=        "WHEN SC5.C5_TIPOCLI = 'X' THEN 'Exportacao/Importacao' " + CRLF
			cQuery += " END TIPO, " + CRLF
			cQuery += " SC6.C6_TES TES,SC6.C6_CF CFOP,SX5.X5_DESCRI DESC_CFOP,SC5.C5_LIBEROK LIBERA " + CRLF
			cQuery += " FROM " + CRLF
			cQuery +=        RetSqlName("SC5") +"  SC5, " + CRLF
			cQuery +=        RetSqlName("SC9") +"  SC9, " + CRLF
			//		cQuery +=        RetSqlName("DA1") +"  DA1, " + CRLF
			cQuery +=        RetSqlName("SA1") +" SA1," + CRLF
			cQuery +=        RetSqlName("SC6") +" SC6, " + CRLF
			cQuery +=        RetSqlName("SA3") +" SA3, " + CRLF
			cQuery +=        RetSqlName("SB1") +" SB1," + CRLF
			cQuery +=        RetSqlName("SX5") +" SX5 " + CRLF
			cQuery += " WHERE " + CRLF
			cQuery +=        "SC5.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SA1.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SC9.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SC6.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SA3.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SB1.D_E_L_E_T_ = '' AND " + CRLF
			cQuery +=        "SC5.C5_EMISSAO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "' AND " + CRLF
			cQuery +=        "SC6.C6_ENTREG BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' AND " + CRLF
			cQuery +=        "SC5.C5_CLIENTE BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' AND " + CRLF
			cQuery +=        "SC5.C5_VEND1 BETWEEN '" + MV_PAR07+"' AND '"+MV_PAR08 + "' AND " + CRLF
			
			cQuery +=        "SC5.C5_CLIENTE = SA1.A1_COD AND " + CRLF
			cQuery +=        "SC5.C5_LOJACLI = SA1.A1_LOJA AND " + CRLF
			cQuery +=        "SC5.C5_NUM = SC6.C6_NUM AND " + CRLF
			cQuery +=        "SA3.A3_COD = SC5.C5_VEND1 AND " + CRLF
			cQuery +=        "SC6.C6_PRODUTO = SB1.B1_COD AND " + CRLF
			cQuery +=        "SC5.C5_TIPO NOT IN ('B','D') AND " + CRLF
			cQuery +=        "SX5.X5_TABELA = '13' AND X5_CHAVE = SC6.C6_CF " + CRLF
			
			// Valida Query
			cQuery := ChangeQuery(cQuery)
			MsAguarde({|| DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
			
			// Gera o Arquivo para o Excel
			MsAguarde({|| GeraArq( cDirDocs, cArquivo, aFiltro ) }, "Gerando o arquivo...") //"Gerando o arquivo..."
			
			// Copia o Arquivo gerado para a maquina local
			CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , "C:\TEMP\", .T. )
			
			// Renomeia o arquivo arquivo gerado
			__CopyFIle("C:\TEMP\"+cArquivo+".DBF", "C:\TEMP\"+cArquivo+".XLS")
			
			// Apaga o arquivo temporario
			FErase("C:\TEMP\"+cArquivo+".DBF")
			
			// Realiza a abertura do Excel
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( "c:\temp\"+cArquivo+".XLS" ) // Abre uma planilha
			oExcelApp:SetVisible(.T.)
			DBSelectArea("TRB1")
			DBCloseArea()
			
		Else
			MsgStop( "Erro. Excel nao encontrado." )
		EndIf
		
	EndIf
					
Return 


/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ GeraArq  ≥ Autor ≥ Edilson Nascimento    ≥ Data ≥ 04.10.13 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Rotina responsavel em gerar o arquivo para o excel.        ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Sintaxe e ≥ Void GeraArq(<cString1>, <cString2>, <aArray> )            ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ Faturamento                                                ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
STATIC Procedure GeraArq( cCaminho, cArquivo, aFiltro )

Local aStru
Local lGrava

	aStru := { ;
	           {"PEDIDO"   , "C", 06, 0},;
	           {"CLIENTE", "C", 06, 0},;
	           {"LOJA"		, "C", 02, 0},;
	           {"NOME"		, "C", 50, 0},;
	           {"PEDCLI"	, "C", 15, 0},;
	           {"EMISSAO" 	, "D", 08, 0},;
	           {"ENTREGA" 	, "D", 08, 0},;
	           {"ESTATUS"	, "C", 15, 0},;
	           {"CODDAISA"	, "C", 30, 0},;
	           {"CODIGO"	, "C", 30, 0},;
	           {"QUANT"	, "N", 17, 2},;
	           {"PRECO"	, "N", 17, 2},; //<<//{"VLR_TABELA"	, "N", 17, 2},;
	           {"VALOR"	, "N", 17, 2},;
	           {"IPI"	, "N", 17, 2},;
	           {"ICMS"	, "N", 17, 2},;
	           {"ICMST"	, "N", 17, 2},;
	           {"DESCCLI"	, "N", 06, 2},;
	           {"DESCPED"	, "N", 06, 2},;
	           {"DESCPED2"	, "N", 06, 2},;
	           {"DESCPED3"	, "N", 06, 2},;
	           {"DESCPED4"	, "N", 06, 2},;
	           {"DESCIT"	, "N", 06, 2},;
	           {"VENDEDOR"	, "C", 40, 0},;
	           {"COMISSAO"	, "N", 06, 2},;
	           {"TIPO"	 	, "C", 15, 0},;
	           {"TES"		, "C", 03, 0},;
	           {"CFOP"	, "C", 04, 0}   ,;
	           {"DCFOP"	, "C", 25, 0}   }
	
	//{"VLR_TABELA"	, "N", 17, 2},;
	
	DBCreate( cCaminho + "\" + cArquivo, aStru, "dbfcdxads")
	DBUseArea(.T.,"dbfcdxads", cCaminho + "\" + cArquivo, cArquivo, .F., .F.)
	
	TRB1->(DBGoTop())
	While .Not. TRB1->( Eof() )
		
		VAL_IPI := 0
		VAL_TOT := 0
		VAL_ST  := 0
		ST_AUX  := 0
		
		nItem := 1
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
		         TRB1->PRECO,;//TRB1->UNITARIO,;		  	// 4-Preco Unitario ( Obrigatorio )
		         TRB1->DESCIT,; 	// 5-Valor do Desconto ( Opcional )
		         "",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
		         "",;				// 7-Serie da NF Original ( Devolucao/Benef )
		         0,;					// 8-RecNo da NF Original no arq SD1/SD2
		         0,;					// 9-Valor do Frete do Item ( Opcional )
		         0,;					// 10-Valor da Despesa do item ( Opcional )
		         0,;					// 11-Valor do Seguro do item ( Opcional )
		         0,;					// 12-Valor do Frete Autonomo ( Opcional )
		         TRB1->VALOR,;			// 13-Valor da Mercadoria ( Obrigatorio )
		         0)					// 14-Valor da Embalagem ( Opiconal )
		
		VAL_IPI := MaFisRet(nItem,"IT_VALIPI")
		VAL_TOT := MaFisRet(nItem,"IT_VALICM")
		VAL_ST  := IIF(MaFisRet(nItem,"IT_VALSOL")>0,MaFisRet(nItem,"IT_VALSOL"),0)
		
		//IF MV_PAR09 == ESTATUS
		If .NOT. Empty(TRB1->ESTATUS)
			
			If MV_PAR09 == 1
				If Ascan( aFiltro, { |xItem| Upper(xItem) == AllTrim( Upper( TRB1->ESTATUS ) ) } ) > 0
					lGrava := .T.
				Else
					lGrava := .F.
				Endif
			Else
				lGrava := .T.
			EndIf
			
			If lGrava
				RecLock(cArquivo, .T.)
				(cArquivo)->CLIENTE  := TRB1->COD
				(cArquivo)->LOJA     := TRB1->LOJA
				(cArquivo)->NOME     := TRB1->NOME
				(cArquivo)->PEDCLI   := TRB1->PEDCLI
				(cArquivo)->EMISSAO  := STOD(TRB1->EMISSAO)
				(cArquivo)->ENTREGA  := STOD(TRB1->ENTREGA)
				(cArquivo)->PEDIDO   := TRB1->PEDIDO
				(cArquivo)->ESTATUS  := TRB1->ESTATUS
				(cArquivo)->CODDAISA := TRB1->CODDAISA
				(cArquivo)->CODIGO   := TRB1->CODIGO
				(cArquivo)->QUANT    := TRB1->QUANT
				(cArquivo)->PRECO    := TRB1->PRECO
				(cArquivo)->VALOR    := TRB1->VALOR
				(cArquivo)->ICMS     := VAL_TOT
				(cArquivo)->ICMST    := VAL_ST
				(cArquivo)->IPI      := VAL_IPI
				(cArquivo)->DESCCLI  := TRB1->DESCCLI
				(cArquivo)->DESCPED  := TRB1->DESCPED
				(cArquivo)->DESCPED2 := TRB1->DESCPED2
				(cArquivo)->DESCPED3 := TRB1->DESCPED3
				(cArquivo)->DESCPED4 := TRB1->DESCPED4
				(cArquivo)->DESCIT   := TRB1->DESCIT
				(cArquivo)->VENDEDOR := TRB1->VENDEDOR
				(cArquivo)->COMISSAO := TRB1->COMISSAO
				(cArquivo)->TIPO	  := TRB1->TIPO
				(cArquivo)->CFOP	  := TRB1->CFOP
				(cArquivo)->DCFOP	  := TRB1->DESC_CFOP
				(cArquivo)->TES		  := TRB1->TES
				(cArquivo)->( MSUnLock() )
				//	END IF   //	(cArquivo)->VLR_TABELA	:= TRB1->UNITARIO
			EndIf
		EndIF
		TRB1->( DBSkip() )
		
	ENDDO
	
	DBSelectArea(cArquivo)
	DBCloseArea()
			
Return



/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥AjustaSX1 ≥ Autor ≥ Edilson Nascimento    ≥ Data ≥ 15.05.13 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Rotina responsavel em verificar e criar o grupo de         ≥±±
±±≥          ≥ perguntas para a rotina de extracao de pedido.             ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ DAI001                                                     ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Procedure AjustaSX1( cPerg )

Local nPos
Local aRea := GetArea()
Local aSx1 := {}

	DBSelectArea("SX1")
	SX1->(DBSetOrder(1))
	IF .NOT. SX1->( DBSeek( cPerg ) ) //  + "01" ) )
		
		AADD( aSx1,{ cPerg, "01", "Emissao de"     ,"MV_PAR" ,"D",08,0,0,"G", "MV_PAR01",         "","","","","","","" } )
		AADD( aSx1,{ cPerg, "02", "Emissao ate"    ,"MV_PAR" ,"D",08,0,0,"G", "MV_PAR02",         "","","","","","","" } )
		AADD( aSx1,{ cPerg, "03", "Entrega de"     ,"MV_PAR" ,"D",08,0,0,"G", "MV_PAR03",         "","","","","","","" } )
		AADD( aSx1,{ cPerg, "04", "Entrega ate"	    ,"MV_PAR" ,"D",08,0,0,"G", "MV_PAR04",         "","","","","","","" } )
		AADD( aSx1,{ cPerg, "05", "Cliente de"     ,"MV_PAR" ,"C",06,0,0,"G", "MV_PAR05",         "","","","","","SA1","" } )
		AADD( aSx1,{ cPerg, "06", "Cliente ate"    ,"MV_PAR" ,"C",06,0,0,"G", "MV_PAR06",         "","","","","","SA1","" } )
		AADD( aSx1,{ cPerg, "07", "Vendedor de"    ,"MV_PAR" ,"C",06,0,0,"G", "MV_PAR07",         "","","","","","SA3","" } )
		AADD( aSx1,{ cPerg, "08", "Vendedor ate"   ,"MV_PAR" ,"C",06,0,0,"G", "MV_PAR08",         "","","","","","SA3","" } )
		AADD( aSx1,{ cPerg, "09", "Filtrar Status" ,"MV_PAR" ,"N",01,0,0,"C", "MV_PAR09", "Sim","Nao","","","","","" } )
		
		// If SX1->X1_GRUPO != cPerg
			For nPos := 1 To Len( aSx1 )
				If !SX1->( DBSeek( aSx1[ nPos ][1] + aSx1[ nPos ][2] ) )
					Reclock( "SX1", .T. )
					SX1->X1_GRUPO    := aSx1[ nPos ][1] //Grupo
					SX1->X1_ORDEM    := aSx1[ nPos ][2] //Ordem do campo
					SX1->X1_PERGUNT  := aSx1[ nPos ][3] //Pergunta
					SX1->X1_PERSPA   := aSx1[ nPos ][3] //Pergunta Espanhol
					SX1->X1_PERENG   := aSx1[ nPos ][3] //Pergunta Ingles
					SX1->X1_VARIAVL  := aSx1[ nPos ][4] //Variavel do campo
					SX1->X1_TIPO     := aSx1[ nPos ][5] //Tipo de valor
					SX1->X1_TAMANHO  := aSx1[ nPos ][6] //Tamanho do campo
					SX1->X1_DECIMAL  := aSx1[ nPos ][7] //Formato numerico
					SX1->X1_PRESEL   := aSx1[ nPos ][8] //Pre seleÁ„o do combo
					SX1->X1_GSC      := aSx1[ nPos ][9] //Tipo de componente
					SX1->X1_VAR01    := aSx1[ nPos ][10]//Variavel que carrega resposta
					SX1->X1_DEF01    := aSx1[ nPos ][11]//DefiniÁıes do combo-box
					SX1->X1_DEF02    := aSx1[ nPos ][12]
					SX1->X1_DEF03    := aSx1[ nPos ][13]
					SX1->X1_DEF04    := aSx1[ nPos ][14]
					SX1->X1_VALID    := aSx1[ nPos ][15]
					SX1->X1_F3       := aSx1[ nPos ][16]
					MsUnlock()
				Endif
			Next
		// Endif
		
	EndIf
	
	RestArea(aRea)

Return
