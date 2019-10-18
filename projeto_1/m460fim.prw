#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M460FIM   ºAutor  ³Mauro Sano          º Data ³  06/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE na emissao da NF que grava na comissao o doc + serie     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function M460FIM()

Local aArea		:= GetArea()
Local cKeySD2	:= SF2->F2_FILIAL + SF2->F2_DOC + SF2->F2_SERIE
Local cDoc		:= SF2->F2_DOC
Local cSerie	:= SF2->F2_SERIE

	DbSelectArea("SD2")
	SD2->( DbSetOrder(3) )
	If SD2->( DbSeek(cKeySD2) )//xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE )
		While SD2->( .Not. Eof() ) .AND. cKeySD2 == SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE
			DbSelectArea("SZ0")
			SZ0->( DbSetOrder(1) )
			If SZ0->( DbSeek(xFilial("SZ0") + SD2->D2_PEDIDO + SD2->D2_COD) )
				While SZ0->( .Not. Eof()) .AND. SD2->D2_PEDIDO + SD2->D2_COD == SZ0->Z0_PEDIDO + AllTrim(SZ0->Z0_PRODUTO)
					RecLock("SZ0", .F.)
					REPLACE Z0_SERIE	WITH SD2->D2_SERIE
					REPLACE Z0_DOC		WITH SD2->D2_DOC
					SZ0->(MsUnlock())
					SZ0->(DbSkip())
				End
			EndIf
			SD2->(DbSkip())
		End
	EndIf
	
	RestArea(aArea)
	
Return