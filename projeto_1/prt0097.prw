#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PRT0097   ºAutor  ³Felipe Basso      º Data ³  16-09-11    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Etiqueta para a Tela de Expedição                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PRT0097(vFilial, vPedido, vSeq_Pedido, vVolIni, vVolFim)
	
	LOCAL aArea          := GetArea()
  	LOCAL lRetorno       := .F.
	Private vpFilial 	 := vFilial
	Private vpPedido 	 := vPedido
	Private vpSeq_Pedido := vSeq_Pedido
	Private vpVolIni     := vVolIni
	Private vpVolFim     := vVolFim
	
	RptStatus({|lEnd| Processo()},"PRT0097 - IMPRIMINDO ...")
	PRT0097->(DBCloseArea())
	PRT97_1->(DBCloseArea())
	PRT97_2->(DBCloseArea())
	RestArea(aArea)
	lRetorno             := .T.
Return(lRetorno)

Static Function VerTabela(tab)
	If SELECT(tab) > 0
  		dbSelectArea(tab)
  		dbCloseArea(tab)
 	Endif
Return

Static Function vSelect()
	Local vQuery := nil

	//total
	vQuery := "SELECT MAX(SZD.ZD_VOLUME) AS TOT_VOLUME";
		    	+ " FROM "+RetSqlName("SZD")+" SZD";
    			+ " WHERE ZD_FILIAL = '"	+ ALLTRIM(vpFilial) 	+ "'";
		    	+ " AND ZD_PEDIDO = '"		+ ALLTRIM(vpPedido)	+ "'";
   				+ " AND D_E_L_E_T_ <> '*'"
	VerTabela("PRT97_1")
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,vQuery),"PRT97_1",.F.,.T.)
	
	//razão social do cliente
	vQuery := " select sa1.a1_nreduz";
		    	+ " from "+RetSqlName("SC5")+" sc5";
		    	+ "  join "+RetSqlName("SA1")+" sa1";
		    	+ "    on sa1.a1_cod = sc5.c5_cliente";
		    	+ "    and sa1.D_E_L_E_T_ <> '*'"
		    	+ " where sc5.c5_filial = '"	+ ALLTRIM(vpFilial) 	+ "'";
		    	+ " and sc5.c5_num = '"		+ ALLTRIM(vpPedido)	+ "'"
		    	+ " and sc5.D_E_L_E_T_ <> '*'"
	VerTabela("PRT97_2")
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,vQuery),"PRT97_2",.F.,.T.)
	
	//-- Executa a query com os filtros  -----------------------------------------------------------------------
	vQuery := "select SZD.ZD_VOLUME,SZD.ZD_QTDVOL,SC6.C6_NOTA,SC6.C6_DESCRI,SB1.B1_PESO";
          + " from " + RetSQLName("SZD") +" SZD";
          + "  join " + RetSQLName("SC6") +" SC6";
          + "    on SC6.C6_FILIAL = SZD.ZD_FILIAL";
          + "    and SC6.C6_NUM = SZD.ZD_PEDIDO";
          + "    and SC6.C6_ITEM = SZD.ZD_ITEMPV";
          + "    and SC6.D_E_L_E_T_ <> '*'";
          + "  join " + RetSQLName("SB1") +" SB1";
          + "    on SB1.B1_FILIAL = SZD.ZD_FILIAL";
          + "    and SB1.B1_COD = SC6.C6_PRODUTO";
          + "    and SB1.D_E_L_E_T_ <> '*'";
          + " where SZD.ZD_FILIAL = '" 	+ vpFilial  + "'";
          + " and SZD.ZD_PEDIDO = '" 		+ ALLTRIM(vpPedido) + "'";
          + " and SZD.ZD_ITEMPV = '"	+ ALLTRIM(vpSeq_Pedido)	+ "'";
          + " and SZD.ZD_VOLUME between "+cValToChar(vpVolIni)+" and "+cValToChar(vpVolFim);
          + " order by SZD.ZD_VOLUME"
  VerTabela("PRT0097")
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,vQuery),"PRT0097",.F.,.T.)
Return()

Static Function PROCESSO()
	vSelect()
	PRT0097->(DbGotop())
	//-- Roda os Itens do Pedido ---------------------------------------------------------------------------------------------------
	While !PRT0097->(EOF())
		vLinha := 0

		Imprime(vLinha)
		PRT0097->(dbSkip())
	EndDo
Return()
         
Static Function Imprime(vLinha)
	PRIVATE cLogo		:= ""

	//-- Início do Relatório -------------------------------------------------------------------------------------------------------
	DO CASE
  		Case vpFilial == "01"//DAISA MATRIZ
   			cLogo  := '\system\logo_daisa.grf'
  		Case vpFilial == "02"//FUNDICAO
   			cLogo  := '\system\logo_fundicao.grf'
  		Case vpFilial == "03"//DAIBRAS
   			cLogo  := '\system\logo_daibras.grf'
  		Case vpFilial == "04"//DAISA INDUSTRIAL
   			cLogo  := '\system\logo_daisa.grf'
  		Case vpFilial == "05"//DAISA COMERCIO
   			cLogo  := '\system\logo_daisa.grf'
  		Case vpFilial == "99"//EMPRESA TESTE
   			cLogo  := '\system\logo_daisa.grf'
	ENDCASE
 

	//for vIdxVolume := 1 to PRT_TOTAL->TOT_VOLUME
		ImprimeZEBRA(vLinha, cLogo)

		/*
		DO CASE
  			CASE (vRelatorio == "ZEBRA") 	.OR. (vRelatorio == "ELTRON")
  				ImprimeZEBRA_ELTRON(vLinha, vIdxVolume, Total, vRelatorio, cLogo)
  			CASE (vRelatorio == "DATAMAX") 	.OR. (vRelatorio == "INTERMEC")
  				ImprimeDATAMAX_INTERMEC(vLinha, vIdxVolume, Total, vRelatorio, cLogo)
		ENDCASE
		*/
	//next
    //------------------------------------------------------------------------------------------------------------------------------
Return(.T.) 

Static Function ImprimeZEBRA(vLinha, cLogo)
    LOCAL vPorta		:= ""
    LOCAL vImpressora	:= {}

	AADD(vImpressora, "Z105-se")
	AADD(vImpressora, "S600-10100000")
	AADD(vImpressora, "105SL tm")

	MSCBPRINTER(vImpressora[1], vPorta, 600,,.F.,,,,)

	MSCBBEGIN(1,6)
	MSCBCHKStatus(.T.)

	//-- Grade ---------------------------------------------------------------------------------------------------------------------
	MSCBLineH(68,	75,		950,	3)
	MSCBLineV(68,	75,		940,	3)
	MSCBLineV(68,	950,	940,	3)
	MSCBLineH(200,	75,		950,	3)
	MSCBLineH(300,	75,		950,	3)
	MSCBLineV(302,	610,	880, 	3)
	MSCBLineV(302,	770,	1080, 	3)
	MSCBLineH(418,	75, 	950,	3)
	MSCBLineH(920, 	75, 	950,	3)
	MSCBLineH(960, 	75, 	950,	3)
	//------------------------------------------------------------------------------------------------------------------------------

	vLinha := 70

	//-- Cabeçalho -----------------------------------------------------------------------------------------------------------------

	//-- Logotipo ------------------------------------------------------------------------------------------------------------------
	//MSCBLOADGRF(cLogo)
	//MSCBGRAFIC(vLinha, 80, SUBSTR(@cLogo, 1, LEN(@cLogo) - 4), .T.)
	//------------------------------------------------------------------------------------------------------------------------------

	vLinha += 20

	//-- Textos Fixos --------------------------------------------------------------------------------------------------------------
	MSCBSAY(vLinha,320,"VENDAS: (11) 5094-9988 / vendas@daisa.com","N","0","09")

	vLinha += 30

   	MSCBSAY(vLinha,320,"FÁBRICA: (11) 4704-5522 / fabrica@daisa.com","N", "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                    
	vLinha += 80

	//-- Bloco "Cliente", "Pedido" e "NF" ---------------------------------------------------------------------------------------
	MSCBSAY(vLinha,320,SUBSTR("Cliente:" + Space(2) + ALLTRIM(PRT97_2->A1_NREDUZ), 1, 80), "N", "0", "09")

	vLinha += 60

	MSCBSAY(vLinha,80,	ALLTRIM(SUBSTR("Pedido:" + Space(2) + vpPedido, 1, 64)), 	 "N", "0", "09")
	MSCBSAY(vLinha,600, ALLTRIM(SUBSTR("NF:" + Space(2) + PRT0097->C6_NOTA, 1, 15)), "N", "0", "09")
	//---------------------------------------------------------------------------------------------------------------------------

	vLinha += 80

	//-- Bloco Título da Grid ---------------------------------------------------------------------------------------------------
	MSCBSAY(vLinha,80,  "Código", 	"N", "0", "09")
	MSCBSAY(vLinha,665, "Qtde", 	"N", "0", "09")
	MSCBSAY(vLinha,825, "Peso",		"N", "0", "09")
	//---------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------

	//-- Itens ---------------------------------------------------------------------------------------------------------------------
	vLinha += 40

	Codigo("N")  

	MSCBSAY(vLinha,650, TRANSFORM(PRT0097->ZD_QTDVOL, 	"@E 99,99.99"), "N", "0", "09")
	MSCBSAY(vLinha,810, TRANSFORM(PRT0097->B1_PESO,		"@E 99,99.99"), "N", "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------

	//-- Rodapé --------------------------------------------------------------------------------------------------------------------
	vLinha += 520

	MSCBSAY(vLinha,85,  "P. Bruto:"	+ Space(1) + TRANSFORM(PRT0097->B1_PESO + (PRT0097->B1_PESO * 0.10), "@E 99,99.99"), "N", "0", "09")
	MSCBSAY(vLinha,450, "P. Líq.:"	+ Space(1) + TRANSFORM(PRT0097->B1_PESO, "@E 99,99.99"), "N", "0", "09")
	MSCBSAY(vLinha,670, "Vol.:"		+ Space(1) + ALLTRIM(STR(PRT0097->ZD_VOLUME)) + "/" + ALLTRIM(STR(PRT97_1->TOT_VOLUME)), "N", "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------

   	MSCBEND()
Return()

/*
Static Function ImprimeZEBRA_ELTRON(vLinha, vIdx, vTotal, vRelatorio, cLogo)
    LOCAL vPorta		:= ""
    LOCAL vImpressora	:= {}

	DO CASE
		CASE vRelatorio == "ZEBRA"
			AADD(vImpressora, "S300")
			AADD(vImpressora, "S400")
			AADD(vImpressora, "S500-6")
			AADD(vImpressora, "S500-8")
			AADD(vImpressora, "Z105S-6")
			AADD(vImpressora, "Z105S-8")
			AADD(vImpressora, "Z160S-6")
			AADD(vImpressora, "Z160S-8")
			AADD(vImpressora, "Z140XI")
			AADD(vImpressora, "S600")
			AADD(vImpressora, "Z4M")
			AADD(vImpressora, "Z90XI")
			AADD(vImpressora, "Z170XI")
			AADD(vImpressora, "ZEBRA")
		CASE vRelatorio == "ELTRON"
			AADD(vImpressora, "ELTRON")
			AADD(vImpressora, "TLP 2722")
			AADD(vImpressora, "TLP 2742")
			AADD(vImpressora, "TLP 2844")
			AADD(vImpressora, "TLP 3742")
			AADD(vImpressora, "C4-8")
	ENDCASE

	MSCBPRINTER(vImpressora[1], vPorta, 600,,.F.,,,,)

	MSCBBEGIN(1,6)
	MSCBCHKStatus(.T.)

	//-- Grade ---------------------------------------------------------------------------------------------------------------------
	MSCBLineH(68,	75,		950,	3)
	MSCBLineV(68,	75,		940,	3)
	MSCBLineV(68,	950,	940,	3)
	MSCBLineH(200,	75,		950,	3)
	MSCBLineH(300,	75,		950,	3)
	MSCBLineV(302,	610,	880, 	3)
	MSCBLineV(302,	770,	1080, 	3)
	MSCBLineH(418,	75, 	950,	3)
	MSCBLineH(920, 	75, 	950,	3)
	MSCBLineH(960, 	75, 	950,	3)
	//------------------------------------------------------------------------------------------------------------------------------

	vLinha := 70

	//-- Cabeçalho -----------------------------------------------------------------------------------------------------------------

	//-- Logotipo ------------------------------------------------------------------------------------------------------------------
	//MSCBLOADGRF(cLogo)
	//MSCBGRAFIC(vLinha, 80, SUBSTR(@cLogo, 1, LEN(@cLogo) - 4), .T.)
	//------------------------------------------------------------------------------------------------------------------------------

	vLinha += 20

	//-- Textos Fixos --------------------------------------------------------------------------------------------------------------
	MSCBSAY(vLinha,320,"VENDAS: (11) 5094-9988 / vendas@daisa.com","N","0","09")

	vLinha += 30

   	MSCBSAY(vLinha,320,"FÁBRICA: (11) 4704-5522 / fabrica@daisa.com","N", "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                    
	vLinha += 80

	//-- Bloco "Cliente", "Pedido" e "NF" ---------------------------------------------------------------------------------------
	MSCBSAY(vLinha,320,SUBSTR("Cliente:" + Space(2) + ALLTRIM(PRT97_2->A1_NREDUZ), 1, 80), "N", "0", "09")

	vLinha += 60

	MSCBSAY(vLinha,80,	ALLTRIM(SUBSTR("Pedido:" + Space(2) + vpPedido, 1, 64)), 	 "N", "0", "09")
	MSCBSAY(vLinha,600, ALLTRIM(SUBSTR("NF:" + Space(2) + PRT0097->C6_NOTA, 1, 15)), "N", "0", "09")
	//---------------------------------------------------------------------------------------------------------------------------

	vLinha += 80

	//-- Bloco Título da Grid ---------------------------------------------------------------------------------------------------
	MSCBSAY(vLinha,80,  "Código", 	"N", "0", "09")
	MSCBSAY(vLinha,665, "Qtde", 	"N", "0", "09")
	MSCBSAY(vLinha,825, "Peso",		"N", "0", "09")
	//---------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------

	//-- Itens ---------------------------------------------------------------------------------------------------------------------
	vLinha += 40

	Codigo("N")  

	MSCBSAY(vLinha,650, TRANSFORM(PRT0097->C6_QTDVEN, 	"@E 99,99.99"), "N", "0", "09")
	MSCBSAY(vLinha,810, TRANSFORM(PRT0097->B1_PESO,		"@E 99,99.99"), "N", "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------

	//-- Rodapé --------------------------------------------------------------------------------------------------------------------
	vLinha += 520

	MSCBSAY(vLinha,85,  "P. Bruto:"	+ Space(1) + TRANSFORM(PRT0097->B1_PESO + (PRT0097->B1_PESO * 0.10), "@E 99,99.99"), "N", "0", "09")
	MSCBSAY(vLinha,450, "P. Líq.:"	+ Space(1) + TRANSFORM(PRT0097->B1_PESO, "@E 99,99.99"), "N", "0", "09")
	MSCBSAY(vLinha,670, "Vol.:"		+ Space(1) + ALLTRIM(STR(vIdx)) + "/" + ALLTRIM(STR(vTotal)), "N", "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------

   	MSCBEND()
Return()

Static Function ImprimeDATAMAX_INTERMEC(vLinha, vIdx, vTotal, vRelatorio, cLogo)
	LOCAL vPorta, cLogo, Tipo	:= ""
    LOCAL vImpressora			:= {}

	DO CASE
		CASE vRelatorio == "DATAMAX"
			vTipo := "N"

			AADD(vImpressora, "ALLEGRO")
			AADD(vImpressora, "ALLEGRO 2")
			AADD(vImpressora, "PRODIGY")
			AADD(vImpressora, "DMX")
			AADD(vImpressora, "DESTINY")
			AADD(vImpressora, "URANO")
			AADD(vImpressora, "DATAMAX")
			AADD(vImpressora, "OS 214")
			AADD(vImpressora, "OS 314")
			AADD(vImpressora, "PRESTIGE")
			AADD(vImpressora, "ARGOX")
    	CASE vRelatorio == "INTERMEC"
    		vTipo := "R"

			AADD(vImpressora, "INTERMEC")
			AADD(vImpressora, "3400-8")
			AADD(vImpressora, "3400-16")
			AADD(vImpressora, "3600-8")
			AADD(vImpressora, "4440-16")
			AADD(vImpressora, "7421C-8")
	ENDCASE

	MSCBPRINTER(vImpressora[1], vPorta, 600,,.F.,,,,)

	MSCBBEGIN(1,6)
	MSCBCHKStatus(.T.)

	//-- Grade ---------------------------------------------------------------------------------------------------------------------
	MSCBLineH(68,	75,		950,	3)
	MSCBLineV(68,	75,		940,	3)
	MSCBLineV(68,	950,	940,	3)
	MSCBLineH(200,	75,		950,	3)
	MSCBLineH(300,	75,		950,	3)
	MSCBLineV(302,	610,	880, 	3)
	MSCBLineV(302,	770,	1080, 	3)
	MSCBLineH(418,	75, 	950,	3)
	MSCBLineH(920, 	75, 	950,	3)
	MSCBLineH(960, 	75, 	950,	3)
	//------------------------------------------------------------------------------------------------------------------------------

	vLinha := 900

	//-- Cabeçalho -----------------------------------------------------------------------------------------------------------------

	//-- Logotipo ------------------------------------------------------------------------------------------------------------------
	//MSCBLOADGRF(cLogo)    
	//MSCBGRAFIC(vLinha, 80, SUBSTR(@cLogo, 1, LEN(@cLogo) - 4), .T.)
	//------------------------------------------------------------------------------------------------------------------------------

	vLinha -= 20

	//-- Textos Fixos --------------------------------------------------------------------------------------------------------------
	MSCBSAY(vLinha,320,"VENDAS: (11) 5094-9988 / vendas@daisa.com",vTipo,"0","09")

	vLinha -= 30

   	MSCBSAY(vLinha,320,"FÁBRICA: (11) 4704-5522 / fabrica@daisa.com",vTipo, "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                    
	vLinha -= 80

	//-- Bloco "Cliente", "Pedido" e "NF" ---------------------------------------------------------------------------------------
	MSCBSAY(vLinha,320,SUBSTR("Cliente:" + Space(2) + ALLTRIM(PRT97_2->A1_NREDUZ), 1, 80), vTipo, "0", "09")

	vLinha -= 60

	MSCBSAY(vLinha,80,	ALLTRIM(SUBSTR("Pedido:" + Space(2) + vpPedido, 1, 64)), 	 vTipo, "0", "09")
	MSCBSAY(vLinha,600, ALLTRIM(SUBSTR("NF:" + Space(2) + PRT0097->C6_NOTA, 1, 15)), vTipo, "0", "09")
	//---------------------------------------------------------------------------------------------------------------------------

	vLinha -= 80

	//-- Bloco Título da Grid ---------------------------------------------------------------------------------------------------
	MSCBSAY(vLinha,80,  "Código", 	vTipo, "0", "09")
	MSCBSAY(vLinha,665, "Qtde", 	vTipo, "0", "09")
	MSCBSAY(vLinha,825, "Peso",		vTipo, "0", "09")
	//---------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------

	//-- Itens ---------------------------------------------------------------------------------------------------------------------
	vLinha -= 40

	Codigo(vTipo)  

	MSCBSAY(vLinha,650, TRANSFORM(PRT0097->C6_QTDVEN, 	"@E 99,99.99"), vTipo, "0", "09")
	MSCBSAY(vLinha,810, TRANSFORM(PRT0097->B1_PESO,		"@E 99,99.99"), vTipo, "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------

	//-- Rodapé --------------------------------------------------------------------------------------------------------------------
	vLinha -= 520

	MSCBSAY(vLinha,85,  "P. Bruto:"	+ Space(1) + TRANSFORM(PRT0097->B1_PESO + (PRT0097->B1_PESO * 0.10), "@E 99,99.99"), vTipo, "0", "09")
	MSCBSAY(vLinha,450, "P. Líq.:"	+ Space(1) + TRANSFORM(PRT0097->B1_PESO, "@E 99,99.99"), vTipo, "0", "09")
	MSCBSAY(vLinha,670, "Vol.:"		+ Space(1) + ALLTRIM(STR(vIdx)) + "/" + ALLTRIM(STR(vTotal)), vTipo, "0", "09")
	//------------------------------------------------------------------------------------------------------------------------------

   	MSCBEND()
Return()
*/

Static Function Codigo(vTipo)
	LOCAL i, j		:= 1
	LOCAL vTexto	:= ""
	LOCAL aArray	:= {}

	if LEN(ALLTRIM(PRT0097->C6_DESCRI)) > 30 //-- Limite do Bloco "CÓDIGO"
		for i := 1 to LEN(ALLTRIM(PRT0097->C6_DESCRI))
			if j <= 30
				vTexto += SUBSTR(ALLTRIM(PRT0097->C6_DESCRI), i, 1)
			else
				j := 1

				AADD(aArray, vTexto)

				vTexto := SUBSTR(ALLTRIM(PRT0097->C6_DESCRI), i, 1)
			endif

			j++
		next i

		if j <> 31
			AADD(aArray, vTexto)
		endif

		j := 0
		for i := 1 to LEN(aArray)
			MSCBSAY(vLinha + j, 80, aArray[i], vTipo, "0", "09")

			j += 40
		next i
	else
		MSCBSAY(vLinha, 80, ALLTRIM(PRT0097->C6_DESCRI), vTipo, "0", "09")
	endif
Return()