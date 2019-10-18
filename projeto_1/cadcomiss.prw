#INCLUDE "Protheus.ch"    

#DEFINE NMAXPAGE 50

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSZA       บAutor  ณReginaldo G.Ribeiro บ Data ณ 22/11/12 	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cadastro SZA - Cadastro de Tab Desconto X Comiss๕es        บฑฑ
ฑฑบ          ณ  						                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico Daisa                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CadComiss()

Private cCadastro := "Cadastro de Desconto X Comiss๕es"
Private cCC 		:= Space(6)
Private cDesc		:= Space(30)
Private cIni		:= DtoC(Date())
Private cFim		:= DtoC(Date())
Private aRotina   := MenuDef() //Implementa menu funcional


	DbSelectArea("SZA")
	SZA->( DbGotop() )
	
	mBrowse( 6,1,22,75,"SZA")
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Devolve os indices padroes do SIGA.                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RetIndex("SZA")
	
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSZAManut  บAutor  ณReginaldo G.Ribeiro บ Data ณ 22/11/12 	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina de Inclusใo, Alter็ใo, vizualiza็ใo e Exclusใo do   บฑฑ
ฑฑบ          ณ Cadastro de Desconto X Comissใo							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico CadComis                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SZAManut(cAlias, nReg, nOpcao)

Local aSize		  	:= MsAdvSize()
Local aObjects	  	:= {}
Local aInfo		  	:= {}
Local aPosObj	  	:= {}
Local oDlg
Local nOpca      	:= 0
Local aTmpCols   	:= {}
Local aButtons   	:= {}
Local nX         	:= 0
Local nY         	:= 0 
Local nI         	:= 0
Local lRet          := .F.
Local nInd			:= 0      
Local aCpoGDa       := {"ZA_ITEM","ZA_CATEG", "ZA_PORCENT", "ZA_PCOMIRP", "ZA_PCOMGR", "ZA_PCOMGN"} 
Local nSaveSx8      := GetSx8Len() 

Local cLinhaOk     	:= "AllwaysTrue"   // Funcao executada para validar o contexto da linha atual do aCols                  
Local cTudoOk      	:= "AllwaysTrue"   // Funcao executada para validar o contexto geral da MsNewGetDados (todo aCols)      
Local cIniCpos     	:= "+ZA_ITEM"               // Nome dos campos do tipo caracter que utilizarao incremento automatico
Local aAlter       	:= {"ZA_CATEG", "ZA_PORCENT", "ZA_PCOMIRP", "ZA_PCOMGR", "ZA_PCOMGN"} 	//// Vetor com os campos que poderao ser alterados
Local nFreeze      	:= 000              // Campos estaticos na GetDados
Local nMax         	:= 999              // Numero maximo de linhas permitidas. Valor padrao 99
Local cCampoOk     	:= "AllwaysTrue"    // Funcao executada na validacao do campo
Local cSuperApagar 	:= ""               // Funcao executada quando pressionada as teclas <Ctrl>+<Delete>
Local cApagaOk     	:= "AllwaysTrue"   // Funcao executada para validar a exclusao de uma linha do aCols
Local oWnd          	:= oDlg        //Objeto para refencia da GetDados
Local aAux				:= {}

Private oCC, oFont, oDesc, oIni, oFim
Private oGet
Private aHeader   	:= {}
Private N        	:= 1
Private aCols    	:= {}
Private aRegs    	:= {}
Private aTela[0][0],aGets[0]
Private nOpc     	:= nOpcao
Private lConsultaF3 := .f.   

	DbSelectArea("SX3")
	SX3->(DbSetOrder(2)) // Campo
	For nX := 1 to Len(aCpoGDa)
		If SX3->(DbSeek(aCpoGDa[nX]))
			Aadd(aHeader,{ AllTrim(X3Titulo()),;
			SX3->X3_CAMPO	,;
			SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,;
			SX3->X3_DECIMAL,;
			SX3->X3_VALID	,;
			SX3->X3_USADO	,;
			SX3->X3_TIPO	,;
			SX3->X3_F3 		,;
			SX3->X3_CONTEXT,;
			SX3->X3_CBOX	,;
			SX3->X3_RELACAO})
		Endif
	Next nX
	
	DbSelectArea("SZA")
	SZA->( DbSetOrder(1) )
	
	RegToMemory("SZA",If(nOpc==3,.T.,.F.))
	
	If nOpc == 3
		cCC := GetSX8Num("SZA","ZA_NUM")
		cDesc := Space(30)
	EndIf
	
	If nOpc == 3
		aAux := {}
		DbSelectArea("SX3")
		SX3->(DbSetOrder(2)) // Campo
		For nX := 1 to Len(aCpoGDa)
			If SX3->(DbSeek(aCpoGDa[nX]))
				If AllTrim(aCpoGDa[nX]) == "ZA_ITEM"
					Aadd(aAux, StrZero(1,TamSX3("ZA_ITEM")[1]))
				Else
					If AllTrim(aCpoGDa[nX]) <> "ZA_FILIAL" .AND. AllTrim(aCpoGDa[nX]) <> "ZA_DESC"
						Aadd(aAux,CriaVar(SX3->X3_CAMPO))
					EndIf
				Endif
				
			Endif
		Next nX
		
		Aadd(aAux,.F.)
		
	Else
		dbSetOrder(1)
		aTmpCols  := aClone( a610CriaCols( "SZA", aHeader, xFilial("SZA")+M->ZA_NUM , {|| SZA->( M->ZA_FILIAL+M->ZA_NUM ) == xFilial( "SZA" )+SZA->ZA_NUM }, Nil ) )
		cCC		:= M->ZA_NUM
		cDesc	:= M->ZA_DESC ///Descri็ใo
	EndIf
	dbSetOrder(1)
	
	If nOpc == 3
		aCols := {}
		Aadd(aCols,aAux)
	Else
		aCols := aClone( aTmpCols[1] )
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Calcula as dimensoes dos objetos.                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aAdd( aObjects, { 100,070,.T.,.T. } )
	aAdd( aObjects, { 100,030,.T.,.T. } )
	
	aInfo    := { aSize[1],aSize[2],aSize[3],aSize[4], 3, 3 }
	aPosObj  := MsObjSize( aInfo, aObjects,.T. )
	
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],00 TO aSize[6],aSize[5] PIXEL
	DEFINE FONT oFont NAME "Arial" SIZE 0,-11 BOLD
	
	@ C(015),C(010) Say "Tabela:"	Size C(050),C(008) PIXEL OF oDlg //verificar
	@ C(013),C(035) MsGet oCC Var cCc Size C(025),C(008) FONT oFont PIXEL OF oDlg  WHEN If(nOpc == 3, .T.,.F.)  Picture "@!"
	
	@ C(015),C(100) Say "Descri็ใo:" 	Size C(050),C(008) PIXEL OF oDlg
	@ C(013),C(135) MsGet oDesc Var cDesc 	Size C(120),C(008) FONT oFont PIXEL OF oDlg  Picture "@!"
	
	@ C(015),C(275) Say "Ini vig:" 	Size C(050),C(008) PIXEL OF oDlg
	@ C(013),C(295) MsGet oIni Var cIni 	Size C(025),C(008) FONT oFont PIXEL OF oDlg  Picture "@E 99/99/9999"
	
	@ C(015),C(325) Say "Ini vig:" 	Size C(050),C(008) PIXEL OF oDlg
	@ C(013),C(350) MsGet oFim Var cFim 	Size C(025),C(008) FONT oFont PIXEL OF oDlg  Picture "@E 99/99/9999"
	
	
	//oGet:=MsNewGetDados():New(aPosObj[1,1]+15 ,aPosObj[1,2],aPosObj[2,3],aPosObj[2,4],If(nOpc = 3 .or. nOpc = 4, GD_INSERT+GD_DELETE+GD_UPDATE,2);
	//							,cLinhaOk,u_ValidCod(),cIniCpos,aAlter,nFreeze,nMax,cCampoOk,cSuperApagar,cApagaOk,oWnd,aHeader,aCols)
	
	oGet:=MsNewGetDados():New(aPosObj[1,1]+32 ,aPosObj[1,2],aPosObj[2,3],aPosObj[2,4],If(nOpc = 3 .or. nOpc = 4, GD_INSERT+GD_DELETE+GD_UPDATE,2);
	                           ,cLinhaOk,"", cIniCpos,aAlter,nFreeze,nMax,cCampoOk,cSuperApagar,cApagaOk,oWnd,aHeader,aCols)
	
	
	oGet:oBrowse:lDisablePaint := .F.
	oGet:ForceRefresh()
	
	ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar( oDlg, {|| nOpcA:= 1, oDlg:End() }, {|| nOpcA := 2, oDlg:End() },, aButtons )) CENTER
	
	If nOpcA == 1 //Grava็ใo
		If nOpc <> 2 //Visualiza็ใo
			Begin Transaction
			GravaSZA(cAlias,nOpc)
			While (GetSx8Len() > nSaveSx8 )
				ConfirmSX8()
			EndDo
			EvalTrigger()
			End Transaction
		EndIf
	Else
		While (GetSx8Len() > nSaveSx8 )
			RollBackSX8()
		EndDo
	EndIf
	
Return

/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravaSZA  บAutor  ณMicrosiga           บ Data ณ 19/01/11 	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cadastro SZA	                                              บฑฑ
ฑฑบ          ณ 										                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Procedure GravaSZA(cAlias,nOpc)

Local nInd 
Local nPosItem		:= 0
Local nPosDesc		:= 0
Local nPosCodA		:= 0 
Local nPosItem		:= 0
LocAL aUsuario 		:= PswRet()
Local bCampo   		:= {|nCPO| Field(nCPO) }

	nPosItem  := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_ITEM"})
	nPosDesc  := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_DESC"})
	nPosCateg := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_CATEG"})
	nPosPorc  := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_PORCENT"})
	nPosPRep  := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_PCOMIRP"})
	nPosPGerR := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_PCOMGR"})
	nPosPGerN := Ascan(aHeader, {|x| AllTrim(x[2]) == "ZA_PCOMGN"})
	
	//Grava็ใo da solicita็ใo (SZA)
	
	If nOpc == 3 .or. nOpc == 4
		DBSelectArea(cAlias)
		
		For nInd:=1 To Len(oget:aCols)
			
			If !(oget:aCols[nInd][Len(oget:aCols[nInd])])
				
				If SZA->(DbSeek(xFilial("SZA")+cCC+oget:aCols[nInd][nPosItem] ) )
					RecLock("SZA",.F.)
				Else
					RecLock("SZA",.T.)
				EndIf
				
				SZA->ZA_FILIAL  	:= xFilial("SZA")
				SZA->ZA_ITEM    	:= oget:aCols[nInd][nPosItem]
				SZA->ZA_NUM			:= cCC
				SZA->ZA_DESC		:= cDesc
				SZA->ZA_INIVIG		:= STOD(cIni)
				SZA->ZA_FIMVIG		:= STOD(cFim)
				SZA->ZA_CATEG		:= oget:aCols[nInd][nPosCateg]
				SZA->ZA_PORCENT		:= oget:aCols[nInd][nPosPorc]
				SZA->ZA_PCOMIRP		:= oget:aCols[nInd][nPosPRep]
				SZA->ZA_PCOMGR		:= oget:aCols[nInd][nPosPGerR]
				SZA->ZA_PCOMGN		:= oget:aCols[nInd][nPosPGerN]
				SZA->( MsUnLock() )
				
				If nOpc == 3
					ConfirmSX8()
				EndIf
			Else
				If SZA->(DbSeek(xFilial("SZA")+cCC+oget:aCols[nInd][nPosItem]))
					SZA->(RecLock("SZA",.F.))
					SZA->(DbDelete())
					SZA->(MsUnlock())
				EndIf
			EndIf
		Next nInd
	Else
		SZA->(DbSetOrder(1))
		If SZA->(DbSeek(xFilial("SZA")+cCC))
			While SZA->(!EOF() .and. xFilial("SZA")+cCC == ZA_FILIAL+ZA_NUM )
				SZA->(RecLock("SZA",.F.))
				SZA->(DbDelete())
				SZA->(MsUnlock())
				SZA -> (DBSkip())
			End
		EndIF
	EndIf
		
Return              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ MenuDEF  บ Autor ณMicrosiga           บ Data ณ  19/01/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cadastro SZ4				                                  บฑฑ
ฑฑบ          ณ 									                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MenuDef()


Local aRotina	:= {{ "Pesquisar" ,"AxPesqui"   ,0,1},;		//"Pesquisar"
					{ "Visualizar","U_SZAManut",0,2},;		//"Visualizar"
					{ "Incluir"   ,"U_SZAManut",0,3,81},;	//"Incluir"
					{ "Alterar"   ,"U_SZAManut",0,4,81},;	//"Alterar"
					{ "Excluir"   ,"U_SZAManut",0,5,81}}	//"Excluir"
Return aRotina  