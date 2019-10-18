#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA456I	º Autor ³ Rafael P. Goncalvesº Data ³  26/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Ponto de entrada ao liberar credito estoque. Flag de XX paraº±±
±±º          ³nao liberar para faturamento e ficar como Aguardando 		  º±±
±±º          ³Separacao.   												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTA456I()

Local cQuery

  	cQuery := "SELECT SC9.R_E_C_N_O_ as SC9REC "
  	cQuery += "  FROM "
  	cQuery += RetSqlName("SC9") + " SC9"  	
  	cQuery += "  JOIN "
  	cQuery += RetSqlName("SC5") + " SC5"
  	cQuery += " ON "
  	cQuery += "    ( SC5.C5_FILIAL = SC9.C9_FILIAL AND "
  	cQuery += "      SC5.C5_NUM = SC9.C9_PEDIDO AND "
  	cQuery += "      SC5.C5_TIPO = 'N')"  	  	
    cQuery += " WHERE SC9.D_E_L_E_T_ = '' AND "
    cQuery += "       SC5.D_E_L_E_T_ = '' AND "
    cQuery += "       SC9.C9_FILIAL = '" + SC9->C9_FILIAL + "' AND "
    cQuery += "       SC9.C9_PEDIDO = '" + SC9->C9_PEDIDO + "' AND "
    cQuery += "       SC9.C9_ITEM = '" + SC9->C9_ITEM + "' AND "
    cQuery += "       SC9.C9_BLEST = '  ' AND "
    cQuery += "       SC9.C9_BLCRED = '  '"
    
    If Select("RECSC9") > 0
    	RECSC9->(DBCloseArea())
    EndIf
    
    // TcQuery cQuery New Alias "RECSC9"
   	MsAguarde({|| DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'RECSC9',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."			
    
    If .Not. RECSC9->( Eof() )
   		SC6->(DBSetOrder(1))
		SF4->(DBSetOrder(1))
		SC9->(DBGoTo(RECSC9->SC9REC))
		If SC9->(Recno()) == RECSC9->SC9REC
			If SC6->(DBSeek( SC9->C9_FILIAL + SC9->C9_PEDIDO + SC9->C9_ITEM ) )
				If SF4->(DBSeek( xFilial("SF4") + SC6->C6_TES ) )
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
	EndIf
	//U_DeleteVol(SC9->C9_FILIAL+SC9->C9_PEDIDO)
	
	RECSC9->( DBCloseArea() )

Return (Nil)