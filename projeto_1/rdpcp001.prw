#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRDPCP001  บAutor  ณFernando Alves      บ Data ณ 03/10/2012  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera planilha excel para controle diario de producao.      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
User Function RDPCP001()

//Private cQuery1	:= ""
Private aItens	:= {}
Private cPerg		:= "RDPCPPERG"
Private dDiaCont	:= dDataBase       
Private cEol := CHR(13)+CHR(10)

Private aDias		:= {}

	AjustSX1(cPerg)
	if Pergunte(cPerg,.T.)
		Processa({|| ProcImp()},"Aguarde","Processando relatorio...")
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณProcImp   บAutor  ณFernando Alves      บ Data ณ 03/10/2012  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera planilha exce para controle diario de producao.       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
Static Procedure ProcImp

Local cQuery
Local nPos

	If MV_PAR05 == 1
		
 		cQuery := "SELECT C6.C6_PRODUTO CODIGO, C6.C6_XCODANT CODDAISA, SUM(C6.C6_QTDVEN) QUANTIDADE"+cEol
		cQuery += " FROM " + RetSqlName("SC6") + " C6 "+cEol
		cQuery += " INNER JOIN " + RetSqlName("SF4") + " F4 "+cEol
		cQuery += " ON F4.F4_CODIGO = C6.C6_TES "+cEol
		cQuery += " WHERE C6.C6_ENTREG BETWEEN '" + DTOS(MV_PAR01) + "' AND '"+DTOS(MV_PAR02) + "' AND "+cEol
		cQuery +=        "C6.D_E_L_E_T_ = '' AND "+cEol
		cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol
		cQuery +=        "F4.F4_ESTOQUE = 'S' "+cEol
		cQuery += " GROUP BY C6.C6_PRODUTO,C6.C6_XCODANT "+cEol
		
		If MV_PAR06 == 1 // AGLUTINA
			If cEmpAnt == '01'
				cQuery += " UNION ALL SELECT C6.C6_PRODUTO CODIGO, C6.C6_XCODANT CODDAISA, SUM(C6.C6_QTDVEN) QUANTIDADE"+cEol
				cQuery += " FROM SC6020 C6 "+cEol
				cQuery += " INNER JOIN SF4020 F4 "+cEol
				cQuery += " ON F4.F4_CODIGO = C6.C6_TES "+cEol
				cQuery += " WHERE C6.C6_ENTREG BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02)+"' AND "+cEol
				cQuery +=        "C6.D_E_L_E_T_ = '' AND "
				cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4_ESTOQUE = 'S' "+cEol
				cQuery += " GROUP BY C6.C6_PRODUTO,C6.C6_XCODANT "+cEol
				
				cQuery += " UNION ALL SELECT C6.C6_PRODUTO CODIGO, C6.C6_XCODANT CODDAISA, SUM(C6.C6_QTDVEN) QUANTIDADE"+cEol
				cQuery += " FROM SC6030 C6 "+cEol
				cQuery += " INNER JOIN SF4030 F4 "+cEol
				cQuery += " ON F4.F4_CODIGO = C6.C6_TES "+cEol
				cQuery += " WHERE C6.C6_ENTREG BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02)+"' AND "+cEol
				cQuery +=        "C6.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4.F4_ESTOQUE = 'S' "+cEol
				cQuery += " GROUP BY C6.C6_PRODUTO,C6.C6_XCODANT "+cEol
				
			Else
				Alert("Favor posicionar o sistema na empresa 01! Aglutina็ใo mnใo executada")
			EndIf
		EndIf
		
	Else
		
		cQuery := "SELECT C6.C6_PRODUTO CODIGO, C6.C6_XCODANT CODDAISA, C6.C6_NUM PEDIDO, C6.C6_ITEM ITEM, C6.C6_QTDVEN QUANTIDADE, C6.C6_ENTREG AS ENTREG"+cEol
		cQuery += " FROM  " + RetSqlName("SC6") + " C6 "+cEol
		cQuery += " INNER JOIN " + RetSqlName("SF4") + " F4 "+cEol
		cQuery += " ON F4.F4_CODIGO = C6.C6_TES "+cEol
		cQuery += " WHERE C6.C6_ENTREG BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "' AND "+cEol
		cQuery +=        "C6.D_E_L_E_T_ = '' AND "+cEol
		cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol		
		cQuery +=        "F4.F4_ESTOQUE = 'S'"+cEol
		
	EndIf
	
	PLSQUERY(cQuery,"TMP1")
	
	// Pe็a	Estoque PA	Estoque PP	01/out	02/out	03/out	04/out	05/out	06/out	07/out	08/out
	
	dDiaCont := MV_PAR01
	aDias    := FDIASINF( MV_PAR01, MV_PAR02 )
	
	DbSelectArea("TMP1")
	
	While TMP1->(!Eof())
		
		_cProduto := Alltrim(POSICIONE("SB1",1,xFilial("SB1")+TMP1->CODIGO,"B1_DESC"))
		
		If MV_PAR05 == 1
			
			If ( nScan := ASCAN( aItens, { |x| x[1] == '|'+TMP1->CODIGO } ) ) == 0
				AADD( aItens, ;
				              { '|'+TMP1->CODIGO,TMP1->CODDAISA, Iif( Empty(_cProduto), TMP1->CODIGO, _cProduto), FEST001( TMP1->CODIGO, "01") } )
				
				FOR nPos := 1 TO ( MV_PAR02-MV_PAR01 ) + 1
					AADD( aItens[ Len(aItens) ], ;
					                             { CATEIPED( MV_PAR02, MV_PAR01,TMP1->CODIGO, "") } )
				NEXT
			EndIf
		Else
			AADD( aItens, ;
			              { TMP1->PEDIDO, TMP1->ITEM, "|"+TMP1->CODIGO, TMP1->CODDAISA, ;
			                Iif( Empty(_cProduto), TMP1->CODIGO,_cProduto ), FEST001(TMP1->CODIGO,"01"), TMP1->ENTREG } )
			
			FOR nPos := 1 TO ( MV_PAR02-MV_PAR01 ) + 1
				AADD( aItens[ Len(aItens) ], { CATEIPED(MV_PAR02,MV_PAR01,TMP1->CODIGO,TMP1->PEDIDO) } )
			NEXT
			
		EndIf
		
		dDiaCont := MV_PAR01
		
		TMP1->(DbSkip())
	EndDo
	
	TMP1->(DbCloseArea())
	
	Exporta(aItens,MV_PAR05)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFEST001   บAutor  ณFernando Alves      บ Data ณ 03/10/2012  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o saldo do produto por armazen.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FEST001(cProduto,cArmazem)

Local cQuery
Local nRet   := 0

	cQuery := "SELECT B2_QATU QTDATUAL "
	cQuery += " FROM " + RetSqlName("SB2")
	cQuery += " WHERE D_E_L_E_T_ = '' AND "
	cQuery +=       "B2_LOCAL = '"+cArmazem+"' AND "
	cQuery +=       "B2_COD = '"+cProduto+"' AND "
	cQuery +=       "B2_FILIAL = '"+xFilial("SB2")+"' "
	
	If MV_PAR05 == 1 .And. MV_PAR06 == 1 .And. MV_PAR07 == 1// AGLUTINA
		If cEmpAnt == '01'
			cQuery += " UNION ALL "
			cQuery += " SELECT B2_QATU QTDATUAL "
			cQuery += " FROM SB2020 "
			cQuery += " WHERE D_E_L_E_T_ = '' AND "
			cQuery +=        "B2_LOCAL = '" + cArmazem + "' AND "
			cQuery +=        "B2_COD = '" + cProduto + "' AND "
			cQuery +=        "B2_FILIAL = '" + xFilial("SB2") + "' "
			
			cQuery += " UNION ALL "
			cQuery += " SELECT B2_QATU QTDATUAL "
			cQuery += " FROM SB2030 "
			cQuery += " WHERE D_E_L_E_T_ = '' AND "
			cQuery +=         "B2_LOCAL = '" + cArmazem + "' AND "
			cQuery +=         "B2_COD = '" + cProduto + "' AND "
			cQuery +=         "B2_FILIAL = '" + xFilial("SB2") + "' "
		EndIf
	EndIf
	
	PLSQUERY(cQuery,"TMP2")
	DbSelectArea("TMP2")
	
	If TMP2->( .NOT. Eof() )
		While TMP2->( .NOT. Eof() )
			nRet := TMP2->QTDATUAL
			DbSelectArea("TMP2")
			TMP2->( DbSkip() )
		EndDo
	EndIf
	
	TMP2->(DbCloseArea())
	
Return(nRet) 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCATEIPED  บAutor  ณFernando Alves      บ Data ณ 03/10/2012  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Totaliza por Pedido.                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CATEIPED(dEnt01,dEnt02,cCodPro,cNumPed)

Local cQuery3
Local nRet   := 0

	If MV_PAR05 == 1
		
		cQuery := "SELECT C6.C6_PRODUTO CODIGO, SUM(C6.C6_QTDVEN) QUANTIDADE"+cEol
		cQuery += " FROM  " + RetSqlName("SC6") + " C6 " +cEol
		cQuery += " INNER JOIN " + RetSqlName("SF4") + " F4 "+cEol
		cQuery += " ON F4.F4_CODIGO = C6.C6_TES"+cEol
		cQuery += " WHERE C6.C6_ENTREG = '" + DTOS(dDiaCont) + "' AND "+cEol
		cQuery +=        "C6.C6_PRODUTO = '" + cCodPro + "' AND " +cEol
		cQuery +=        "C6.D_E_L_E_T_ = '' AND "+cEol
		cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol		
		cQuery +=        "F4.F4_ESTOQUE = 'S' "+cEol
		cQuery +=        "GROUP BY C6.C6_PRODUTO" +cEol
		
		If MV_PAR06 == 1 // AGLUTINA
			If cEmpAnt == '01'
				cQuery += " UNION ALL SELECT C6.C6_PRODUTO CODIGO,SUM(C6.C6_QTDVEN) QUANTIDADE"+cEol
				cQuery += " FROM  SC6020 C6 " +cEol
				cQuery += " INNER JOIN SF4020 F4 "+cEol
				cQuery += " ON F4.F4_CODIGO = C6.C6_TES"+cEol
				cQuery += " WHERE C6.C6_ENTREG = '" + DTOS(dDiaCont) + "' AND "+cEol
				cQuery +=        "C6.C6_PRODUTO = '" + cCodPro + "' AND " +cEol
				cQuery +=        "C6.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4.F4_ESTOQUE = 'S'"+cEol
				cQuery += " GROUP BY C6.C6_PRODUTO" +cEol
				
				cQuery += " UNION ALL SELECT C6.C6_PRODUTO CODIGO, SUM(C6_QTDVEN) QUANTIDADE"+cEol
				cQuery += " FROM  SC6030 C6 "+cEol
				cQuery += " INNER JOIN SF4030 F4 "+cEol
				cQuery += " ON F4.F4_CODIGO = C6.C6_TES"+cEol
				cQuery += " WHERE C6.C6_ENTREG = '" + DTOS(dDiaCont) + "' AND "+cEol
				cQuery +=        "C6.C6_PRODUTO = '" + cCodPro + "' AND "+cEol
				cQuery +=        "C6.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol
				cQuery +=        "F4.F4_ESTOQUE = 'S'"+cEol
				cQuery += " GROUP BY C6.C6_PRODUTO" +cEol
			EndIf
		EndIf
	Else
		
		cQuery := " SELECT C6.C6_PRODUTO CODIGO, C6.C6_QTDVEN QUANTIDADE"+cEol
		cQuery += " FROM " + RetSqlName("SC6") + " C6 "+cEol
		cQuery += " INNER JOIN " + RetSqlName("SF4") + " F4 "+cEol
		cQuery += " ON F4.F4_CODIGO = C6.C6_TES"+cEol
		cQuery += " WHERE C6.C6_ENTREG = '" + DTOS(dDiaCont)+"' AND "+cEol
		cQuery +=        "C6.C6_PRODUTO = '" + cCodPro + "' AND "+cEol
		cQuery +=        "C6.C6_NUM = '" + cNumPed + "' AND " +cEol
		cQuery +=        "C6.C6.D_E_L_E_T_ = '' AND "+cEol
		cQuery +=        "F4.D_E_L_E_T_ = '' AND "+cEol
		cQuery +=        "F4.F4_ESTOQUE = 'S'"+cEol
		
	EndIf
	
	PLSQUERY(cQuery,"TMP3")
	DbSelectArea("TMP3")
	
	If TMP3->( .NOT. Eof() )
		While TMP3->( .NOT. Eof() )
			nRet += TMP3->QUANTIDADE
			DbSelectArea("TMP3")
			TMP3->( DBSkip() )
		EndDo
	EndIf
	
	TMP3->(DbCloseArea())
	
	dDiaCont := dDiaCont + 1
	
Return(nRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExporta   บAutor  ณFernando Alves		 บ Data ณ  20/07/2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExporta dados para Excel.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                 

Static Procedure Exporta(aItens,nTipoRel)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ                                         
//ณMensagem de sele็ใo de dadosณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgRun("Favor Aguardar...","Selecionando os Registros",;
		{||GProcItens(aItens,nTipoRel)})


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ    .  
ฑฑบPrograma  ณGProcItensบAutor  ณFernando Alves		 บ Data ณ  20/07/2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRealiza a gravao do arquivo texto.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ 
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure GProcItens(aItens,nTipoRel)    

Local cCrLf 	:= Chr(13) + Chr(10)                                                       
Local oExcelApp // Objeto para cria็ใo da planilha
Local cOrg     := ""
Local cEnvServ := GetEnvServer()
Local cIniFile := GetADV97()
Local cPath    := GetPvProfString(cEnvServ,"RootPath","",cIniFile)
Local nHandle
Local nPos
Local nCount
Local cArq1	   := "C:\TEMP\" + DtoS(dDataBase) + "_" + SubStr(TIME(),7,2) + "_AGL" + ".csv" 
 

	// Cria o arquivo
	If ( nHandle := FCreate( cArq1, 0) ) > 0
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณCria cabecalho da planilhaณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If nTipoRel == 1
			FWrite(nHandle, "CODIGO PROTHEUS" + ";" )
			FWrite(nHandle, "CODIGO DAISA"    + ";" )
			FWrite(nHandle, "PRODUTO"         + ";" )
			FWrite(nHandle, "ESTOQUE PA"      + ";" )
			For nPos := 1 to Len(aDias)
				FWrite( nHandle, aDias[ nPos ][1] + ";" )
			Next
			
		Else
			FWrite(nHandle, "PEDIDO"          + ";" )
			FWrite(nHandle, "ITEM"            + ";" )
			FWrite(nHandle, "ENTREGA"         + ";" )
			FWrite(nHandle, "CODIGO PROTHEUS" + ";" )
			FWrite(nHandle, "CODIGO DAISA"    + ";" )
			FWrite(nHandle, "PRODUTO"         + ";" )
			FWrite(nHandle, "ESTOQUE PA"      + ";" )
			For nPos := 1 to Len(aDias)
				FWrite(nHandle, aDias[ nPos ][1] + ";" )
			Next
			
		EndIf
		
		FWrite( nHandle, cCrLf )
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณCria itens da planilha conforme Queryณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		For nPos := 1 to Len(aItens)
			
			If nTipoRel == 1
				FWrite( nHandle, Alltrim( aItens[ nPos ][01])      + ";" ) //
				FWrite( nHandle, Alltrim( aItens[ nPos ][02])      + ";" ) //
				FWrite( nHandle, Alltrim( aItens[ nPos ][03])      + ";" ) //
				FWrite( nHandle, Alltrim( STR(aItens[ nPos ][04])) + ";" ) //
				For nCount := 5 to len(aItens[ nPos ])
					FWrite(nHandle, Alltrim(STR(aItens[ nPos ][ nCount ][1])) + ";" ) //
				Next
			Else
				
				FWrite( nHandle, Alltrim( aItens[ nPos ][01])      + ";" ) //
				FWrite( nHandle, Alltrim( aItens[ nPos ][02])      + ";" ) //
				FWrite( nHandle, DTOC(STOD( aItens[ nPos ][07]))   + ";" ) //
				FWrite( nHandle, Alltrim( aItens[ nPos ][03])      + ";" ) //
				FWrite( nHandle, Alltrim( aItens[ nPos ][04])      + ";" ) //
				FWrite( nHandle, Alltrim( aItens[ nPos ][05])      + ";" ) //
				FWrite( nHandle, Alltrim( STR(aItens[ nPos ][06])) + ";" ) //
				For nCount := 8 to Len(aItens[ nPos ])
					FWrite( nHandle, Alltrim( STR( aItens[ nPos ][ nCount ][1])) + ";" ) //
				Next
				
			EndIf
			
			FWrite(nHandle, cCrLf )
			
		Next
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณFecha arquivoณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤู
		FClose(nHandle)
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Abre uma planilhaณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oExcelApp:= MsExcel():New()
		oExcelApp:WorkBooks:Open(cArq1)
		oExcelApp:SetVisible(.T.)
		
	Else
		MsgAlert("Erro na cria็ใo do arquivo")
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณFecha Area ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤู
	DbCloseArea()
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ    .  
ฑฑบPrograma  ณFDATDES   บAutor  ณFernando Alves		 บ Data ณ  20/07/2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFormata a Data para DDMMAAAA.                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ 
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FDATDES(cData)

local cDia := SubStr( cData, 7, 2)
Local cMes := SubStr( cData, 5, 2)
Local cAno := SubStr( cData, 1, 4)

Return( cDia+"/"+cMes+"/"+cAno )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณAjustSX1  บAutor  ณFernando Alves      บ Data ณ 20/07/2010  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAjusta as Perguntas.                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure AjustSX1(cPerg)
																																				
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
Local aArea 	:= GetArea()
Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}        

	Aadd( aHelpEng, "  ")
	Aadd( aHelpSpa, "  ")
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Ajusta as Perguntas.                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	//=====ณDT. ENTREGAณ==============================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "DT. ENTREGA DE")
	PutSx1( cPerg, "01","Dt. Entrega de	"	,"Dt. Entrega de ","Dt. Entrega de	","mv_cha","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "DT. ENTREGA ATE")
	PutSx1( cPerg, "02","Dt. Entrega ate "	,"Dt. Entrega ate ","Dt. Entrega ate ","mv_chb","D",8,0,0,"G","naovazio","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	
	//=====ณPRODUTOณ====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "PRODUTO DE")
	PutSx1( cPerg, "03","Produto De","","","mv_ch3","C",30,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "PRODUTO ATE")
	PutSx1( cPerg, "04","Produto Ate","","","mv_ch4","C",30,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	
	//=====ณTIPO DE GERACAOณ====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "Tipo de Geracao")
	PutSx1( cPerg, "05","Tipo de Geracao","","","mv_ch5","N",1,0,0,"C","","","","","mv_par05","Cart por Pe็a","Cart por Pe็a","Cart por Pe็a","Cart por Pedido","Cart por Pedido","Cart por Pedido","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	//=====ณTIPO DE GERACAOณ====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "Aglutina nas 3 empresas - Funciona apenas na gera็ใo por pe็a")
	PutSx1( cPerg, "06","Aglutina empresas","","","mv_ch6","N",1,0,0,"C","","","","","mv_par06","Sim","Sim","Sim","Nao","Nao","Nao","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	//=====ณTIPO DE GERACAOณ====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "Uliliza saldo empresa logada ou aglutina saldos - Funciona apenas na gera็ใo por pe็a")
	PutSx1( cPerg, "07","Aglutina Saldos","","","mv_ch7","N",1,0,0,"C","","","","","mv_par07","Sim","Sim","Sim","Nao","Nao","Nao","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	RestArea( aArea )
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณFDIASINF  บAutor  ณFernando Alves      บ Data ณ 20/07/2010  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna um Array com os dias do Periodo informado.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ DAISA CONEXOES - PCP                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FDIASINF(dData1, dData2)
                         
Local dDiaX:= dData1
Local nPos

For nPos := 1 to (dData2-dData1)+1
	Aadd(aDias,{FDATDES(DtoS(dDiaX))})
	dDiaX:= dDiaX + 1
Next

Return(aDias)