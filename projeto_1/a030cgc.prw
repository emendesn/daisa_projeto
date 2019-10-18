/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ A030CGC   ºAutor  ³Vitor Daniel        º Data ³  25/10/10      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica a existencia de mais de um cliente com o mesmo CNPJ.  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A030CGC

Local aAreaOld := SA1->(GetArea())
Local cCNPJ    := M->A1_CGC
Local cA1_COD  := M->A1_COD
Local cA1_LOJA := M->A1_LOJA
Local cCGCBAse     
Local nLoja         
Local nPos
     
// Forço atualização para Juridica se o numero de digitos for maior que 11
	If Len(Alltrim(cCNPJ)) > 11
		M->A1_PESSOA = "J"
	Endif
	
	If M->A1_PESSOA == "J"
		cA1_LOJA := SUBSTR(cCNPJ,9,2)
		nLoja    := VAL(cA1_LOJA)
		// Faço controle se o numero da loja for maior que 100, ajusta pelo Microsiga
		If nLoja >= 100
			cA1_LOJA := "99"
			For nPos := 1 To (nLoja - 100)
				cA1_LOJA := Soma1(cA1_LOJA)
			Next
		Else
			cA1_LOJA := SubStr(cCNPJ,11,2)
		Endif
		
		cCGCBase := SubStr(cCNPJ,1,8)
		DbSelectArea("SA1")
		SA1->( DbSetOrder(3) )
		If SA1->( DbSeek(xFilial("SA1")+cCGCBase) )
			cA1_COD := SA1->A1_COD
			// Efetua loop para evitar duplicidade de Loja, mesmo que não corresponda a loja do CNPJ
			While .T.
				DbSelectArea("SA1")
				SA1->( DbSetOrder(1) )
				If SA1->( DbSeek(xFilial("SA1")+cA1_COD+cA1_LOJA) )
					cA1_LOJA := Soma1(cA1_LOJA)
				Else
					Exit
				Endif
			Enddo
		Endif
		M->A1_COD  := cA1_COD
		M->A1_LOJA := cA1_LOJA
		RestArea(aAreaOld)
	Endif
	
Return A030CGC(M->A1_PESSOA, M->A1_CGC)//M->A1_PESSOA, M->A1_CGC,M->A1_COD,M->A1_LOJA,