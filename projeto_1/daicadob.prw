#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDaiCadOb  บAutor  ณMauro Sano          บ Data ณ  11/10/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cadastro de comissao de vendedores                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function DaiCadOb()

Private cCadastro  	:= "Cadastro de Obras"
Private aRotina		:= {	{"Pesquisar"	,"AxPesqui"    , 0, 1},;
							{"Visualizar"	,"U_A001Manut" , 0, 2},;
							{"Incluir"   	,"U_A001Manut" , 0, 3},;
							{"Alterar"   	,"U_A001Manut" , 0, 4},;
							{"Excluir"   	,"U_A001Manut" , 0, 5},;
							{"Ficha Obra"  	,"U_DaiFicOb"  , 0, 2} }

mBrowse( 6, 1,22,75,"SZ4")

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณA001Manut บAutor  ณMauro Sano          บ Data ณ  26/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Manutencao.                                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function A001Manut(cAlias,nReg,nOpcx)

Local aSize      := MsAdvSize()
Local aPosObj    := {}
Local aObjects   := {}
Local aArea      := GetArea()
Local nX         := 0
Local nOpcA      := 0
Local oDlg
Local aCpos      := {}
Local aButtons   := {}

Private oGetDados
Private aCols    := {}
Private aHeader  := {}
Private aTela[0][0]
Private aGets[0]


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariaveis de Memoria - Enchoice Principal         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SZ4")
dbSetOrder(1)
For nX := 1 To FCount()
	If nOpcx == 3
		M->&(FieldName(nX)) := CriaVar(FieldName(nX))
	Else
		M->&(FieldName(nX)) := FieldGet(nX)
	EndIf
Next nX



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMontagem do aHeader - GetDados                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SX3")
dbSetOrder(1)
If dbSeek("SZ5", .F.)
	While !Eof() .And. SX3->X3_ARQUIVO=="SZ5"
		
		If X3USO(SX3->X3_USADO) //.And. cNivel >= SX3->X3_NIVEL)
			
			aAdd(aHeader,{AllTrim(X3Titulo()),;
			AllTrim(SX3->X3_CAMPO),;
			SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,;
			SX3->X3_DECIMAL,;
			SX3->X3_VALID,;
			SX3->X3_USADO,;
			SX3->X3_TIPO,;
			SX3->X3_F3,;
			SX3->X3_CONTEXT})
		EndIf
		dbSkip()
	EndDo
EndIf


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMontagem do aCols - GetDados                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOpcx == 3 //Inclusao
	aAdd(aCols,Array(Len(aHeader)+1))
	For nX := 1 To Len(aHeader)
		aCols[1, nX] := CriaVar(aHeader[nX, 2])
	Next nX
	aCols[Len(aCols), Len(aHeader)+1] := .F.
Else
	dbSelectArea("SZ5")
	dbSetOrder(1)
	dbSeek(xFilial()+SZ4->Z4_COD)
	While !Eof() .And. SZ4->Z4_FILIAL = xFilial("SZ5") .And. SZ4->Z4_COD == SZ5->Z5_COD
		
		
		aAdd(aCols,Array(Len(aHeader)+1))
		
		For nCntFor	:= 1 To Len(aHeader)
			If ( aHeader[nCntFor][10] != "V" )
				aCols[Len(aCols)][nCntFor] := FieldGet(FieldPos(aHeader[nCntFor][2]))
			Else
				aCols[Len(aCols)][nCntFor] := CriaVar(aHeader[nCntFor][2],.T.)
			EndIf
		Next nCntFor
		aCols[Len(aCols), Len(aHeader)+1] := .F.
		dbSkip()
		
		
	EndDo
	
Endif


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMonta a tela										 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aObjects := {}
aAdd( aObjects, {   0, 150, .t., .f. } )
aAdd( aObjects, { 100, 100, .t., .t. } )
aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],00 To aSize[6],aSize[5] OF oMainWnd PIXEL

EnChoice( cAlias ,nReg, nOpcx, , , ,  ,APOSOBJ[1], , nOpcx)
oGetDados := MSGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpcx,"U_A001LinOK",,,.T.,,,.T.,900,,,,,)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpca:=1,If(U_A001TudoOK(aGets,aTela),oDlg:End(),nOpca:=0)},{||nOpca:=0,oDlg:End()},,aButtons)


If nOpcA == 1
	Begin Transaction
	A001Grv(nOpcx)
	
	IF ( __lSx8 )
		ConfirmSX8()
	EndIF
	
	End Transaction
EndIf

MsUnLockAll()

RestArea(aArea)

Return(.T.)




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณA001Grv   บAutor  ณMauro Sano          บ Data ณ  26/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gravacao.                                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A001Grv(nOpc)
Local nCntFor := 0
Local nCntFor1:= 0
Local nUsado  := Len(aHeader)
Local nUsado1 := Len(aCols)

Do Case
	
	Case nOpc == 3	    //inclusao
		                                            
		//inclusao do cabecalho
		dbSelectArea("SZ4")
		Reclock("SZ4",.T.)
		For nCntFor := 1 To FCount()
			If (FieldName(nCntFor)!="Z4_FILIAL")
				FieldPut(nCntFor,M->&(FieldName(nCntFor)))
			Else
				SZ4->Z4_FILIAL := xFilial()
			EndIf
		Next nCntFor
		MsUnlock()
		
		
		//inclusao dos itens
		For nCntFor := 1 To nUsado1
			If ( !aCols[nCntFor][nUsado+1] )
				dbSelectArea("SZ5")
				Reclock("SZ5",.T.)
				For nCntFor1 := 1 To nUsado
					If ( aHeader[nCntFor1][10] != "V" )
						SZ5->(FieldPut(FieldPos(Trim(aHeader[nCntFor1][2])),aCols[nCntFor][nCntFor1]))
					EndIf
				Next nCntFor1
				SZ5->Z5_FILIAL := xFilial("SZ5")
				SZ5->Z5_COD := M->Z4_COD
				MsUnlock()
			EndIf
		Next nCntFor
		
	Case nOpc == 4  //Alteracao
		
		//alteracao do cabecalho
		dbSelectArea("SZ4")
		Reclock("SZ4",.F.)
		For nCntFor := 1 To FCount()
			If (FieldName(nCntFor)!="Z4_FILIAL")
				FieldPut(nCntFor,M->&(FieldName(nCntFor)))
			Else
				SZ4->Z4_FILIAL := xFilial()
			EndIf
		Next nCntFor
		MsUnlock()
		
		
		//exclusao dos itens
		dbSelectArea("SZ5")
		dbSetOrder(1)
		If dbSeek(xFilial()+M->Z4_COD)
			While !Eof() .And. SZ5->Z5_FILIAL == xFilial() .And. SZ5->Z5_COD == M->Z4_COD
				Reclock("SZ5",.F.)
				dbDelete()
				MsUnlock()
				dbSkip()
			EndDo
		EndIf
		
		//inclusao dos itens
		For nCntFor := 1 To nUsado1
			If ( !aCols[nCntFor][nUsado+1] )
				dbSelectArea("SZ5")
				Reclock("SZ5",.T.)
				For nCntFor1 := 1 To nUsado
					If ( aHeader[nCntFor1][10] != "V" )
						SZ5->(FieldPut(FieldPos(Trim(aHeader[nCntFor1][2])),aCols[nCntFor][nCntFor1]))
					EndIf
				Next nCntFor1
				SZ5->Z5_FILIAL := xFilial("SZ5")
				SZ5->Z5_COD := M->Z4_COD
				MsUnlock()
			EndIf
		Next nCntFor
		
	Case nOpc == 5  //Exclusao
		
		//exclusao dos itens
		dbSelectArea("SZ5")
		dbSetOrder(1)
		If dbSeek(xFilial()+M->Z4_COD)
			While !Eof() .And. SZ5->Z5_FILIAL == xFilial() .And. SZ5->Z5_COD == M->Z4_COD
				Reclock("SZ5",.F.)
				dbDelete()
				MsUnlock()
				dbSkip()
			EndDo
		EndIf
		
		
		//exclusao do cabecalho
		dbSelectArea("SZ4")
		Reclock("SZ4",.F.)
		dbDelete()
		MsUnlock()
		
		
		
		
EndCase  

If nOpc == 3
	ConfirmSx8()
EndIf


Return .T.                                                                 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณA001LinOK บAutor  ณMauro Sano          บ Data ณ  26/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Validacao da linha da getdados.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function A001LinOK()
Local lRet := .T.


Return lRet        

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno	 ณTkContatos    ณ Autor ณMauro SAno             ณ Data ณ 09/04/01 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณMostra os Contatos do cliente selecinado 			              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso   	 ณSigatmk - Com fun”es do TeleMarketing     				      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAnalista  ณ Data/Bops/Ver ณManutencao Efetuada                         	  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณMarcelo K ณ06/06/02ณ710   ณ-Revisao do fonte                           	  ณฑฑ
ฑฑณ          ณ        ณ      ณ                                            	  ณฑฑ
ฑฑณ          ณ        ณ      ณ                                            	  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TkContatos()

Local oLbx										//Listbox com os nomes dos contatos
Local aCont    := {}							//Array com os contatos
Local cDFuncao := CRIAVAR("U5_FUNCAO",.F.)		//Funcao do contato na empresa	
Local cCliente := ""							//Codigo do cliente
Local cLoja    := ""							//Loja do cliente
Local cDesc    := ""							//Decricao do cliente
Local cEntidade:= ""						 	//Alias da entidade
Local nOpcao   := 0								//Opcao 
Local nContato := 0								//Posicao do contato dentro do array na selecao
Local oDlg										//Tela
Local lRet	   := .F.							//Retorno da tela

If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S' 
	cEntidade := "SU5"
Else
	cEntidade := "SA1"
EndIf

cCliente := aCols[n,GdFieldPos("Z5_CODENV",aHeader)]
cLoja    := aCols[n,GdFieldPos("Z5_LOJA",aHeader)]
cDesc    := aCols[n,GdFieldPos("Z5_NOME",aHeader)]   

If Empty(cCliente)
	Help(" ",1,"SEM CLIENT")
	Return(lRet)
Endif

DbSelectArea("AC8")
DbSetOrder(2)		//AC8_FILIAL+AC8_ENTIDA+AC8_FILENT+AC8_CODENT+AC8_CODCON
If DbSeek(xFilial("AC8") + cEntidade + xFilial(cEntidade) + cCliente + cLoja) 

	While (!Eof())										.AND.;
		  (AC8->AC8_FILIAL == xFilial("AC8")) 			.AND.;
		  (AC8->AC8_ENTIDA == cEntidade)			 	.AND.;
		  (AC8->AC8_FILENT == xFilial(cEntidade)) 		.AND.;
		  (AllTrim(AC8->AC8_CODENT) == AllTrim(cCliente + cLoja))
		
		DbSelectArea("SU5")
		DbSetOrder(1)
		If DbSeek(xFilial("SU5") + AC8->AC8_CODCON)
			cDFuncao := Posicione("SUM",1,xFilial("SUM")+SU5->U5_FUNCAO,"UM_DESC")

			Aadd(aCont, {	SU5->U5_CODCONT,;		//Cขdigo
							SU5->U5_CONTAT,;		//Nome 
							cDFuncao,;				//Funo
							SU5->U5_FONE,;			//Telefone
							SU5->U5_OBS;			//Observacao
							} )
		Else
			Aadd(aCont,{"","","","",""})
		Endif
		DbSelectArea("AC8")
		DbSkip()
	End
Else
	If TkIncCt(@oLbx,@aCont,.T.,cEntidade,cCliente,cLoja,cDesc) == 3 // Cancelou a Inclusao
		Return(lRet)
	Else 
		lRet := .T.	
		Return(lRet)
	Endif
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Mostra dados dos Contatos 								     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE MSDIALOG oDlg FROM  48,171 TO 230,800 TITLE "Cadastro de Contatos"  + " - " + cDesc PIXEL //"Cadastro de Contatos" 
	
	@  3,2 TO  73, 310 LABEL "Cadastro de Contatos" +":" OF oDlg  PIXEL //"Cadastro de Contatos" 
	@ 10,5	LISTBOX oLbx FIELDS ;
			HEADER ;
			"Cขdigo",; //"Cขdigo"
			"Nome",; //"Nome", 
			"Funo",; //"Funo"
			"Telefone",; //"Telefone" 
			"Observao";  //"Observao" 
			SIZE 303,60  NOSCROLL OF oDlg PIXEL ;
			ON DBLCLICK( nOpcao:= 1,nContato := oLbx:nAt,oDlg:End() )
	
			oLbx:SetArray(aCont)
			oLbx:bLine:={ || {	aCont[oLbx:nAt,1],;	//Cขdigo
								aCont[oLbx:nAt,2],;	//Nome 
								aCont[oLbx:nAt,3],;	//Funo
								aCont[oLbx:nAt,4],;	//Telefone
								aCont[oLbx:nAt,5];	//Observacao
								}}
					
	DEFINE SBUTTON FROM 74,162 TYPE 4	ENABLE OF oDlg ACTION TkIncCt(	@oLbx	, @aCont	, .F.	, cEntidade	,;
																		cCliente, cLoja		, cDesc	)
	
	DEFINE SBUTTON FROM 74,252 TYPE 1	ENABLE OF oDlg ACTION (nOpcao:= 1,nContato:= oLbx:nAt,oDlg:End())
	DEFINE SBUTTON FROM 74,282 TYPE 2	ENABLE OF oDlg ACTION (nOpcao:= 0,oDlg:End())

ACTIVATE MSDIALOG oDlg CENTERED 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPosiciona no registro correto para ser atualizado o campo de codigo do contato.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea("SU5")
DbSetOrder(1)
If (nOpcao == 1)
	lRet := .T.
	DbSeek(xFilial("SU5") + aCont[nContato,1])
Endif

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno	 ณTkIncCt	ณ Autor ณ Marcelo Kotaki   		ณ Data ณ11/03/04  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณExecuta a rotina de Inclusao de novos contatos              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso		 ณCALL CENTER                                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAnalista  ณ Data/Bops/Ver ณManutencao Efetuada                      	  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAndrea F. ณ09/11/05ณ8.11  ณBOPS 87918 - Tratamento para preenchimento  ณฑฑ
ฑฑณ          ณ        ณ      ณdos campos com inicializador padrao.        ณฑฑ
ฑฑณNorbert W.ณ01/06/07ณ9.12  ณBOPS 126595 - A condicao para leitura do AC8ณฑฑ
ฑฑณ          ณ        ณ      ณnao previa o uso de filiais com somente um  ณฑฑ
ฑฑณ          ณ        ณ      ณcaractere.                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function TkIncCt(oLbx	, aCont	, lNovo	, cEntidade	,;
						cCliente, cLoja	, cDesc	)

Local aArea   		:= GetArea()							// Salva a area atual
Local nOpca     	:= 0									// Opcao de OK ou CANCELA
Local cDFuncao  	:= CRIAVAR("U5_FUNCAO",.F.)			// Cargo da funcao do contato
Local cAlias    	:= ""				// Alias 
Local lIncluiAnt	:= INCLUI                          		// Guarda o conteudo da variavel para restaurar apos a inclusao do contato
Private cCadastro 	:= "Incluso de Contatos"			 					// "Incluso de Contatos"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณNa Inclusao, a variavel INCLUI devera estar como .T.  para executar  o inicializador ณ
//ณpadrao de alguns campos que sao preenchidos somente se a variavel estiver .T. 		ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
INCLUI:= .T. 

If aCols[n,GdFieldPos("Z5_PROSPEC",aHeader)] == 'S' 
	cAlias := "SU5"
Else
	cAlias := "SA1"
EndIf

DbSelectArea("SU5")
nOpcA := AxInclui("SU5",0,3,)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRestauva a variavel com o conteudo originalณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
INCLUI:= lIncluiAnt

If (nOpca == 1)
	DbSelectArea("AC8")
	RecLock("AC8",.T.)
	Replace AC8_FILIAL With xFilial("AC8")
	Replace AC8_FILENT With xFilial(cEntidade)
	Replace AC8_ENTIDA With cEntidade
	Replace AC8_CODENT With cCliente + cLoja
	Replace AC8_CODCON With SU5->U5_CODCONT
	MsUnLock()
	DbCommit()
Endif

// Se houve inclusao do registro atualizo o listbox de contatos
If nOpcA == 1
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณSe esse  o primeiro contato a ser cadastrado fecho a ณ
	//ณtela e abro novamente para a criao do objeto listboxณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lNovo
		u_TkContatos()
		Return(nOpcA)
	Endif
	
	aCont := {}
	
	DbSelectArea("AC8")
	DbSetOrder(2)
	If DbSeek(xFilial("AC8") + cAlias + xFilial(cAlias) + cCliente + cLoja,.T.)

		While (!Eof()) 								.AND. ;
			  (AC8->AC8_FILIAL == xFilial("AC8")) 	.AND.;
			  (AC8->AC8_ENTIDA == cAlias) 			.AND.;
			  (AC8->AC8_FILENT == xFilial(cAlias)) 	.AND. ;
			  (AllTrim(AC8->AC8_CODENT) == AllTrim(cCliente + cLoja))
		
			DbSelectArea("SU5")
			DbSetOrder(1)
			If DbSeek(xFilial("SU5") + AC8->AC8_CODCON)
				cDFuncao := Posicione("SUM",1,xFilial("SUM")+SU5->U5_FUNCAO,"UM_DESC")

				Aadd(aCont,{SU5->U5_CODCONT,;		//Cขdigo
							SU5->U5_CONTAT,;		//Nome 
							cDFuncao,;				//Funo
							SU5->U5_FONE,;			//Telefone
							SU5->U5_OBS} )			//Observacao
			Else
				Aadd(aCont,{"","","","",""})
			Endif
		
			DbSelectArea("AC8")
			DbSkip()
		End
	Endif	
		
	oLbx:SetArray(aCont)
	oLbx:nAt:= Len(aCont)
	oLbx:bLine:={||{aCont[oLbx:nAt,1],;  //Cขdigo
					aCont[oLbx:nAt,2],;  //Nome 
					aCont[oLbx:nAt,3],;	 //Funo
					aCont[oLbx:nAt,4],;	 //Telefone
					aCont[oLbx:nAt,5] }} //Observacao
	oLbx:Refresh()
Endif

RestArea(aArea)
Return(nOpcA)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณA001TudoOKบAutor  ณMauro Sano          บ Data ณ  26/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Validacao da linha da getdados.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function A001TudoOK()

lRet := .T.
Return lRet
