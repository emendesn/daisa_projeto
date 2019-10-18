/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT416FIM  ºAutor  ³Reginaldo G.Ribeiro º Data ³  25/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza os campos do pedido de venda com informacoes do   º±±
±±º          ³ Orcamento                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ponto de Entrada - Aprovacao de Venda (Orcamento)          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Function U_MT416FIM()
Local cQuery:= ""
Local ASC6    := GETAREA()
Local CNUMPV  := SC5->C5_NUM
Local CNUMORC := SCJ->CJ_NUM

dbSelectArea("SA3")
SA3->(dbSetOrder(1))

dbSelectArea("SC6")
SC6->(dbSetOrder(1))

dbSelectArea("SE4")
SE4->(dbSetOrder(1))

	//ATUALIZA OS CAMPOS DO ORCAMENTO PARA O PEDIDO DE VENDA
	dbSelectArea("SCJ")
	dbSetOrder(1)
	
	If dbSeek(xfilial("SCJ")+CNUMORC,.T.) .and. xfilial("SCJ") == "01"
        //CABECALHO DO ORCAMENTO PARA O PEDIDO
		RecLock("SC5",.F.)
					
		
		//Vendedor
		SC5->C5_VEND1		:= SCJ->CJ_CODVEND
		If SA3->(dbSeek(xFilial("SA3")+SCJ->CJ_CODVEND))
			SC5->C5_VEND2:= SA3->A3_GEREN
			SC5->C5_VEND3:= SA3->A3_SUPER
		EndIf
        SC5->C5_OBSNFE	:= SCJ->CJ_OBSNFE
        SC5->C5_OBSERVP	:= SCJ->CJ_OBSFAB
	  //  DbSelectArea("TMP001")   
	  //  DbCloseArea("TMP001")
	    cQRY:= " SELECT  DISTINCT MIN(ZA_PORCENT) AS MINIMO"
	    cQRY+= " FROM SZA010 SZA"
	    cQRY+= " WHERE ZA_PORCENT>='"+cValToChar(SCJ->CJ_DESC1)+"'"
	    cQRY+= " AND SZA.D_E_L_E_T_<>'*'"
   	    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQRY),'TMP001',.T.,.T.)	
	    TMP001->(dbgotop())
	    If TMP001->(Eof())
	    	If SCJ->CJ_DESC1 > 50
	    		cDescon:="50"
	    	EndIf  
	    Else
	    	cDescon:=cValToChar(SCJ->CJ_DESC1) 	
	    EndIf
	    DbSelectArea("TMPDES")   
		DbCloseArea("TMPDES")
	    cQuery:= " SELECT ZA_PCOMIRP,ZA_PCOMGR, ZA_PCOMGN FROM "+RetSqlName("SZA")+" SZA "
		cQuery+= " WHERE SZA.ZA_PORCENT='"+cDescon+"'"
	    cQuery+= " AND SZA.D_E_L_E_T_<>'*'"
	    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPDES',.T.,.T.)	
	    TMPDES->(dbgotop())
		
		SC5->C5_COMIS1	:= TMPDES->ZA_PCOMIRP
		SC5->C5_COMIS2	:= TMPDES->ZA_PCOMGR
		SC5->C5_COMIS3	:= TMPDES->ZA_PCOMGN	    
	
		MsUnlock() 
		DbSelectArea("TMPDES")   
		DbCloseArea("TMPDES")
		DbSelectArea("TMP001")   
		DbCloseArea("TMP001")
	EndIf
//EndIf

dbSelectArea("SC6")
dbSetOrder(1)
dbSeek(xfilial("SC6")+CNUMPV,.T.)
/*
do While !Eof() .and. SC6->C6_NUM == CNUMPV .and. xfilial("SC6") == "01"
	// ATUALIZA CAMPOS DO ITEM NO PEDIDO DE VENDA
	IF SCK->(dbSeek(xFilial("SCK")+SC6->C6_NUMORC))
		RecLock("SC6",.F.)
		
		MsUnlock()
		dbSelectArea("SC6")
		SC6->(dbSkip())
	EndIf
Enddo
*/
	
RESTAREA(ASC6)
                                
Return