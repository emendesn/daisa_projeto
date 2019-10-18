#Include "protheus.ch" 
#Include "TopConn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³ PlgNEntreg      ºAutor³ Mauro Sano                 º Data ³ 18/02/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.    ³ Pedidos nao entregues - Plugin                                         º±±  
±±ÈÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PlgNE() 
Local lRet 				:= .F.
Private nLin		 	:= 4300
Private lPrintHeader	:= .T.
Private nHeight 		:= 15
Private lBold 			:= .F.
Private lUnderLine 		:= .F.
Private lPixel 			:= .T.
Private lPrint 			:= .F.
Private ArialN6 		:= TFont():New("Arial"	,,6	,,.F.,,,,,lUnderLine)
Private ArialN6B 		:= TFont():New("Arial"	,,6	,,.T.,,,,,lUnderLine)
Private ArialN8 		:= TFont():New("Arial"	,,8	,,.F.,,,,,lUnderLine)
Private ArialN8B  		:= TFont():New("Arial"	,,8	,,.T.,,,,,lUnderLine)
Private ArialN9B 		:= TFont():New("Arial"	,,9	,,.T.,,,,,lUnderLine)
Private ArialN10 		:= TFont():New("Arial"	,,10	,,.F.,,,,,lUnderLine)
Private ArialN10B 		:= TFont():New("Arial"	,,10	,,.T.,,,,,lUnderLine)
Private ArialN12 		:= TFont():New("Arial"	,,12	,,.F.,,,,,lUnderLine)
Private ArialN12B 		:= TFont():New("Arial"	,,12	,,.T.,,,,,lUnderLine)
Private ArialN14BU 		:= TFont():New("Arial"	,,14	,,.F.,,,,.T.,.T.)
Private ArialN15 		:= TFont():New("Arial"	,,15	,,.F.,,,,,lUnderLine)
Private ArialN15B 		:= TFont():New("Arial"	,,15	,,.T.,,,,,lUnderLine)
Private ArialN14B 		:= TFont():New("Arial"	,,14	,,.T.,,,,,lUnderLine)
Private ArialN18 		:= TFont():New("Arial"	,,18	,,.F.,,,,,lUnderLine)
Private ArialN18B 		:= TFont():New("Arial"	,,18	,,.T.,,,,,lUnderLine)
Private ArialN20 		:= TFont():New("Arial"	,,20	,,.F.,,,,,lUnderLine)
Private ArialN22 		:= TFont():New("Arial"	,,22	,,.F.,,,,,lUnderLine)
Private ArialN24B 		:= TFont():New("Arial"	,,24	,,.T.,,,,,lUnderLine)
Private ArialN28 		:= TFont():New("Arial"	,,28	,,.F.,,,,,lUnderLine)
Private Times14	 		:= TFont():New("Times New Roman",,14 ,,.T.,,,,,.F. )
Private Times20 		:= TFont():New("Times New Roman",,20 ,,.T.,,,,,.F. )
Private Arial08	 		:= TFont():New("Arial" ,,08 ,,.T.,,,,,.F. )
Private Arial12	 		:= TFont():New("Arial" ,,12 ,,.T.,,,,,.F. )
Private oBrush	 		:= TBrush():New(,4) 
Private cPerg	 		:= Padr("PLGNENTREG",10)

Imprime()
SET DEVICE TO SCREEN
MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³Imprime   º Autor ³ Mauro Sano         º Data ³ 18/02/2011  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Imprime()
Local cQuery		:= ""      
Local cQueryAux		:= "" 
Local nX
Local cModo			:= ""     
Local aArea			:= GetArea()
Local lPrim			:= .T. 
Local nPag			:= 0
Local nContador		:= 0  
Local nX			:= 1
Local aProd			:= {}   
Local dData			:= ""  
Local dDataAux		:= ""   
Local nPos			:= 0
Local nData			:= 0
Private aTipoBack	:={}	// Utilizado na SelEmpFil
Private aTipos		:={}	// Utilizado na SelEmpFil
Private oPrn      
Private aDatas		:= {}
AjustaSx1()

If !Pergunte(cPerg,.T.)
	Return (Nil)
EndIf

/*
DbSelectArea("SM0")
SM0->(DbSetOrder(1))

If SM0->(DbSeek("0101")) //Empresa Daisa 01 - Filial 01
	Aadd(aTipos,{.T.,SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_FILIAL, SM0->M0_NOME})
EndIf
aTipoBack := aClone(aTipos)*/
If !u_SelEmpFil()
	Return (Nil)
EndIf
/*
For nX := 1 To Len(aTipos)
	If aTipos[nx,1]      
		DbSelectArea("SX2")
		DbSetOrder(1)
		If DbSeek("SC6"+aTipos[nX,2]+"0")
			cModo := X2_MODO      
		EndIf
	EndIf
Next
*/
      
For nX := 1 To Len(aTipos)      
	If aTipos[nX,1]      
  		DbSelectArea("SX2")
		DbSetOrder(1)
		If DbSeek("SC6"+aTipos[nX,2]+"0")
			cModo 	:= SX2->X2_MODO
			cSC6Emp := SX2->X2_ARQUIVO
		EndIf
		If DbSeek("SF4"+aTipos[nX,2]+"0")
			cSF4Emp := SX2->X2_ARQUIVO
		EndIf
		If DbSeek("SC9"+aTipos[nX,2]+"0")
			cSC9Emp := SX2->X2_ARQUIVO
		EndIf
		If !lPrim
			cQuery += "UNION " + Chr (13)
		EndIf  
		
	//cQuery += "SELECT '"+ aTipos[nX,4] + "' EMPRESA, C6_FILIAL, C6_XCODANT, C6_PRODUTO, C6_ENTREG, C6_NUM, Sum(C6_QTDVEN) VENDA, Sum(C6_QTDENT) ENTREG " + Chr(13) 
		cQuery += "SELECT '"+ aTipos[nX,4] + "' EMPRESA, C6_FILIAL, C6_PRODUTO, C6_LOCAL,C6_XCODANT, C6_ENTREG, C6_NUM, Sum(C6_QTDVEN) VENDA, Sum(C6_QTDENT) ENTREG" 
		If mv_par12 == 2
			cQuery += ", C6_CLI, C6_LOJA "
		EndIf
		If mv_par14 == 2
			cQuery += ",  C9_BLCRED "
		EndIf
		cQuery += Chr(13) 
		cQuery += "FROM " + cSC6Emp + " SC6" + Chr(13)  //aTipos[nX,2 ]
		/*
		cQuery += " JOIN "+RetSqlName("SB1")+ " SB1" 
		cQuery += " ON ( B1_FILIAL = '"+xFilial("SB1")+"' AND C6_PRODUTO = "*/
		If mv_par10 == 1  
			cQuery += " JOIN " + cSF4Emp+ " SF4" + Chr(13)
			cQuery += " ON ( F4_FILIAL = '"+xFilial("SF4")+"' AND F4_CODIGO = C6_TES AND F4_DUPLIC = 'S' AND SF4.D_E_L_E_T_ = '' )"+ Chr(13)
		EndIf		
		
		cQuery += " JOIN " + cSC9Emp + " SC9" + Chr(13)
		cQuery += "  ON ( C9_FILIAL = C6_FILIAL AND C9_PEDIDO = C6_NUM  AND C9_ITEM = C6_ITEM
		cQuery += "  AND C9_EXPFLAG <> '03' "  // Apenas os diferentes de faturados e liberados para faturar
		cQuery += "  AND SC9.D_E_L_E_T_ <> '*'"
		If mv_par14 == 1
			cQuery  += " AND (C9_EXPFLAG IN ('  ','01','02') AND (C9_BLEST = 'XX' OR C9_BLEST = '02') AND C9_BLCRED = '  ')"        	// Apenas os que foram expedidos
		EndIf
		cQuery += ")"+ Chr(13)


		cQuery += "WHERE " + Chr(13)
		
		If AllTrim(cModo) == "E"
			cQuery += "C6_FILIAL = '" + aTipos[nX, 3] + "' AND "+ Chr(13)
		EndIf                                                                
		
		cQuery += "C6_PRODUTO BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' AND " + Chr(13)
		cQuery += "C6_CLI BETWEEN '" + mv_par03 + "' AND '" + mv_par05 + "' AND " + Chr(13)  
		cQuery += "C6_LOJA BETWEEN '" + mv_par04 + "' AND '" + mv_par06 + "' AND " + Chr(13)	
		cQuery += "C6_ENTREG BETWEEN '" + DToS(mv_par07) + "' AND '" + DToS(mv_par08) + "' AND " + Chr(13)	
		cQuery += "C6_QTDVEN <> C6_QTDENT AND SC6.D_E_L_E_T_ = '' "  + Chr(13)     
		
		If mv_par11 == 2
			cQuery += " AND C6_BLQ <> 'R ' " + Chr(13)
		EndIf

		cQuery += "GROUP BY " + Chr(13)
		cQuery += "C6_FILIAL, C6_PRODUTO, C6_LOCAL, C6_XCODANT, C6_ENTREG, C6_NUM "
		If mv_par12 == 2
			cQuery += ", C6_CLI, C6_LOJA	" 
		EndIf
		If mv_par14 == 2
			cQuery += ", C9_BLCRED"
		Endif
		cQuery += Chr(13)
		lPrim := .F.
	
	EndIf
Next nX      

If mv_par12 == 2
	cQuery += "ORDER BY C6_ENTREG, C6_NUM, C6_XCODANT, C6_PRODUTO, C6_LOCAL,  EMPRESA  "
Else                                                                 
	cQuery += "ORDER BY C6_XCODANT "//, C6_ENTREG  "
EndIf


TcQuery cQuery New Alias "TMP" 

DbSelectArea("TMP")                                           
                           
If Select("TMP") < 0
	Alert("Nao existem dados para apresentar!")
	Return() 
EndIf	

If mv_par12 == 1         
	dDataAux:=dData := mv_par07
	For nX := 1 to 9     
		
		If mv_par13 == 1 
			aAdd(aDatas, dData)                     		
			dData += 1  
		Else       
		   	dDataAux := DataValida(dDataAux,.T.)
			aAdd(aDatas, DataValida(dDataAux,.T.)) 
			dDataAux += 1
		EndIf         
		
	Next nX  
EndIf
	

TMP->(DbGoTop())

oPrn:=TMSPrinter():New()
oPrn:Setup()
oPrn:SetLandscape()     
SB2->(DbSetOrder(1))
cPedAux := TMP->C6_NUM
While !TMP->(Eof())  

 	//Buscar Saldo disponivel	
	If SB2->(DbSeek( xFilial("SB2") + TMP->C6_PRODUTO+TMP->C6_LOCAL))
		nlSld 		:= SB2->B2_QATU//SALDOSB2()
		nlSldDisp 	:= SALDOSB2()
		//If nlSld < 0
		//	nlSld	:= 0
		//EndIf
	Else
		nlSld		:= 0
		nlSldDisp   := 0
	Endif

	If (mv_par09 == 1 .AND. nlSldDisp <= 0) .OR. mv_par09 == 2
		If mv_par12 == 1  
			If aScan(aProd,{|x| x[1] == TMP->C6_PRODUTO/*+TMP->C6_LOCAL*/}) == 0 .AND. aScan(aDatas,{|x| x== Stod(TMP->C6_ENTREG)}) > 0                                    
				aAdd(aProd,{TMP->C6_PRODUTO/*+TMP->C6_LOCAL*/,TMP->C6_XCODANT,0,0,0,0,0,0,0,0,0,0,0} )    			
			EndIf                                                       

			nPos	:= aScan(aProd,{|x| x[1] == TMP->C6_PRODUTO/*+TMP->C6_LOCAL*/})
			nData	:= aScan(aDatas,{|x| x== Stod(TMP->C6_ENTREG)})
		
			If nPos > 0 .AND. nData > 0
				/*
				nlSldAux := TMP->VENDA - nlSld
				If nlSldAux < 0 .OR. TMP->VENDA > nlSld
					nlSldAux *= -1
				EndIf*/
				aProd[nPos,nData+2] 	+= TMP->VENDA// +1 pois na posicao 1 esta o codigo do produto
				aProd[nPos,12]			:= nlSld
				aProd[nPos,13]			:= nlSldDisp
			EndIf
		EndIf       
	
		If nLin >= 2200 .OR. nPag == 0
			Cabec(@nPag)
			nLin += 10
		EndIf                  

		If mv_par12 == 2
	
			If cPedAux <> TMP->C6_NUM
				cPedAux := TMP->C6_NUM
				oPrn:Line(nLin,0050,nLin,3200)
				nLin += 10
			EndIf
			
			//oPrn:Say( nLin , 0050, TMP->EMPRESA, ArialN10, 100 ) 
			oPrn:Say( nLin , 0050, SubStr(TMP->C6_ENTREG,7,2) + "/" + SubStr(TMP->C6_ENTREG,5,2) + "/" + SubStr(TMP->C6_ENTREG,1,4) , ArialN10, 100 )
			oPrn:Say( nLin , 0250, TMP->C6_NUM, ArialN10, 100 )
			If mv_par14 == 2
				If !TMP->C9_BLCRED=='  '.And. TMP->C9_BLCRED <> '09'.And. TMP->C9_BLCRED <> '10'.And. TMP->C9_BLCRED <> 'ZZ'
					cCred := "**"
				Else
					cCred := ""
				EndIf
			Else
				cCred := ""
			EndIf
			oPrn:Say( nLin , 0400, TMP->C6_CLI+"-"+TMP->C6_LOJA+" - "+Alltrim(Posicione("SA1",1,xFilial("SA1")+TMP->C6_CLI+TMP->C6_LOJA,"A1_NREDUZ"))+cCred, ArialN10, 100 ) 	
			oPrn:Say( nLin , 1200, TMP->C6_PRODUTO, ArialN10, 100 ) 
			oPrn:Say( nLin , 1600, Posicione("SB1",1,xFilial("SB1")+TMP->C6_PRODUTO/*+TMP->C6_LOCAL*/,"B1_XCODCAT")/*TMP->C6_XCODANT*/, ArialN10, 100 ) 
	
	
			
			oPrn:Say( nLin , 2000, Transform(TMP->VENDA, "@E 999,999,999.99"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 030 )
			//oPrn:Say( nLin , 2500, Transform(TMP->ENTREG, PesqPict("SC6", "C6_QTDVEN")), ArialN10, 030 )
	
			nPos	:= aScan(aProd,{|x| x[1] == TMP->C6_PRODUTO/*+TMP->C6_LOCAL*/})
	
			If nPos == 0
				nlSldAux := TMP->VENDA - nlSld
				If nlSldAux < 0 .OR. TMP->VENDA > nlSld
					nlSldAux *= -1
				EndIf
				aAdd(aProd,{TMP->C6_PRODUTO/*+TMP->C6_LOCAL*/,TMP->C6_XCODANT,nlSld,nlSldAux})
				nPos := Len(aProd)
			Else
				nlSld := aProd[nPos,4]
				aProd[nPos,3] := nlSld
				nlSldAux := TMP->VENDA - nlSld
				If nlSldAux < 0 .OR. TMP->VENDA > nlSld
					nlSldAux *= -1
				EndIf
				aProd[nPos,4] := nlSldAux
			
			EndIf
	
			oPrn:Say( nLin , 2300, Transform(aProd[nPos,3], "@E 999,999,999.99"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
			oPrn:Say( nLin , 2600, Transform(aProd[nPos,4], "@E 999,999,999.99"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 030 )
			oPrn:Say( nLin , 2900, Transform(nlSldDisp, "@E 999,999,999.99"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 030 )
	
	
			nLin += 50
		EndIf
	EndIf	
	TMP->(DbSkip())
End             

If mv_par12 == 1 .AND. Len(aProd) > 0
	For nX := 1 To Len(aProd)  
		If nLin >= 2200 .OR. nPag == 0	
			Cabec(@nPag)
			nLin += 10
		EndIf     
				
		oPrn:Say( nLin , 0050, aProd[nX,1], ArialN10, 100 ) 
		oPrn:Say( nLin , 0400, aProd[nX,2]/*Posicione("SB1", 1,xFilial("SB1") + aProd[nX,1], "B1_XCODCAT")*/, ArialN10, 100 )
		
		If Len(aDatas) <= 10
			oPrn:Say( nLin , 0750, Transform(aProd[nX,3] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
			oPrn:Say( nLin , 0950, Transform(aProd[nX,4] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
			oPrn:Say( nLin , 1150, Transform(aProd[nX,5] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
			oPrn:Say( nLin , 1350, Transform(aProd[nX,6] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
			oPrn:Say( nLin , 1550, Transform(aProd[nX,7] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
			oPrn:Say( nLin , 1750, Transform(aProd[nX,8] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		 	oPrn:Say( nLin , 1950, Transform(aProd[nX,9] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		 	oPrn:Say( nLin , 2150, Transform(aProd[nX,10] , "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		 	oPrn:Say( nLin , 2350, Transform(aProd[nX,11], "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		 	//oPrn:Say( nLin , 2550, Transform(aProd[nX,12], "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		EndIf                
		
		oPrn:Say( nLin , 2500, Transform(aProd[nX,3]+aProd[nX,4]+aProd[nX,5]+aProd[nX,6]+aProd[nX,7]+aProd[nX,8]+aProd[nX,9]+aProd[nX,10]+aProd[nX,11], "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		//oPrn:Say( nLin , 2700, Transform(aProd[nX,3], "@E 999,999,999.99"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		oPrn:Say( nLin , 2700, Transform(aProd[nX,12], "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 ) 	
		oPrn:Say( nLin , 2900, Transform(aProd[nX,13], "@E 999,999,999"/*PesqPict("SC6", "C6_QTDVEN")*/), ArialN10, 100 )
		nLin += 40
		oPrn:Line(nLin,0010,nLin,3200)
		nLin += 10
	Next nX
EndIf	
		

oPrn:EndPage()
oPrn:Preview()

TMP->(DBCloseArea())
Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³Cabec     º Autor ³                    º Data ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Header das colunas do Relatorio.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Cabec( nPag )

If nPag == 0
	oPrn:StartPage()
	nLin := 020 
	nPag ++
Else
	oPrn:EndPage()  
	oPrn:StartPage()
	nLin := 020 
	nPag ++	
EndIf
oPrn:Say( 2240 , 2950, "Pag.: "+Alltrim(Str(nPag)), ArialN10, 100 )
oPrn:Box(0010,0010,0250,3200)
oPrn:SayBitMap(0020, 0050, "logo_daisa.jpg",300,200)
oPrn:Say( 0100 , 1100, Alltrim(SM0->M0_NOME)+" - Pedidos Pendentes", ArialN18B, 100 ) 
oPrn:Say( 0050 , 2750, "Data Emissão: "+DtoC(Date()), ArialN10B, 100 )
oPrn:Say( 0150 , 2750, "Hora Emissão: "+Time(), ArialN10B, 100 )
nLin += 240

If mv_par12 == 1
	
	oPrn:Say( nLin , 0050, "Cod. Protheus", ArialN10B, 100 ) 
	oPrn:Say( nLin , 0400, "Cod. Antigo", ArialN10B, 100 ) 
//	oPrn:Say( nLin , 0750, "Descricao", ArialN10B, 100 )   
	
	If Len(aDatas) <= 9
		oPrn:Say( nLin , 0750, DToC(aDatas[1]) , ArialN10B, 100 )
		oPrn:Say( nLin , 0950, DToC(aDatas[2]) , ArialN10B, 100 )
		oPrn:Say( nLin , 1150, DToC(aDatas[3]) , ArialN10B, 100 )
		oPrn:Say( nLin , 1350, DToC(aDatas[4]) , ArialN10B, 100 )
		oPrn:Say( nLin , 1550, DToC(aDatas[5]) , ArialN10B, 100 )
		oPrn:Say( nLin , 1750, DToC(aDatas[6]) , ArialN10B, 100 )
		oPrn:Say( nLin , 1950, DToC(aDatas[7]) , ArialN10B, 100 )
		oPrn:Say( nLin , 2150, DToC(aDatas[8]) , ArialN10B, 100 )
		oPrn:Say( nLin , 2350, DToC(aDatas[9]) , ArialN10B, 100 )
		//oPrn:Say( nLin , 2550, DToC(aDatas[10]), ArialN10B, 100 )
	EndIf                               

	oPrn:Say( nLin , 2550, "Total", ArialN10B, 100 )
	oPrn:Say( nLin , 2750, "Estoque", ArialN10B, 100 )
	oPrn:Say( nLin , 2950, "Sld. Dis.", ArialN10B, 100 )
	

Else                      
	oPrn:Say( nLin , 0050, "Entrega", ArialN10B, 100 ) 
	oPrn:Say( nLin , 0250, "Pedido", ArialN10B, 100 ) 
	oPrn:Say( nLin , 0400, "Cliente", ArialN10B, 100 )
	oPrn:Say( nLin , 1200, "Cod. Protheus", ArialN10B, 100 )
	oPrn:Say( nLin , 1600, "Cod. Antigo", ArialN10B, 100 )


	//oPrn:Say( nLin , 2250, "Qtd. Vendida", ArialN10B, 030 )
	oPrn:Say( nLin , 2000, "Qtd. Vendida", ArialN10B, 030 )  
	oPrn:Say( nLin , 2350, "Estoque", ArialN10B, 030 )    
	
	oPrn:Say( nLin , 2650,	"Saldo" 	  , ArialN10B, 030 )
	oPrn:Say( nLin , 2900,	"Saldo Disponivel" , ArialN10B, 030 )
	
EndIf

nLin += 40
oPrn:Line(nLin,0010,nLin,3200)

Return( Nil ) 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-¿±±
±±³Fun‡…o    ³ AjustaSX1    ³Autor | Mauro Sano           | Data 18/02/11 |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-´±±
±±³Descri‡…o ³ Ajusta perguntas do SX1                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1()

Local aArea	:= GetArea()
Local aSx1	:= {}

DBSelectArea("SX1")
SX1->(DBSetOrder(1))
cPerg := PadR(cPerg, Len(SX1->X1_GRUPO))
SX1->(DBSeek(cPerg+"01"))  

AADD(	aSx1,{ cPerg,"01","Produto De?"			,"mv_par01"	,"C",15,0,0,"G","mv_par01","","","","","","SB1" } )
AADD(	aSx1,{ cPerg,"02","Produto Ate?"		,"mv_par02"	,"C",15,0,0,"G","mv_par02","","","","","","SB1" } )
AADD(	aSx1,{ cPerg,"03","Cliente De?"			,"mv_par03"	,"C",06,0,0,"G","mv_par03","","","","","","SA1" } )
AADD(	aSx1,{ cPerg,"04","Loja De?"			,"mv_par04"	,"C",02,0,0,"G","mv_par04","","","","","","" } )   
AADD(	aSx1,{ cPerg,"05","Cliente Ate?"		,"mv_par05"	,"C",06,0,0,"G","mv_par05","","","","","","SA1" } )
AADD(	aSx1,{ cPerg,"06","Loja Ate?"			,"mv_par06"	,"C",02,0,0,"G","mv_par06","","","","","","" } )
AADD(	aSx1,{ cPerg,"07","Entrega De?" 	 	,"mv_par07"	,"D",08,0,0,"G","mv_par07","","","","","","" } )                                                                                                          
AADD(	aSx1,{ cPerg,"08","Entrega Ate?" 	 	,"mv_par08"	,"D",08,0,0,"G","mv_par08","","","","","","" } )                                                                                                          
AADD(	aSx1,{ cPerg,"09","Situacao do Pedido" 	,"mv_par09"	,"N",01,0,0,"C","mv_par09","Saldo Indis.","Todos os itens","","","","" } )
AADD(	aSx1,{ cPerg,"10","Duplicata" 			,"mv_par10"	,"N",01,0,0,"C","mv_par10","Gera","Não Gera","","","","" } ) 
AADD(	aSx1,{ cPerg,"11","Res. Eliminados" 	,"mv_par11"	,"N",01,0,0,"C","mv_par11","Considera","Não Considera","","","","" } )         
AADD(	aSx1,{ cPerg,"12","Tipo" 				,"mv_par12"	,"N",01,0,0,"C","mv_par12","Sintético","Analítico","","","","" } )     
AADD(	aSx1,{ cPerg,"13","Fim de Semana"		,"mv_par13"	,"N",01,0,0,"C","mv_par13","Considera","Não Considera","","","","" } )  
AADD(	aSx1,{ cPerg,"14","Considera Credito?"	,"mv_par14"	,"N",01,0,0,"C","mv_par14","Considera","Não Considera","","","","" } )                                                                                                        
                                                                                                         

If SX1->X1_GRUPO != cPerg
	For I := 1 To Len( aSx1 )
		If !SX1->( DBSeek( aSx1[I][1] + aSx1[I][2] ) )
			Reclock( "SX1", .T. )
			SX1->X1_GRUPO		:= aSx1[i][1] //Grupo
			SX1->X1_ORDEM		:= aSx1[i][2] //Ordem do campo
			SX1->X1_PERGUNT		:= aSx1[i][3] //Pergunta
			SX1->X1_PERSPA		:= aSx1[i][3] //Pergunta Espanhol
	   		SX1->X1_PERENG		:= aSx1[i][3] //Pergunta Ingles
			SX1->X1_VARIAVL		:= aSx1[i][4] //Variavel do campo
			SX1->X1_TIPO		:= aSx1[i][5] //Tipo de valor
			SX1->X1_TAMANHO		:= aSx1[i][6] //Tamanho do campo
			SX1->X1_DECIMAL		:= aSx1[i][7] //Formato numerico
			SX1->X1_PRESEL		:= aSx1[i][8] //Pre seleção do combo
			SX1->X1_GSC			:= aSx1[i][9] //Tipo de componente
			SX1->X1_VAR01		:= aSx1[i][10]//Variavel que carrega resposta
			SX1->X1_DEF01		:= aSx1[i][11]//Definições do combo-box
			SX1->X1_DEF02		:= aSx1[i][12]
			SX1->X1_DEF03		:= aSx1[i][13]
			SX1->X1_DEF04		:= aSx1[i][14]
			SX1->X1_VALID		:= aSx1[i][15]
			SX1->X1_F3			:= aSx1[i][16]
			MsUnlock()
		Endif
	Next
Endif

RestArea(aArea)

Return