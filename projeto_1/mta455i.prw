#include "TopConn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTA455I	� Autor � Rafael P. Goncalves� Data �  26/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao �Ponto de entrada ao liberar credito estoque. Flag de XX para���
���          �nao liberar para faturamento e ficar como Aguardando 		  ���
���          �Separacao.   												  ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MTA455I()

Local cQuery

  	cQuery := "SELECT SC9.R_E_C_N_O_ as SC9REC FROM "+RetSqlName("SC9")+" SC9"
 	cQuery += " JOIN "+RetSqlName("SC5")+" SC5"
  	cQuery += " ON ( C5_FILIAL = C9_FILIAL AND C5_NUM = C9_PEDIDO AND C5_TIPO = 'N')"
    cQuery += " WHERE SC9.D_E_L_E_T_ = ''"
    cQuery += " AND SC5.D_E_L_E_T_ = ''"
    cQuery += " AND C9_FILIAL = '"+SC9->C9_FILIAL+"'"
    cQuery += " AND C9_PEDIDO = '"+SC9->C9_PEDIDO+"'"
    cQuery += " AND C9_ITEM = '"+SC9->C9_ITEM+"'"    
    cQuery += " AND C9_BLEST = '  '"
    cQuery += " AND C9_BLCRED = '  '"
    
    If select("RECSC9") > 0
    	RECSC9->(DbCloseArea())
    EndIf
    
    TcQuery cQuery New Alias "RECSC9"
    
    If RECSC9->(!EoF())
    	SC6->(DbSetOrder(1))
		SF4->(DbSetOrder(1))
		SC9->(DbGoTo(RECSC9->SC9REC))
		If SC9->(Recno()) == RECSC9->SC9REC
			If SC6->(DbSeek(SC9->C9_FILIAL+SC9->C9_PEDIDO+SC9->C9_ITEM))
				If SF4->(DbSeek(xFilial("SF4")+SC6->C6_TES))
					//Se a TES atualiza estoque
					If SF4->F4_ESTOQUE == "S"
						If RecLock("SC9",.F.)  

							If FUNNAME()== "MATA455"
								SC9->C9_EXPFLAG := '03'  
								SC9->C9_BLINF := " "
							Else	
								SC9->C9_BLEST := "XX"
							EndIf	
							SC9->(MsUnlock())
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	//U_DeleteVol(SC9->C9_FILIAL+SC9->C9_PEDIDO)
Return (Nil)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M455FIL   � Autor � Rafael P. Goncalves� Data �  26/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao �Executado antes da montagem da INDREGUA, sendo que o retorno���
���          �devera ser uma condicao que sera utilizado na montagem da   ���
���          �Indregua.   												  ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function M455FIL()
	cRet := "SC9->C9_BLINF = '1'"
Return cRet