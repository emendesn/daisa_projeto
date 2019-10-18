/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT440GR   º Autor ³Reginaldo G. Ribeiroº Data ³  02/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de Entrada para flag do SC9 para aparecer na expedição±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MT440GR
Local nOpca    := ParamIXB[1]
//Local clKeySC9 := SC5->C5_FILIAL+SC5->C5_NUM //SC9->C9_FILIAL+SC9->C9_PEDIDO Alterado P/ Reginaldo
	
	If nOpca != 3
		
		SC9->(DbSetOrder(1))
		SC6->(DbSetOrder(1))
		SF4->(DbSetOrder(1))
		
		If SC9->( DBSeek( xFilial("SC5") + SC5->C5_NUM  ) )
			While SC9->( .Not. EoF()) .And. SC9->C9_FILIAL == xFilial("SC9") .And. SC9->C9_PEDIDO == SC5->C5_NUM
				If Empty( SC9->C9_BLEST ) .And. Empty( SC9->C9_BLCRED ) .And. SC5->C5_TIPO == "N"
					If SC6->(DbSeek( xFilial("SC6") + SC5->C5_NUM + SC9->C9_ITEM ) )
						If SF4->(DbSeek(xFilial("SF4")+SC6->C6_TES))
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
				SC9->(DbSkip())
			EndDo
		EndIf
	EndIf
	
Return .T.