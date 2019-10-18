#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO2     º Autor ³ AP6 IDE            º Data ³  12/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function fTrocaProd
Local cQuery	:= ""
Local cQuerySC6	:= ""
Local cQuerySC7	:= ""
Local lSUB		:= .F.
Local lSC9		:= .F.
Local lSC6		:= .F.
Local lSC7		:= .F.
Local aSC7		:= {}
Local aSC9		:= {}
Local aSC6		:= {}
Local aSUB		:= {}
Local aNTROC	:= {}

	dbSelectArea("SC6")
	dbSetOrder(1)
	
	dbSelectArea("SC7")
	dbSetOrder(4)
	
	dbSelectArea("SC9")
	dbSetOrder(1)

	If !MsgYesno("Deseja efetuar os ajustes dos codigos do produto", "Cod.Produto")
		MsgInfo("Processamento cancelado...", "Cod.Produto")	
		Return
	EndIf
	
	If SELECT("TRB1")>0
		dbSelectArea("TRB1")
		dbCloseArea()
	EndIf
	cQuery:= " SELECT B1_COD, B1_XCODREF, B1_DESC "
	cQuery+= " FROM "+RetSqlname("SB1")+" SB1 "
	cQuery+= " WHERE B1_XCODREF<>' ' AND SB1.D_E_L_E_T_<>'*' "
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)

	MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
	
	While TRB1->(!Eof())       
		lSUB:=.F.
		lSC9:=.F.
		lSC6:=.F.
		lSC7:=.F.
		//--------------------------------------//
		// AJUSTA O PRODUTO DO PEDIDO DE COMPRA //
		//--------------------------------------//
		If SELECT("TRBSC7")>0
			dbSelectArea("TRBSC7")
			dbCloseArea()
		EndIf
		cQuerySC7:= " SELECT C7_FILIAL,C7_PRODUTO,C7_NUM,C7_ITEM,C7_SEQUEN "	
		cQuerySC7+= " FROM "+RetSqlName("SC7")+" SC7"
		cQuerySC7+= " WHERE  (SC7.C7_QUJE=0 And SC7.C7_QTDACLA=0 OR SC7.C7_QUJE<>0 And SC7.C7_QUJE<C7_QUANT)"        
		cQuerySC7+= " AND SC7.C7_PRODUTO='"+TRB1->B1_XCODREF+"' AND SC7.D_E_L_E_T_<>'*'"
		cQuerySC7:= ChangeQuery(cQuerySC7)
		MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySC7),'TRBSC7',.T.,.T.)},"Aguarde... Selecionando Pedidos de Compra") //"Selecionando Registros..."		
		If TRBSC7->(!EOF())    
			lSC7:=.T.
		EndIf
		While TRBSC7->(!EOF())    
			If SC7->(dbSeek(TRBSC7->(C7_FILIAL+C7_PRODUTO+C7_NUM+C7_ITEM+C7_SEQUEN)))
				RecLock("SC7",.F.)
					SC7->C7_PRODUTO:=TRB1->B1_COD				
				MsUnLock()
				AADD(aSC7,{SC7->C7_FILIAL,SC7->C7_NUM,SC7->C7_PRODUTO,SC7->C7_QUANT})
			Else
				lSC7:=.T.
			EndIf
		 	TRBSC7->(dbSkip())
		End
		
		//--------------------------------------//
		// AJUSTA O PRODUTO DO PEDIDO DE VENDA  //
		//--------------------------------------//
		If SELECT("TRBSC6")>0
			dbSelectArea("TRBSC6")
			dbCloseArea()
		EndIf
		cQuerySC6:= " SELECT C6_FILIAL,C6_NUM,C6_ITEM,C6_PRODUTO "	
		cQuerySC6+= " FROM "+RetSqlName("SC6")+" SC6,  "+RetSqlName("SC5")+" SC5"
		cQuerySC6+= " WHERE SC6.C6_FILIAL=SC5.C5_FILIAL AND SC6.C6_NUM=SC5.C5_NUM AND SC6.C6_PRODUTO='"+TRB1->B1_XCODREF+"'"
		cQuerySC6+= " AND SC6.D_E_L_E_T_<>'*' AND SC5.C5_NOTA=''"
		cQuerySC6:= ChangeQuery(cQuerySC6)
		MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySC6),'TRBSC6',.T.,.T.)},"Aguarde... Selecionando Pedidos de Vendas") //"Selecionando Registros..."		
		SUB->(dbSetOrder(3))   
		If TRBSC6->(!EOF())    
			lSC6:= .T.
		EndIf
		While TRBSC6->(!EOF())    
			If SC6->(dbSeek(TRBSC6->(C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO)))
				RecLock("SC6",.F.)
					SC6->C6_PRODUTO:=TRB1->B1_COD				
				MsUnLock()
				aadd(aSC6,{SC6->C6_FILIAL,SC6->C6_NUM,SC6->C6_PRODUTO,C6_QTDVEN})
			Else
				lSC6:= .T.
			EndIf
			
			If SUB->(dbSeek(xfilial("SUB")+TRBSC6->(C6_NUM+C6_ITEM))) 
				RecLock("SUB",.F.)
				 	SUB->UB_PRODUTO:=TRB1->B1_COD				
				MsUnLock()                  
				aadd(aSUB,{SUB->UB_FILIAL,SUB->UB_NUM,SUB->UB_PRODUTO,SUB->UB_QUANT})
			Else
				lSUB:= .T.
			EndIf
		 	If SC9->(dbSeek(xFilial("SC9")+TRBSC6->(C6_NUM+C6_ITEM)))
		 		RecLock("SC9",.F.)
					SC9->C9_PRODUTO:=TRB1->B1_COD				
				MsUnLock()
				aadd(aSC9,{SC9->C9_FILIAL,SC9->C9_PEDIDO,SC9->C9_PRODUTO,SC9->C9_QTDLIB})
		 	Else
				lSC9:= .T.
			EndIf
		 	TRBSC6->(dbSkip())
		End				

		//---------------------------------------------//
		// AJUSTA O PRODUTO DO ATENDIMENTO CALL CENTER // 
		//---------------------------------------------//
		If SELECT("TRBSUB")>0
			dbSelectArea("TRBSUB")
			dbCloseArea()
		EndIf
		cQuerySUB:= " SELECT UB_FILIAL,UB_NUM,UB_ITEM,UB_PRODUTO"
		cQuerySUB+= " FROM "+RetSqlName("SUB")+" SUB, "+RetSqlName("SUA")+" SUA"
		cQuerySUB+= " WHERE SUB.UB_FILIAL=SUA.UA_FILIAL AND SUB.UB_NUM=SUA.UA_NUM AND SUB.UB_PRODUTO='"+TRB1->B1_XCODREF+"'"
		cQuerySUB+= " AND SUA.UA_OPER <> '3' AND SUB.D_E_L_E_T_<>'*'"
		cQuerySUB:= ChangeQuery(cQuerySUB)
		MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySUB),'TRBSUB',.T.,.T.)},"Aguarde... Selecionando Atendimento Call Center") //"Selecionando Registros..."		
		SUB->(dbSetOrder(1))  
		If TRBSUB->(!EOF())    
			lSUB:= .T.
		EndIf
		While TRBSUB->(!EOF())    
			If SUB->(dbSeek(TRBSUB->(UB_FILIAL+UB_NUM+UB_ITEM+UB_PRODUTO)))
				RecLock("SUB",.F.)
					SUB->UB_PRODUTO:=TRB1->B1_COD				
				MsUnLock()
				aadd(aSUB,{SUB->UB_FILIAL,SUB->UB_NUM,SUB->UB_PRODUTO,SUB->UB_QUANT})
			Else
				lSUB:= .T.
			EndIf
			
		 	TRBSUB->(dbSkip())
		End				
		If !lSUB .And. !lSC9 .And. !lSC6 .And. !lSC7
			aadd(aNTROC,{TRB1->B1_COD, TRB1->B1_XCODREF, TRB1->B1_DESC})
		EndIf
		TRB1->(dbSkip())
	End
	U_fGerLog(aSC7,aSC9,aSC6,aSUB,aNTROC)
	MsgInfo("processamento executado com sucesso", "Cod.Produto")
Return 