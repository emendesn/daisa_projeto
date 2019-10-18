/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATUSB1    ºAutor  ³Vitor Daniel        º Data ³  31-01-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ATUALIZA TABELA DE CADASTRO DO RODUTO                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ATUSB1()
Local cPerg := "ATUSB10001"

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

//FUNCAO DE ATUALIZACAO
Static Function ProcImp(cArquivo)
Local nX
Local nY
Local nLinha   := 0
Local lCont    := 0
Local cLog     := ""
Local cErro    := ""
Local nQtdErro := 0
Local lCont    := .T.

dbUseArea(.T.,"DBFCDXADS",cArquivo,"TRB",.T.,.F.)

dbSelectArea("TRB")
ProcRegua(RecCount())
dbGotop()

While !EOF() .And. lCont
	
	IncProc()
	nLinha++
	
	aCampos := {}
	For nX := 1 To FCount()
		cNome := Upper(AllTrim(FieldName(nx)))
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
	If dbSeek(xFilial()+aCampos[1][2])
		
		RecLock("SB1",.F.)
		For nX := 1 To Len(aCampos)
			cNome := aCampos[nx,1]
			SB1->(&(cNome)) :=  aCampos[nx,2]
		Next
		MsUnLock()
	EndIf		
	
	dbSelectArea("TRB")
	dbSkip()
EndDo    

dbCloseArea()
          
Alert("Atualizacao concluida com sucesso!")

Return Nil