#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RDPCP001  �Autor  �Fernando Alves      � Data � 03/10/2012  ���
�������������������������������������������������������������������������͹��
���Desc.     � Gera planilha excel para controle diario de producao.      ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ProcImp   �Autor  �Fernando Alves      � Data � 03/10/2012  ���
�������������������������������������������������������������������������͹��
���Desc.     � Gera planilha exce para controle diario de producao.       ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
				Alert("Favor posicionar o sistema na empresa 01! Aglutina��o mn�o executada")
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
	
	// Pe�a	Estoque PA	Estoque PP	01/out	02/out	03/out	04/out	05/out	06/out	07/out	08/out
	
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FEST001   �Autor  �Fernando Alves      � Data � 03/10/2012  ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o saldo do produto por armazen.                    ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CATEIPED  �Autor  �Fernando Alves      � Data � 03/10/2012  ���
�������������������������������������������������������������������������͹��
���Desc.     � Totaliza por Pedido.                                       ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Exporta   �Autor  �Fernando Alves		 � Data �  20/07/2010 ���
�������������������������������������������������������������������������͹��
���Desc.     �Exporta dados para Excel.                                   ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                 

Static Procedure Exporta(aItens,nTipoRel)

//������������������������������                                         
//�Mensagem de sele��o de dados�
//������������������������������
MsgRun("Favor Aguardar...","Selecionando os Registros",;
		{||GProcItens(aItens,nTipoRel)})


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��    .  
���Programa  �GProcItens�Autor  �Fernando Alves		 � Data �  20/07/2010 ���
�������������������������������������������������������������������������͹��
���Desc.     �Realiza a gravao do arquivo texto.                          ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ�� 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Procedure GProcItens(aItens,nTipoRel)    

Local cCrLf 	:= Chr(13) + Chr(10)                                                       
Local oExcelApp // Objeto para cria��o da planilha
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
		
		//��������������������������Ŀ
		//�Cria cabecalho da planilha�
		//����������������������������
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
		
		//�������������������������������������Ŀ
		//�Cria itens da planilha conforme Query�
		//���������������������������������������
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
		
		//�������������Ŀ
		//�Fecha arquivo�
		//���������������
		FClose(nHandle)
		
		//������������������Ŀ
		//� Abre uma planilha�
		//��������������������
		oExcelApp:= MsExcel():New()
		oExcelApp:WorkBooks:Open(cArq1)
		oExcelApp:SetVisible(.T.)
		
	Else
		MsgAlert("Erro na cria��o do arquivo")
	EndIf
	
	//�����������Ŀ
	//�Fecha Area �
	//�������������
	DbCloseArea()
	
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��    .  
���Programa  �FDATDES   �Autor  �Fernando Alves		 � Data �  20/07/2010 ���
�������������������������������������������������������������������������͹��
���Desc.     �Formata a Data para DDMMAAAA.                               ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ�� 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FDATDES(cData)

local cDia := SubStr( cData, 7, 2)
Local cMes := SubStr( cData, 5, 2)
Local cAno := SubStr( cData, 1, 4)

Return( cDia+"/"+cMes+"/"+cAno )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �AjustSX1  �Autor  �Fernando Alves      � Data � 20/07/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     �Ajusta as Perguntas.                                        ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Procedure AjustSX1(cPerg)
																																				
//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//����������������������������������������������������������������������� 
Local aArea 	:= GetArea()
Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}        

	Aadd( aHelpEng, "  ")
	Aadd( aHelpSpa, "  ")
	
	//���������������������������������������������������������������������Ŀ
	//� Ajusta as Perguntas.                                                �
	//�����������������������������������������������������������������������
	
	//=====�DT. ENTREGA�==============================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "DT. ENTREGA DE")
	PutSx1( cPerg, "01","Dt. Entrega de	"	,"Dt. Entrega de ","Dt. Entrega de	","mv_cha","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "DT. ENTREGA ATE")
	PutSx1( cPerg, "02","Dt. Entrega ate "	,"Dt. Entrega ate ","Dt. Entrega ate ","mv_chb","D",8,0,0,"G","naovazio","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	
	//=====�PRODUTO�====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "PRODUTO DE")
	PutSx1( cPerg, "03","Produto De","","","mv_ch3","C",30,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "PRODUTO ATE")
	PutSx1( cPerg, "04","Produto Ate","","","mv_ch4","C",30,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	
	//=====�TIPO DE GERACAO�====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "Tipo de Geracao")
	PutSx1( cPerg, "05","Tipo de Geracao","","","mv_ch5","N",1,0,0,"C","","","","","mv_par05","Cart por Pe�a","Cart por Pe�a","Cart por Pe�a","Cart por Pedido","Cart por Pedido","Cart por Pedido","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	//=====�TIPO DE GERACAO�====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "Aglutina nas 3 empresas - Funciona apenas na gera��o por pe�a")
	PutSx1( cPerg, "06","Aglutina empresas","","","mv_ch6","N",1,0,0,"C","","","","","mv_par06","Sim","Sim","Sim","Nao","Nao","Nao","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	//=====�TIPO DE GERACAO�====================================================================================================================================================================================================
	aHelpPor := {} ; Aadd( aHelpPor, "Uliliza saldo empresa logada ou aglutina saldos - Funciona apenas na gera��o por pe�a")
	PutSx1( cPerg, "07","Aglutina Saldos","","","mv_ch7","N",1,0,0,"C","","","","","mv_par07","Sim","Sim","Sim","Nao","Nao","Nao","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa )
	//=============================================================================================================================================================================================================================
	
	RestArea( aArea )
	
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �FDIASINF  �Autor  �Fernando Alves      � Data � 20/07/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna um Array com os dias do Periodo informado.          ���
�������������������������������������������������������������������������͹��
���Uso       � DAISA CONEXOES - PCP                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FDIASINF(dData1, dData2)
                         
Local dDiaX:= dData1
Local nPos

For nPos := 1 to (dData2-dData1)+1
	Aadd(aDias,{FDATDES(DtoS(dDiaX))})
	dDiaX:= dDiaX + 1
Next

Return(aDias)