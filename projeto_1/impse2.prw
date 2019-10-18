

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPSE2    ºAutor  ³Microsiga           º Data ³  12/29/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ImpSE2()

If MsgYesNo("Confirma importado do arquivo \TITULOS\PAGAR.DBF ? ")
	
	Processa( {|| ProcImp()}	,"Aguarde" ,"Procesando...")
	
EndIf

Return Nil



Static Function ProcImp()


cArquivo := "\TITULOS\PAGAR.DBF"
DbUseArea( .T., "DBFCDXADS", Alltrim(cArquivo), "MEUTRB", .T. ,.F. )

lArqOK := .T.

If lArqOK
	
	MEUTRB->(dbGoTop())
	ProcRegua(MEUTRB->(RecCount()))
	While !MEUTRB->(Eof())
		
		aValores := {}
		IncProc("Importando Título : " + MEUTRB->E2_NUM)
		
		dbSelectArea("MEUTRB")
		
		lBlq := .F.
		DBSELECTAREA("SA2")
		DBSETORDER(3)
		
		IF SA2->(dbSeek(xFilial("SA2")+SUBSTR(MEUTRB->E2_XCGC,2,15)))
			If SA2->A2_MSBLQL == "1"
				lBlq := .T.
				RecLock("SA2",.F.)
				SA2->A2_MSBLQL := "2"
				SA2->(MsUnLock())
			EndIf
		ELSE
			dbSelectArea("MEUTRB")
			RecLock("MEUTRB",.F.)
			MEUTRB->E2_LOJA := 'N'
			MEUTRB->(MsUnLock())
			MEUTRB->(dbSkip())
			LOOP
		ENDIF
		cFORNEC := SA2->A2_COD
		cLoja   := SA2->A2_LOJA
		
		cNUM := MEUTRB->E2_NUM
		
		cMinhaFil := xFilial("SE2")
		
		Aadd(aValores,{"E2_FILIAL"		,cMinhaFil						,Nil})
		Aadd(aValores,{"E2_PREFIXO"		,'NF' 	,Nil})
		Aadd(aValores,{"E2_NUM"			,AllTrim(cNUM) 		,Nil})
		Aadd(aValores,{"E2_PARCELA"		,AllTrim(MEUTRB->E2_PARCELA) 	,Nil})
		
		Aadd(aValores,{"E2_TIPO"		,AllTrim(MEUTRB->E2_TIPO) 		,Nil})
		
		Aadd(aValores,{"E2_FORNECE"		,AllTrim(cFORNEC) 				,Nil})
		Aadd(aValores,{"E2_LOJA"		,AllTrim(CLOJA) 				,Nil})
		
		Aadd(aValores,{"E2_FATFOR"		,AllTrim(cFORNEC) 				,Nil})
		Aadd(aValores,{"E2_FATLOJ"		,AllTrim(CLOJA) 				,Nil})
		
		Aadd(aValores,{"E2_NOMFOR"		,AllTrim(MEUTRB->E2_NOMFOR) 	,Nil})
		Aadd(aValores,{"E2_EMISSAO"		,MEUTRB->E2_EMISSAO 		,Nil})
		
		Aadd(aValores,{"E2_VENCTO"		,MEUTRB->E2_VENCTO 		,Nil})
		Aadd(aValores,{"E2_VENCREA"		,MEUTRB->E2_VENCREA 		,Nil})
		
		Aadd(aValores,{"E2_VALOR"		,MEUTRB->E2_SALDO 				,Nil})
		Aadd(aValores,{"E2_VLCRUZ"		,MEUTRB->E2_VLCRUZ 				,Nil})
		Aadd(aValores,{"E2_HIST"		,AllTrim(MEUTRB->E2_HIST) 		,Nil})
		
		Aadd(aValores,{"E2_LA"		,'S' 						,Nil})
		Aadd(aValores,{"E2_SALDO"	 		,MEUTRB->E2_SALDO 			,Nil})
		Aadd(aValores,{"E2_MOEDA"		,MEUTRB->E2_MOEDA  				,Nil})
		Aadd(aValores,{"E2_SITUACA"			,MEUTRB->E2_SITUACA 		,Nil})
		Aadd(aValores,{"E2_ORIGEM"		,MEUTRB->E2_ORIGEM 				,Nil})
		
		LMSERROAUTO := .F.
		
		MSExecAuto({|a,b,c| FINA050(a,b,c)}, aValores, Nil, 3)
		
/*		If lMsErroAuto
			MostraErro()
			If !MsgYesNo("Deseja Continuar Importando os Saldos")
				MEUTRB->(DbGoBottom())
				Exit
			EndIf
			
		Else
			
			If lBlq
				RecLock("SA2",.F.)
				SA2->A2_MSBLQL := "1"
				SA2->(MsUnLock())
			EndIf
			
		EndIf
		
  */		
		MEUTRB->(dbSkip())
	EndDo
	
	MsgAlert("Termino da importacao do contas a pagar!")
	
EndIF

MEUTRB->(dbCloseArea())

Return Nil
