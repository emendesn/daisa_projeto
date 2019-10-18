#Include "Protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDaiF3Ob   บAutor  ณMicrosiga           บ Data ณ  01/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function DaiF3Ob()	
Local lRet		    := .T.
Local aHeaderBus    := {}
Local aColsBus      := {}
Local oTexto
Local oTipo
Local aTipo			:= {"Nome","Codigo"}
Local lBusca		:= .F.  
Local cTit			:= "" 

Private nTipo			:= 1  
Private oTipo		
Private aCpoHeader := {}
Private oDlg
Private cTexto 		:= Space(30)
Private cTipo		:= "1"
Private oGetDados        

If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S'  
	cTit := "Pesquisa de Prospects" 
	aCpoHeader := {"US_COD", "US_LOJA", "US_NOME", "US_DDD", "US_TEL" }
Else
	aCpoHeader := {"A1_COD", "A1_LOJA", "A1_NOME", "A1_DDD", "A1_TEL" }
	cTit := "Pesquisa de Clientes"
EndIf
                      
cTexto := &(ReadVar())
If !Empty (cTexto)	
	lBusca	:= .T.
EndIf

//Carrega o aHeaderBus
dbSelectArea("SX3")
dbSetOrder(2)
For nX:=1 To Len(aCpoHeader)
	If dbSeek(aCpoHeader[nX], .F.)
		aAdd(aHeaderBus,{Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,;
		SX3->X3_TAMANHO,SX3->X3_DECIMAL,,,SX3->X3_TIPO,SX3->X3_F3,,SX3->X3_CBOX,,,SX3->X3_VISUAL, , ,})
	EndIf
Next

//Monta o aColsBus - primeira vez vazio
aAdd(aColsBus,Array(Len(aHeaderBus)+1))
For nX := 1 To Len(aHeaderBus)
	aColsBus[1, nX] := CriaVar(aHeaderBus[nX, 2])
Next nX
aColsBus[Len(aColsBus), Len(aHeaderBus)+1] := .F.


//Monta a tela
//DEFINE MSDIALOG oDlg TITLE "Pesquisa de Produtos" From 099,080 To 544,913 OF oMainWnd PIXEL
DEFINE MSDIALOG oDlg TITLE cTit From 050,050 To 600,900 OF oMainWnd PIXEL    

@ 010,010 RADIO oTipo VAR nTipo   OF oDlg PIXEL SIZE 70,08 ITEMS "Iniciado por", "Qualquer trecho" 3D

@ 030,010 COMBOBOX oTipo Var cTipo Items aTipo SIZE 80, 27 OF oDlg PIXEL
@ 050,010 MsGET oTexto VAR cTexto SIZE 150,10 PICTURE "@!" PIXEL          

oTexto:bLostFocus:={||Busca()}

oGetDados := MsNewGetDados():New(090,015,200,350,GD_UPDATE,,,,{},,,,,,oDlg,aHeaderBus,aColsBus)
oGetDados:oBrowse:bLDblClick := {|| lRet := Seleciona(), oDlg:End() }

DEFINE SBUTTON FROM 300, 400 Type 2 ACTION (lRet := .F., oDlg:End()) ENABLE OF oDlg PIXEL

oTexto:SetFocus()

ACTIVATE MSDIALOG oDlg CENTERED

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusca     บAutor  ณMauro Sano          บ Data ณ  15/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza a query.                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Busca()
Local cChave


If !Empty(cTexto)
	
	CursorWait()
	
	If AllTrim(cTipo) == "Nome"   
		If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S' 
			cChave := "US_NOME" 	
		Else
			cChave := "A1_NOME"
		EndIf
	ElseIf AllTrim(cTipo) == "Codigo"
		If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S' 
			cChave := "US_COD"
		Else	
			cChave := "A1_COD"
		EndIf		
	EndIf
	
	cQuery := "SELECT "
	For nX :=1 To Len(aCpoHeader)
		cQuery += aCpoHeader[nx]
		cQuery += iif(nX < Len(aCpoHeader),", "," ")
	Next	
	
	If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S'  

		cQuery +=" FROM "+ RetSQLName("SUS") + " SUS " + Char(13)
		cQuery += "WHERE "
		cQuery += "US_FILIAL = '"+xFilial("SUS")+"' "+Char(13)
		
		If nTipo == 1
			cQuery += "AND "+cChave+" LIKE '"+AllTrim(cTexto)+"%' "+Char(13) 
		Else                                                                 
			cQuery += "AND "+cChave+" LIKE '%"+AllTrim(cTexto)+"%' "+Char(13) 
		EndIf
			
		cQuery += "AND SUS.D_E_L_E_T_ <>'*' "+Char(13)
		cQuery += "ORDER BY '"+cChave+"' "+Char(13)
	Else
		cQuery +=" FROM "+ RetSQLName("SA1") + " SA1 " + Char(13)
		cQuery += "WHERE "
		cQuery += "A1_FILIAL = '"+xFilial("SA1")+"' "+Char(13)
		
		If nTipo == 1               
			cQuery += "AND "+cChave+" LIKE '"+AllTrim(cTexto)+"%' "+Char(13)
		Else
			cQuery += "AND "+cChave+" LIKE '%"+AllTrim(cTexto)+"%' "+Char(13) 
		EndIF
		
		cQuery += "AND SA1.D_E_L_E_T_ <>'*' "+Char(13)
		cQuery += "ORDER BY '"+cChave+"' "+Char(13)
		                        
	EndIf

	cQuery  := ChangeQuery(cQuery)
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), "TMPQRY", .F., .T. )          


	
	oGetDados:aCols := {}
	While !Eof()
		aAdd(oGetDados:aCols,Array(Len(oGetDados:aHeader)+1))
		For nCntFor	:= 1 To Len(oGetDados:aHeader)
			If ( oGetDados:aHeader[nCntFor][10] != "V" )
				oGetDados:acols[Len(oGetDados:acols)][nCntFor] := FieldGet(FieldPos(oGetDados:aHeader[nCntFor][2]))
			Else
				oGetDados:acols[Len(oGetDados:acols)][nCntFor] := CriaVar(oGetDados:aHeader[nCntFor][2],.T.)
			EndIf
		Next nCntFor
		oGetDados:acols[Len(oGetDados:acols), Len(oGetDados:aHeader)+1] := .F.
		dbSkip()
	EndDo
	dbCloseArea()
	
	//se nao achou limpa
	If Len(oGetDados:acols) == 0
		aAdd(oGetDados:acols,Array(Len(oGetDados:aHeader)+1))
		For nX := 1 To Len(oGetDados:aHeader)
			oGetDados:acols[1, nX] := CriaVar(oGetDados:aHeader[nX, 2])
		Next nX
		oGetDados:acols[Len(oGetDados:acols), Len(oGetDados:aHeader)+1] := .F.
	EndIf
	
	
	oGetDados:oBrowse:nAt := 1
	oGetDados:oBrowse:Refresh(.T.)
	oGetDados:oBrowse:SetFocus()
	
	CursorArrow()
EndIf

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSeleciona บAutor  ณMauro Sano          บ Data ณ  15/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Posiciona o produto.                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Seleciona()
Local lRet
Local cChave := ""

If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S' 
	cChave := oGetDados:acols[oGetDados:oBrowse:nAt,GdFieldPos("US_COD",oGetDados:aheader)]+oGetDados:acols[oGetDados:oBrowse:nAt,GdFieldPos("US_LOJA",oGetDados:aheader)]
	
	dbSelectArea("SUS")
	dbSetOrder(1)
	lRet := dbSeek(xFilial()+cChave)
	
	aCols[n,GdFieldPos("Z5_CODENV",aHeader)]:= SUS->US_COD
	aCols[n,GdFieldPos("Z5_LOJA",aHeader)] 	:= SUS->US_LOJA    
	aCols[n,GdFieldPos("Z5_NOME",aHeader)] 	:= SUS->US_NOME   
	aCols[n,GdFieldPos("Z5_DDD",aHeader)] 	:= SUS->US_DDD   
	aCols[n,GdFieldPos("Z5_TEL",aHeader)] 	:= SUS->US_TEL  
	

Else
	cChave := oGetDados:acols[oGetDados:oBrowse:nAt,GdFieldPos("A1_COD",oGetDados:aheader)]+oGetDados:acols[oGetDados:oBrowse:nAt,GdFieldPos("A1_LOJA",oGetDados:aheader)]
	
	dbSelectArea("SA1")
	dbSetOrder(1)                
	
	lRet := dbSeek(xFilial()+cChave)
	
	aCols[n,GdFieldPos("Z5_CODENV",aHeader)]:= SA1->A1_COD
	aCols[n,GdFieldPos("Z5_LOJA",aHeader)]	:= SA1->A1_LOJA
	aCols[n,GdFieldPos("Z5_NOME",aHeader)]	:= SA1->A1_NOME   
	aCols[n,GdFieldPos("Z5_DDD",aHeader)] 	:= SA1->A1_DDD   
	aCols[n,GdFieldPos("Z5_TEL",aHeader)] 	:= SA1->A1_TEL  	
EndIf

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณF3Busc    บAutor  ณMauro Sano          บ Data ณ  15/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Abre a tela de pesquisa de produto com tratamento de area  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function F3Busc()
Local aArea	 := GetArea()
Local lRet	 := U_DaiF3Ob()

Return .F.

