#include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³ TMKVFIM         ºAutor³ Mauro Sano                 º Data ³ 13/12/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc     ³ Ponto de Entrada disparado apos a inclusao do Pedido de Venda   na     º±±
±±º         ³ Tela de TELEVENDAS do Call Center. Esta rotina grava alguns campos     º±±
±±º         ³ criado pelo usuario no Pedido de Venda.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSintaxe  ³ U_TMKVFIM( ExpC1, ExpC2 )                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametr ³ ExpC1 = Indica o Numero de Atendimento do Televendas / Call Center     º±±
±±º         ³ ExpC2 = Indica o Numero do Pedido de Venda criado pelo TeleVendas      º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/        

User Function TMKVFIM( cNumAtend, cNumPed )

Local _aArea  		:= GetArea()
LOCAL aarea_SC5	:= GETAREA()
LOCAL aarea_SC6	:= GETAREA()
LOCAL aarea_SUA	:= GETAREA()
LOCAL aarea_SUB	:= GETAREA()	
Local aVend			:= {}
Local lAchou 		:= .F.     
Local nX				:= 1	
Local cVar			:= "SC5->C5_VEND" 
Local nPer			:= 1

If Alltrim( cNumPed ) == ""
	Return( Nil )
Endif
     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona a tabelas                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DBSelectArea("SC5")
aarea_SC5	:= GETAREA()

DBSelectArea("SC6")
aarea_SC6	:= GETAREA()

DBSelectArea("SUA")
aarea_SUA	:= GETAREA()

DBSelectArea("SUB")
aarea_SUB	:= GETAREA()	

DbSelectArea("SZ6")
DbSetOrder(1)
If DbSeek(xFilial("SZ6") + SUA->UA_CLIENTE + SUA->UA_LOJA ) // Procuro primeiro o cliente
	lAchou := .T.     
Else                                                       
	If DbSeek(xFilial("SZ6") + SUA->UA_XCODOB ) 					// se nao achei procuro a obra
		lAchou := .T.
	EndIf
EndIf
	
If lAchou	// se achou pega os vendedores
	DbSelectArea("SZ7")
	DbSetOrder(1)
	If DbSeek(xFilial("SZ7") + SZ6->Z6_CODIGO )
		While !SZ7->(Eof()) .AND. SZ6->Z6_CODIGO == SZ7->Z7_CODIGO  
			If SZ7->Z7_STATUS == "1"
				aAdd(aVend, { SZ7->Z7_CODVEND, SZ7->Z7_SITUACA, SZ7->Z7_COMISSA } )
			EndIf
			SZ7->(DbSkip())
		End
	EndIf
EndIf
			
DBSelectArea("SC5")
DBSetOrder(1)

If DBSeek( xFilial("SC5") + cNumPed )
	
	DBSelectArea("SC5")
	RecLock( "SC5", .F. )

	SC5->C5_TIPLIB  	:= SUA->UA_TIPLIB
	SC5->C5_OBSERVP 	:= SUA->UA_OBSERVP
	SC5->C5_PEDCLI		:= SUA->UA_XPEDCLI
	SC5->C5_OBSNFE		:= SUA->UA_XOBSNFE		
	
	For nX := 1 To Len(aVend)    
		If nX < 6
			&(cVar+StrZero(nX, 1)) := aVend[nX, 1]
		Else
			Exit
		EndIf	
	Next nX	

	SC5->(MsUnlock())
	
	cVar := "SC6->C6_COMIS"	
	
	// Caso seja alteracao do pedido, deleto e deixo regravar item
	DbSelectArea("SZ0")  
	If ALTERA
		DbSetOrder(1)
		If DbSeek(xFilial("SZ0") + SC5->C5_NUM )
			While SC5->C5_NUM == SZ0->Z0_PEDIDO .AND. !SZ0->(Eof()) 
				RecLock("SZ0",.F.)
				SZ0->(DbDelete())  
				SZ0->(DbSkip())
			End
		EndIf
	EndIF
	
	DbSelectArea("SUB")
	DbSetOrder(3)
	If SUB->(DbSeek(xFilial("SUB")+cNumPed))	
		While SUB->UB_NUMPV = cNumPed .AND. !SUB->(Eof())
			DbSelectArea("SC6")
			DbSetOrder(1)
			If DbSeek(xFilial("SC6") + SUB->UB_NUMPV + SUB->UB_ITEMPV ) 
				RecLock("SC6",.F.)    
				SC6->C6_XCODANT	:= SUB->UB_XCODANT 
				SC6->C6_ITEMCLI 	:= SUB->UB_ITEMCLI 
				SC6->C6_PEDCLI 	:= SUB->UB_PEDCLI   
				SC6->C6_PRUNIT		:= SC6->C6_PRCVEN    
				SC6->C6_DESCONT	:= 0
				SC6->C6_VALDESC	:= 0  
				
				DbSelectArea("SZ9")
				DbSetOrder(1)
				If DbSeek( xFilial("SZ9") + SC6->C6_PRODUTO )
					aVend[1,1] := SZ9->Z9_COMISSA					
				EndIf                            
				
				If Len(aVend) > 0
					For nX := 1 To Len(aVend)    
						If nX < 6
							If nX == 1
								SC6->C6_XCOMORI := aVend[nX, 3]  
								SC6->C6_COMIS1	:= u_DaiCalCom(aVend[nX])                
								If SC6->C6_COMIS1 >= 0
									nPer := SC6->C6_COMIS1 / SC6->C6_XCOMORI
								EndIf      										
							Else
						   		&(cVar+StrZero(nX, 1)) := aVend[nX, 3] * nPer
						 	EndIf   
						 	
							RecLock("SZ0", .T.)
							REPLACE Z0_FILIAL	WITH xFilial("SZ0")  
							REPLACE Z0_PEDIDO	WITH SC5->C5_NUM
							REPLACE Z0_OBRA		WITH SUA->UA_XCODOB
							REPLACE Z0_CODVEND	WITH aVend[nX, 1]
							REPLACE Z0_EMISSAO	WITH dDatabase
							REPLACE Z0_COMISSA	WITH &(cVar+StrZero(nX, 1))
							REPLACE Z0_PRODUTO	WITH SC6->C6_PRODUTO
							REPLACE Z0_VALCOM	WITH (&(cVar+StrZero(nX, 1))/100) * SC6->C6_VALOR
							SZ0->(MsUnlock()) 
							
						Else
							Exit
						EndIf										
					Next nX	
				EndIf	
								
				SC6->(MsUnlock())
			Endif
			SUB->(DbSkip())
		End
	EndIf
Endif                              

RestArea( aarea_SC5 )
RestArea( aarea_SC6 )
RestArea( aarea_SUA )
RestArea( aarea_SUB )	
RestArea( _aArea )

MsgAlert("Foi gerado o Pedido: " + ALLTRIM( cNumPed )  )

execblock("AC0029",.f.,.f., { /* Nil */, cNumPed } )
            
Return( Nil )              


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DaiCalCom ºAutor  ³Mauro Sano          º Data ³  03/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Faz o calculo percentual da comissao                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                 

User Function DaiCalCom(aVend,cOrigem)
Local nRet := 0	  
Local cDescMax	:= SuperGetMv("MV_DESCMAX")       
Local cDescMed	:= SuperGetMv("MV_DESCMED")
Local cDescMin	:= SuperGetMv("MV_DESCMIN") 
Local aPar		:= {}
Local nX		:= 1  
Local nMin		:= 0
Local nMax		:= 0
Local nDesc		:= 0                     
Local nDesIttem	:= 0    
Local nPerc		:= 0       
Local nDescTela	:= 0

Default cOrigem = "C"                                

If M->UA_DESC1 > 0
	nDescTela += M->UA_DESC2
EndIf

If aCols[n,GdFieldPos("UB_DESC") ] > 0
	nDescTela += aCols[n,GdFieldPos("UB_DESC") ]
EndIf

//nDescTela := M->UA_DESC1 + aCols[n,GdFieldPos("UB_DESC") ] 

If cOrigem == "C"
	If aCols[n,GdFieldPos("UB_XNEG")] <> "1" .AND. nDescTela > 0
		nDesItem := nDescTela
		If M->UA_XTPDESC == "1"  
			aPar := StrToKArr(cDescMin, "|")
		ElseIf M->UA_XTPDESC == "2"        
			aPar := StrToKArr(cDescMed, "|")
		Else
			aPar := StrToKArr(cDescMax, "|")
		EndIf
	EndIf  
Else 

	If SUA->UA_DESC2 > 0
		nDescTela += SUA->UA_DESC2
	EndIf
	
	If SUB->UB_DESC > 0
		nDescTela += SUB->UB_DESC
	EndIf                        
	
	// nDescTela  := SUA->UA_DESC1 + SUB->UB_DESC
	DbSelectArea("SUA")                                             
	DbSetOrder(2)
	
	If DbSeek( xFilial("SUA") + SD2->D2_SERIE + SD2->D2_DOC )   
		DbSelectArea("SUB")
		DbSetOrder(3)
		If DbSeek(xFilial("SUB") + SD2->D2_PEDIDO + SD2->D2_ITEMPV)
		
			If SUB->UB_XNEG <> "1" .AND. nDescTela > 0
				nDesItem := nDescTela
				If SUA->UA_XTPDESC == "1"  
					aPar := StrToKArr(cDescMin, "|")
				ElseIf SUA->UA_XTPDESC == "2"        
					aPar := StrToKArr(cDescMed, "|")
				Else
					aPar := StrToKArr(cDescMax, "|")
				EndIf   
			
			EndIf                             
		EndIf
	
	EndIf
EndIf	
	
If Len(aPar) > 0
	For nX := 1 To Len(aPar)
		nMin := Val(SubStr(aPar[nX],1,5))
		nMax := Val(SubStr(aPar[nX],7,5))
		nDesc:= Val(SubStr(aPar[nX],13,5))    
		If nDesItem > nMax 
			nPerc += nMax * nDesc
			nDesItem -= nMax
		Else                 
			If nDesc == 100
				nDesc := 1
			EndIf
			nPerc += nDesItem * nDesc
		EndIf									
	Next nx
EndIf		

nRet := aVend[3] - nPerc

If nRet < 0
	nRet := 0
EndIf      

Return nRet

*/