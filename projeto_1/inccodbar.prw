#INCLUDE "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³INCCODBAR º Autor ³ waldir              º Data ³  12/01/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Inclusai de Codigo de Barras via Leitor.                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SALTON                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function INCCODBAR()

	Local oFont1 		:= TFont():New("Arial",,022,,.F.,,,,,.F.,.F.)

	Private cGetCod 	:= Space(TamSx3("E2_CODBAR")[1])
	Private aListBox	:= {}

	Private oGetCod
	
	Static oDlgCB

	//Inicia Array com Valorez em Branco
	Aadd(aListBox,{	.F.,;		//[01] - Mark
					"",;		//[02] - Prefixo
					"",;		//[03] - Nro do titulo
					"",;		//[04] - Parcela
					"",;		//[05] - Tipo
					CtoD(""),;	//[06] - Vencimento
					0,;			//[07] - Valor
					"",;		//[08] - Fornecedor
					0})			//[09] - Recno do E2
	
	DEFINE MSDIALOG oDlgCB TITLE "Cadastro de Código de Barras" FROM 000, 000  TO 400, 800 COLORS 0, 16777215 PIXEL
	
		@ 000, 000 MSPANEL oPanel1 SIZE 300, 021 OF oDlgCB COLORS 0, 16777215 RAISED
		@ 021, 000 MSPANEL oPanel2 SIZE 300, 028 OF oDlgCB COLORS 0, 16777215 RAISED
		@ 176, 000 MSPANEL oPanel3 SIZE 300, 023 OF oDlgCB COLORS 0, 16777215 RAISED

		@ 006, 140 SAY oSay1 PROMPT "Cadastro de Código de Barras" SIZE 116, 012 OF oPanel1 FONT oFont1 COLORS 0, 16777215 PIXEL

		@ 010, 010 SAY oSay2 PROMPT "Cod. de Barras : " SIZE 045, 007 OF oPanel2 COLORS 0, 16777215 PIXEL
		@ 010, 051 MSGET oGetCod VAR cGetCod SIZE 150, 008 OF oPanel2 COLORS 0, 16777215 PIXEL ON CHANGE( PESQTIT() )

		@ 005, 155 BUTTON oButton1 PROMPT "Gravar" 		SIZE 037, 012 OF oPanel3 PIXEL	Action( GRAVATIT() )
		@ 005, 197 BUTTON oButton2 PROMPT "Sair" 		SIZE 037, 012 OF oPanel3 PIXEL	Action( oDlgCB:End() )

		fListBox()
	
		oPanel1:Align 	:= CONTROL_ALIGN_TOP
		oPanel2:Align 	:= CONTROL_ALIGN_TOP
		oPanel3:Align 	:= CONTROL_ALIGN_BOTTOM
		oListBox:Align := CONTROL_ALIGN_ALLCLIENT
		
	ACTIVATE MSDIALOG oDlgCB CENTERED

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ FUNCTION FLISTBOX (LIST BOX DOS TITULOS ENCONTRADOS)         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fListBox()

	Static oOk := LoadBitmap( GetResources(), "LBOK")
	Static oNo := LoadBitmap( GetResources(), "LBNO")

	Static oListBox

	@ 049, 000 LISTBOX oListBox Fields HEADER "","Prefixo","Titulo","Parcela","Tipo","Vencimento","Valor","Fornecedor" SIZE 300, 127 OF oDlgCB PIXEL ColSizes 50,50

	oListBox:SetArray(aListBox)

	oListBox:bLine := {|| {;
							If(aListBox[oListBox:nAT,1],oOk,oNo),;
							aListBox[oListBox:nAt,2],;
							aListBox[oListBox:nAt,3],;
							aListBox[oListBox:nAt,4],;
							aListBox[oListBox:nAt,5],;
							DtoC(aListBox[oListBox:nAt,6]),;
							Transform(aListBox[oListBox:nAt,7],"999,999,999.99"),;
							aListBox[oListBox:nAt,8];
							}}

	// DoubleClick event
	oListBox:bLDblClick := {|| VerClick(), 	oListBox:DrawSelect()}

	// Scroll type
	oListBox:nScrollType := 1
	
Return Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ FUNCTION PESQTIT (PESQUISA TITULOS NO CONTAS A PAGAR)        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PESQTIT()

	Local cSE2 		:= ""
	Local cValor	:= ""
	Local cWhere	:= "%E2_CODBAR = '' AND E2_SALDO > 0%"
	Local lRetorno	:= .T.
	Local lExiste	:= .F.

	Local nValor	:= 0
	
	aListBox := {}
	
	If !Empty(cGetCod)
	
		cValor 	 := SubStr(cGetCod,10,08) + "." + SubStr(cGetCod,18,02)
		nValor	 := NoRound(Val(cValor),TamSx3("E2_VALOR")[2])
			
		cSE2 	:= GetNextAlias()
	
		BeginSQL Alias cSE2
	
			SELECT	E2_PREFIXO	PREFIXO
			,		E2_NUM		NUM
			,		E2_PARCELA	PARCELA
			,		E2_TIPO		TIPO
			,		E2_VENCREA	VENCIMENTO
			,		E2_VALOR	VALOR
			,		E2_NOMFOR	FORNECEDOR
			,		R_E_C_N_O_	RECE2
			FROM	%table:SE2%
			WHERE	%NotDel%
					AND E2_VALOR = %Exp:nValor%
					AND %Exp:cWhere%
			ORDER BY VENCIMENTO
	
		EndSQL
		
		If !(cSE2)->(Eof())
			
			lExiste := .T.
			
			While !(cSE2)->(Eof())
	
				Aadd(aListBox,{	.F.,;						//[01] - Mark
								(cSE2)->PREFIXO,;			//[02] - Prefixo
								(cSE2)->NUM,;				//[03] - Nro do titulo
								(cSE2)->PARCELA,;			//[04] - Parcela
								(cSE2)->TIPO,;				//[05] - Tipo
								StoD((cSE2)->VENCIMENTO),;	//[06] - Vencimento
								(cSE2)->VALOR,;				//[07] - Valor
								(cSE2)->FORNECEDOR,;		//[08] - Fornecedor
								(cSE2)->RECE2})				//[09] - Recno do E2
	
				(cSE2)->(DbSkip())
			Enddo

		Else
			Aviso("Aviso","Nenhum Título Encontrado",{"Ok"})
			lRetorno := .F.
		EndIf
		
		(cSE2)->(DbCloseArea())
		
	EndIf
	
	If !lExiste

		Aadd(aListBox,{	.F.,;		//[01] - Mark
						"",;		//[02] - Prefixo
						"",;		//[03] - Nro do titulo
						"",;		//[04] - Parcela
						"",;		//[05] - Tipo
						CtoD(""),;	//[06] - Vencimento
						0,;			//[07] - Valor
						"",;		//[08] - Fornecedor
						0})			//[09] - Recno do E2
	EndIf
	
	oListBox:SetArray(aListBox)
	oListBox:bLine := {|| {;
							If(aListBox[oListBox:nAT,1],oOk,oNo),;
							aListBox[oListBox:nAt,2],;
							aListBox[oListBox:nAt,3],;
							aListBox[oListBox:nAt,4],;
							aListBox[oListBox:nAt,5],;
							DtoC(aListBox[oListBox:nAt,6]),;
							Transform(aListBox[oListBox:nAt,7],"999,999,999.99"),;
							aListBox[oListBox:nAt,8];
							}}

	oListBox:Refresh()
	
Return lRetorno

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ FUNCTION VERCLICK (VALIDA O TITULO CLICADO)                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function VERCLICK()
	
	Local nX
	Local lDuplica	:= .F.
	
	If !aListBox[oListBox:nAT][1]

		lDuplica := .F.

		For nX := 1 To Len(aListBox)
			If aListBox[nX][1] .And. nX <> oListBox:nAT
				Alert ("Já existe um título selecionado! Desmarque primeiro antes de Marcar outro!!")	
				lDuplica := .T.
				Exit
			EndIf
		Next nX
		
		If !lDuplica .And. aListBox[oListBox:nAT][9] > 0
			aListBox[oListBox:nAT][1] := .T.
		EndIf

	Else
		aListBox[oListBox:nAT][1] := .F.
	EndIf
	
Return Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ FUNCTION GRAVATIT (GRAVA O CODIGO DE BARRAS NO TITULO)       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function GRAVATIT()
	
	Local nOpc		:= 0
	Local lMark		:= .F.
	Local nI		:= 0
	
	If Empty(cGetCod)
		MsgAlert("Código de Barras Inválido...","Verifique")
		Return Nil
	EndIf
	
	nOpc := Aviso("Aviso","Confirma Gravação do Código de Barras?",{"Sim","Não"},2)
	
	If nOpc == 2
		Return Nil
	EndIf
	
	For nI := 1 To Len(aListBox)
		If aListBox[nI][01]
			If aListBox[nI][09] <> 0
				lMark := .T.
				DbSelectarea("SE2")
				SE2->(DbGoto(aListBox[nI][09]))
				RecLock("SE2",.F.)
					SE2->E2_CODBAR	:= cGetCod
				MsUnlock()
			EndIf
		EndIf
	Next nI
	
	If !lMark
		MsgAlert("Nenhum Título foi Selecionado!!!","Verifique")
	Else
		cGetCod := Space(TamSx3("E2_CODBAR")[1])
		oGetCod:Refresh()
		PESQTIT(cGetCod)
	EndIf
	
Return Nil