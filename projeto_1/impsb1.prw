/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPSB1    ºAutor  ³Vitor Daniel        º Data ³  19-08-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PROGRAMA PARA IMPORTAR O CADASTRO DE PRODUTO               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ImpSB1()

Local cPerg := "IMPSB10001"

PutSX1(cPerg,"01","Arquivo (\IMPORTAR\)?"  ,"","", "mv_ch1" ,"C",99,0,0,"G","",""   ,"","","MV_PAR01"   ,"","","",""   ,"" ,"","",""          ,"","","","","","","",{""},{},{})

If Pergunte(cPerg,.T.)
	
	cArquivo := "\IMPORTAR\"+AllTrim(MV_PAR01)
	
	If File(cArquivo)		
		Processa({|| ProcImp(cArquivo)},"Aguarde","Processando...")		
	Else		
		MsgAlert("Arquivo "+cArquivo+" nao encontrado.")
	EndIf
	
EndIf

Return Nil

Static Function ProcImp(cArquivo)
Local nX
Local nY
Local nLinha := 0
Local lCont  := 0
Local cLog   := ""
Local cErro  := ""
Local nQtdErro := 0
Local lCont   := .T.

dbUseArea(.T.,"DBFCDXADS",cArquivo,"TRB",.T.,.F.)

dbSelectArea("TRB")
ProcRegua(RecCount())

dbGotop()

While !EOF() .And. lCont
	
	IncProc()
	nLinha++
	
	aCampos := {}
	For nX := 1 To FCount()
		cNome := AllTrim(FieldName(nx))
		If .T.
			
			If Type(cNome) == "C"
				xValor := AllTrim(&(cNome))
			Else
				xValor := &(cNome)
			EndIf
			
			If ! (cNome $ "B1_FILIAL/B1_LOG")
				Aadd(aCampos, {cNome	,xValor	, NIL})
			EndIf
			
		EndIf
	Next
	
	dbSelectArea("SB1")
	dbSetOrder(1)
	
	If Len(aCampos[1][2]) >= 6

		dbSelectArea("SB1")
		dbSetOrder(1)
		If !dbSeek(xFilial()+aCampos[1][2])
			
			RecLock("SB1",.T.)
			For nX := 1 To Len(aCampos)
				cNome := aCampos[nx,1]
				SB1->(&(cNome)) :=  aCampos[nx,2]
			Next
			SB1->B1_FILIAL := xFilial("SB1")
			MsUnLock()
		Else
			RecLock("TRB",.F.)
			TRB->B1_LOG := "REGISTRO DUPLICADO"
			TRB->(MsUnLock())
		EndIf
	EndIf	
	
	dbSelectArea("TRB")
	dbSkip()
EndDo

dbCloseArea()

Return Nil