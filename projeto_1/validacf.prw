

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

User Function ValidaCF()

If MsgYesNo("Validando o arquivo \TITULOS\PAGAR.DBF ? ")
	
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
		
		IF !SA2->(dbSeek(xFilial("SA2")+SUBSTR(MEUTRB->E2_XCGC,2,15)))
			dbSelectArea("MEUTRB")
			RecLock("MEUTRB",.F.)
			MEUTRB->E2_LOJA := 'N'
			MEUTRB->(MsUnLock())
			MEUTRB->(dbSkip())
			LOOP
        ELSE
			dbSelectArea("MEUTRB")
			RecLock("MEUTRB",.F.)
			MEUTRB->E2_FORNECE := SA2->A2_COD
			MEUTRB->E2_LOJA    := SA2->A2_LOJA
			MEUTRB->(MsUnLock())
		ENDIF
		
		MEUTRB->(dbSkip())
	EndDo
	
	MsgAlert("Termino da validacao dos fornecedores!")
	
EndIF

MEUTRB->(dbCloseArea())

cArquivo := "\TITULOS\RECEBER.DBF"
DbUseArea( .T., "DBFCDXADS", Alltrim(cArquivo), "MEUTRB", .T. ,.F. )

lArqOK := .T.

If lArqOK
	
	SE1->(dbGoTop())
	ProcRegua(SE1->(RecCount()))
	While !SE1->(Eof())
		
		aValores := {}
		IncProc("Importando Título : " + SE1->E1_NUM)
		
		dbSelectArea("SE1")
		
		lBlq := .F.
		DBSELECTAREA("SA1")
		DBSETORDER(3)
		
		IF !SA1->(dbSeek(xFilial("SA1")+SUBSTR(SE1->E1_HIST,2,15)))
			dbSelectArea("SE1")
			RecLock("SE1",.F.)
//			MEUTRB->E1_LOJA := 'N'
			MEUTRB->(MsUnLock())
			MEUTRB->(dbSkip())
			LOOP
        ELSE
            IF SE1->E1_PREFIXO = 'MIG'
			dbSelectArea("SE1")
			RecLock("SE1",.F.)
			SE1->E1_CLIENTE := SA1->A1_COD
			SE1->E1_LOJA    := SA1->A1_LOJA
			SE1->(MsUnLock())
			ENDIF
		ENDIF
		
		SE1->(dbSkip())
	EndDo
	
	MsgAlert("Termino da validacao dos CLIENTES!")
	
EndIF

SE1->(dbCloseArea())

Return Nil
