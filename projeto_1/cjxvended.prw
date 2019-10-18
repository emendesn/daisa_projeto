#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CJXVENDED º Autor ³ Reginaldo G.Ribeiroº Data ³  30/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Gatilhos e Validaçoes na rotina de orcamentos.             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Faturamento - Orçamento                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CJXVENDED(cVended)

Local	ret			:= 	M->CJ_CODVEND
//Local	cClassComi	:= 	STRZERO(val(M->CJ_XCLASS), 6)
Local	Posi_TMP1	:=	TMP1->( RecNo() )  //Guarda a posição da tabela temposraria do Acols
Local 	aAreaAcr	:= 	GetArea()
Local	blZera		:=	.F.
Local	nlDesc1		:= 0
Local	nlDesc2		:= 0
Local	nlDesc3		:= 0
Local	nlDesc4		:= 0

If .Not. Empty(cVended)

	//--   Valores maximos de descontos do vendedor
	DbSelectArea("SA3")
	SA3->( DbSetOrder(1) )
	If SA3->( DbSeek( xFilial("SA3")+cVended) )
		DbSelectArea("SZA")
		SZA->(dbSetOrder(1))
		//If dbSeek(xFilial("SZA")+SA3->A3_XCOMDES)
		//	While !SZA->(Eof()) .And. SZA->ZA_NUM == SA3->A3_XCOMDES
		//		If nlDesc1 <= SZA->ZA_PORCENT
		//			nlDesc1 := SZA->ZA_PORCENT
		//		EndIf
		//		SZA->(DbSkip())
		//	EndDo
		//EndIf
	EndIf

	DbSelectArea("TMP1")
	TMP1->( DbGotop() )	
	While TMP1->( .Not. Eof() )
		
		If TMP1->CK_DESCONT > 50.01//nlDesc1  //Validar o limite do Vendedor
			Alert("Esse vendedor não pode dar desconto superior a " + AllTrim( TransForm( 50, "@r 99.99%") ) + " para o Item: " + TMP1->CK_ITEM)
			blZera	:= .T.  //Zera os valores
		EndIf
		
		If blZera  //Rotina zera descontos
			TMP1->CK_DESCONT := 0
			TMP1->CK_VALOR	 := TMP1->CK_PRUNIT * TMP1->CK_QTDVEN	//Volta o Valor total
			TMP1->CK_PRCVEN  := TMP1->CK_PRUNIT						//Volta o valor unitario
			TMP1->CK_DESCONT := 0 									//Zera o desconto
			TMP1->CK_VALDESC := 0        							//Zera o Valor do Desconto
		EndIf
		
		blZera	:= .F.  //Volta condi~çao inicial
		
		TMP1->(dbSkip())
	End
	
	RestArea(aAreaAcr)
	
	TMP1->(dbGoto(Posi_TMP1))  //Volta a posição da tabela temporaria do Acols
	
EndIf

Return ret    

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CKDESCONT º Autor ³ Reginaldo G.Ribeiroº Data ³  30/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Faturamento - Orçamento                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CKDESCONT(ret)
	
Local	clA3Comiss	:= ''
Local	nlDesc1		:= 0

	If .Not. Empty(M->CJ_CODVEND)
		DbSelectArea("SA3")
		SA3->( DbSetOrder(1) )
		If SA3->( DbSeek( xFilial("SA3") + M->CJ_CODVEND) )
			DbSelectArea("SZA")
			SZA->( DbSetOrder(1) )
			If SZA->( DbSeek(xFilial("SZA")+SA3->A3_XCOMDES) )
				While SZA->( .Not. Eof() ) .And. SZA->ZA_NUM == SA3->A3_XCOMDES
					If nlDesc1 <= SZA->ZA_PORCENT
						nlDesc1 := SZA->ZA_PORCENT //Guarda o maior valor na SZA
					EndIf
					SZA->(DbSkip())
				EndDo
			EndIf
		EndIf
	EndIf
	
	If ret <> nlDesc1  //Validar o limite do Vendedor
		Alert("Esse vendedor não pode dar desconto Diferente a "+AllTrim(TransForm(nlDesc1, "@r 99.99%"))+" para o Item: ")
		ret := 0
		TMP1->CK_DESCONT 	:= 0     //Zera o Valor do Desconto
		M->CK_DESCONT 		:= 0     //Zera o Valor do Desconto - da memoria
		TMP1->CK_VALDESC 	:= 0     //Zera o Valor do Desconto
		//U_fDesOrc(.F.,.T.,.F.)		 //Calcula tudo denovo com o valor zerado
	EndIf
				
Return ret              

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CJDESCON  º Autor ³ Reginaldo G.Ribeiroº Data ³  30/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Faturamento - Orçamento                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CJDESCON(ret)

Local	clA3Comiss	:= ''
Local	nlDesc2		:= 0
Local 	cDescon		:= ""

	If .Not. Empty(M->CJ_CODVEND)
		DbSelectArea("SA3")
		SA3->( DbSetOrder(1) )
		If SA3->( DbSeek(xFilial("SA3")+M->CJ_CODVEND) )
			DbSelectArea("SZA")
			SZA->(DbSetOrder(1))
			If SZA->(DbSeek(xFilial("SZA")+SA3->A3_XCOMDES))
				While SZA->( .Not. Eof() ) .And. SZA->ZA_NUM == SA3->A3_XCOMDES
					If ret >= SZA->ZA_PORCENT
						nlDesc2 := SZA->ZA_PORCENT
					Else
						cDescon := "50%"//cDescon+=cValTochar(SZA->ZA_PORCENT)+"%, "
					EndIf
					SZA->(DbSkip())
				EndDo
			EndIf
		EndIf
	EndIf
	If .Not. Empty(M->CJ_CONDPAG) .AND. SE4->(DbSeek(xFilial("SE4")+M->CJ_CONDPAG))
		If SE4->E4_DESCREP==0 .OR. SE4->E4_DESCGER==0
			If ret <> nlDesc2  //Validar o limite do Vendedor
				Alert("Esse vendedor não pode dar desconto que não seja estes:  "+cDescon+" para o Item: ")
				ret := 0
				If __ReadVar == "CJ_DESC1"
					M->CJ_DESC1 	:= 0     //Zera o Valor do Desconto
				ElseIf __ReadVar == "CJ_DESC2"
					M->CJ_DESC2 	:= 0     //Zera o Valor do Desconto
				ElseIf __ReadVar == "CJ_DESC3"
					M->CJ_DESC3 	:= 0     //Zera o Valor do Desconto
				ElseIf __ReadVar == "CJ_DESC4"
					M->CJ_DESC4 	:= 0     //Zera o Valor do Desconto
				EndIf
				//U_fDesOrc(.F.,.T.,.F.)		 //Calcula tudo denovo com o valor zerado
			EndIf
		EndIf
	Else
		Alert("Condição de pagamento vazia ou inexistente")
	EndIf
	
Return ret         