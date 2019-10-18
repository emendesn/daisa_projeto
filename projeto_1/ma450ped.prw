#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA450PED  � Autor �Edilson Nascimento  � Data �  25/06/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de Entrada para flag do SC9 para aparecer na expedicao��
���          � para a rotina de liberacao automatica.                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MA450PED()

Local cQuery

  	cQuery := "SELECT SC9.C9_PEDIDO PEDIDO, SC9.C9_ITEM ITEM"
 	cQuery += "  FROM " + RetSqlName("SC9") + " SC9"
    cQuery += " WHERE SC9.D_E_L_E_T_ = '' AND"
    cQuery += "       SC9.C9_FILIAL = '" + xFilial("SC9") + "' AND"
    cQuery += "       SC9.C9_PEDIDO = '" + SC5->C5_NUM + "' AND"
    cQuery += "       SC9.C9_BLEST = '  ' AND"
    cQuery += "       SC9.C9_BLCRED = '  '"

	If Select("TMP_MA450PED") > 0
		TMP_MA450PED->(DbCloseArea())
	EndIf
    
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_MA450PED',.T.,.T.) },"Selecionando Registros...") //"Selecionando Registros..."
	
	If TMP_MA450PED->( .Not. EoF())
		MsAguarde({|| Processa() },"Atualizando registros...") //"Selecionando Registros..."
	EndIf
	
	TMP_MA450PED->( DBCloseArea() )
		
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Processa  � Autor � Edilson Nascimento � Data �  25/06/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Atualiza os campos da tabela SC9 com a flag de XX para      ���
���          �nao liberar para faturamento e ficar como Aguardando 		  ���
���          �Separacao.   												  ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Procedure Processa()

	While TMP_MA450PED->( .Not. EoF() )
		SC6->(DbSetOrder(1))
		If SC6->(DbSeek( xFilial("SC6") + TMP_MA450PED->PEDIDO + TMP_MA450PED->ITEM ) )
			SF4->(DbSetOrder(1))
			If SF4->(DbSeek(xFilial("SF4")+SC6->C6_TES))
				//Se a TES atualiza estoque
				If SF4->F4_ESTOQUE == "S"
					SC9->( DBSetOrder(1) )
					If SC9->(DbSeek(xFilial("SC9")+TMP_MA450PED->PEDIDO+TMP_MA450PED->ITEM))
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
		TMP_MA450PED->( DBSkip() )
	EndDo
	
Return
