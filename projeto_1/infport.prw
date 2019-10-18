

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

User Function INFPORT()

If MsgYesNo("Validando o arquivo \TITULOS\PAGAR.DBF ? ")
	
	Processa( {|| ProcImp()}	,"Aguarde" ,"Procesando...")
	
EndIf

Return Nil



Static Function ProcImp()

/*cArquivo := "\TITULOS\PAGAR.DBF"
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
*/
cArquivo := "\TITULOS\PORTADO.DBF"
DbUseArea( .T., "DBFCDXADS", Alltrim(cArquivo), "MEUTRB", .T. ,.F. )

lArqOK := .T.

If lArqOK
	
	MEUTRB->(dbGoTop())
	ProcRegua(MEUTRB->(RecCount()))
	While !MEUTRB->(Eof())
		
		aValores := {}
		IncProc("Importando Título : " + MEUTRB->E1_NUM)
		
		dbSelectArea("MEUTRB")
		
		lBlq := .F.
		DBSELECTAREA("SE1")
		DBSETORDER(1)
		
		IF SE1->(dbSeek(xFilial("SE1")+'MIG'+MEUTRB->E1_NUM+'  '+MEUTRB->E1_PARCELA)   )
			dbSelectArea("SE1")
			RecLock("SE1",.F.)
			SE1->E1_PORTADO := MEUTRB->E1_PORTADO
			SE1->E1_AGEDEP  := MEUTRB->E1_AGEDEP
			SE1->E1_CONTA   := MEUTRB->E1_CONTA
			SE1->(MsUnLock())
		ENDIF
		
		MEUTRB->(dbSkip())
	EndDo
	
	MsgAlert("Termino da validacao dos CLIENTES!")
	
EndIF

MEUTRB->(dbCloseArea())

Return Nil
