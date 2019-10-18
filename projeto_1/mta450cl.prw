#include "TopConn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA450CL  º Autor ³ Edilson Nascimento º Data ³  12/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Ponto de entrada ao liberar credito cliente. Flag de XX paraº±±
±±º          ³nao liberar para faturamento e ficar como Aguardando 		  º±±
±±º          ³Separacao.   												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTA450CL()

Local cQuery

	cQuery := "SELECT SC9.C9_PEDIDO AS PEDIDO, SC9.C9_ITEM AS ITEM "
	cQuery += " FROM "+RetSqlName("SC5")+" SC5"
	cQuery += " INNER JOIN "+RetSqlName("SC9")+" SC9"
	cQuery += " ON SC5.C5_FILIAL = SC9.C9_FILIAL AND SC5.C5_NUM = SC9.C9_PEDIDO"
	cQuery += " WHERE SC5.D_E_L_E_T_ = '' AND "
	cQuery += "       SC9.D_E_L_E_T_ = '' AND "
	cQuery += "       SC5.C5_FILIAL = '" + SC5->C5_FILIAL + "' AND "
	cQuery += "       SC5.C5_CLIENT = '" + SC5->C5_CLIENT + "' AND "
	cQuery += "       SC5.C5_LOJACLI = '" + SC5->C5_LOJACLI + "' AND "
	cQuery += "       SC5.C5_NUM = '" + SC5->C5_NUM + "' AND"
	cQuery += "       SC9.C9_BLEST = '  ' AND"
    cQuery += "       SC9.C9_BLCRED = '  '"
	
	If Select("TMP_MTA450CL") > 0
		TMP_MTA450CL->(DbCloseArea())
	EndIf
	
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_MTA450CL',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
	
	If TMP_MTA450CL->( .Not. EoF())
		MsAguarde({|| Processa() },"Atualizando registros...") //"Selecionando Registros..."
	EndIf
	
	TMP_MTA450CL->( DBCloseArea() )
				
Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Processa  º Autor ³ Edilson Nascimento º Data ³  12/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Atualiza os campos da tabela SC9 com a flag de XX para      º±±
±±º          ³nao liberar para faturamento e ficar como Aguardando 		  º±±
±±º          ³Separacao.   												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Procedure Processa()

	While TMP_MTA450CL->( .Not. EoF() )
		SC6->(DbSetOrder(1))
		If SC6->(DbSeek(xFilial("SC6")+TMP_MTA450CL->PEDIDO+TMP_MTA450CL->ITEM))
			SF4->(DbSetOrder(1))
			If SF4->(DbSeek(xFilial("SF4")+SC6->C6_TES))
				//Se a TES atualiza estoque
				If SF4->F4_ESTOQUE == "S"
					SC9->( DBSetOrder(1) )
					If SC9->(DbSeek(xFilial("SC9")+TMP_MTA450CL->PEDIDO+TMP_MTA450CL->ITEM))
						If RecLock("SC9",.F.)
							
							If FUNNAME()== "MATA450A"
								SC9->C9_BLEST := "XX"
							Else
								SC9->C9_EXPFLAG := '03'
								SC9->C9_BLINF   := " "
                            EndIf
                            
							SC9->(MsUnlock())
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		TMP_MTA450CL->( DBSkip() )
	EndDo
	
Return
