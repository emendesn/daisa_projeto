#include "Protheus.ch"
#include "TopConn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M410STTS	º Autor ³ Rafael P. Goncalvesº Data ³  26/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Ponto de entrada no momento da alteracao do pedido de 	  º±±
±±º          ³vendas, deleta a composicao de volumes, caso haja e 		  º±±
±±º          ³caso o pedido e liberado automaticamente fica bloqueado	  º±±
±±º          ³aguardando expedicao.								 		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function M410STTS()

	Local aArea := GetArea()
	
	//Mauro                           admin	admn	
	DBSelectArea("SC6")
	SC6->( DBSetOrder(1) )
	If SC6->( DBSeek(xFilial("SC6") + SC5->C5_NUM ) )
		While .Not. SC6->( EOF() ) .And. SC5->C5_NUM == SC6->C6_NUM 
			RecLock("SC6", .F.)
			SC6->C6_PRUNIT := SC6->C6_PRCVEN  
			SC6->(MsUnlock())
		    SC6->(DBSkip())
		 Enddo
	EndIf

	RestArea(aArea)
	
	/*
	DBSelectArea("SZD")
	SZD->(DBGoTop())
	SZD->(DBSetOrder(1))	
	If SZD->(DBSeek(SC5->C5_FILIAL+SC5->C5_NUM))
		While .Not. SZD->( Eof() ) .And. SZD->ZD_FILIAL == SC5->C5_FILIAL .And. SZD->ZD_PEDIDO == SC5->C5_NUM
			If RecLock("SZD",.F.)
				SZD->(DBDelete())
				SZD->(MsUnLock())
			EndIf
			SZD->(DBSkip())
		EndDo			
	EndIf
	*/
	SC6->(DBGoTop())
	SC9->(DBGoTop())
	SC9->(DBSetOrder(1))
	SC6->(DBSetOrder(1))
	SF4->(DBSetOrder(1))
	If SC9->(DBSeek( SC5->C5_FILIAL + SC5->C5_NUM ) )
		While .Not. SC9->( EOF() ) .And. SC9->C9_FILIAL == SC5->C5_FILIAL .And. SC9->C9_PEDIDO == SC5->C5_NUM
			If Empty( SC9->C9_BLEST ) .And. Empty( SC9->C9_BLCRED ) .And. SC5->C5_TIPO == "N"
				If SC6->( DBSeek( SC5->C5_FILIAL + SC5->C5_NUM + SC9->C9_ITEM ) )
					If SF4->(DBSeek(xFilial("SF4")+SC6->C6_TES))
						//Se a TES atualiza estoque
						If SF4->F4_ESTOQUE == "S"
							If RecLock("SC9",.F.)
								SC9->C9_BLEST := "XX"
								SC9->(MsUnlock())
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
			SC9->(DBSkip())
		EndDo
	EndIf
	//U_DeleteVol(SC5->C5_FILIAL+SC5->C5_NUM)
Return