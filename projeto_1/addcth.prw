#include "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �U_AddCTH  �Autor  �Stanko              � Data �  29/01/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Adiciona registros na tabela CTH.                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AddCTH()
If MsgYesNo("Confirma carga da tabela de classe de valor (CTH)?")
	Processa( {|| AtuClasse()}	,"Aguarde" ,"Atualizando classe de valor...")
EndIf	
	
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuClasse �Autor  �Microsiga           � Data �  10/30/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Procedure AtuClasse()

Local cQuery
Local cChave

	/*cQuery := "SELECT A1_FILIAL FILIAL, A1_CGC CGC , A1_NOME NOME, A1_MSBLQL MSBLQL FROM "+RetSQLName("SA1")+" "
	cQuery += "WHERE D_E_L_E_T_ = '' "
	cQuery += "AND A1_MSBLQL <> '1' "
	cQuery += "AND A1_CGC NOT IN "
	cQuery += "(SELECT SUBSTRING(CTH_CLVL,1,14) FROM "+RetSQLName("CTH")+" "
	cQuery += "WHERE D_E_L_E_T_ = ' ' AND A1_CGC <> '' ) "
	
	cQuery += "UNION ALL "
	*/
	cQuery := "SELECT A2_FILIAL FILIAL, A2_CGC CGC, A2_NOME NOME, A2_MSBLQL MSBLQL FROM "+RetSQLName("SA2")+" "
	cQuery += "WHERE D_E_L_E_T_ = '' "
	cQuery += "AND A2_MSBLQL <> '1' "
	cQuery += "AND A2_CGC NOT IN "
	cQuery += "(SELECT SUBSTRING(CTH_CLVL,1,14) FROM "+RetSQLName("CTH")+" "
	cQuery += "WHERE D_E_L_E_T_ = ' ' )  AND A2_CGC <> ''  "
	
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DBUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), "TMP", .F., .T. ) },"Aguarde...") //"Selecionando Registros..."
	
	ProcRegua(RecCount())
	
	While .Not. EOF()
		
		//IncProc()
		
		cChave := AllTrim(TMP->CGC)
		If Empty(cChave)
			cChave := "88888888888888"
		EndIf
		
		If TMP->MSBLQL <> '1'
			DBSelectArea("CTH")
			CTH->( DBSetOrder(1) )
			If ! CTH->( DBSeek(xFilial() + cChave) )
				RecLock("CTH",.T.)
				CTH->CTH_FILIAL := xFilial()
				CTH->CTH_CLVL   := AllTrim(cChave)
				CTH->CTH_DESC01 := Substr(TMP->NOME,1,30)
				CTH->CTH_CLASSE := "2"
				CTH->CTH_BLOQ   := "2"
				MsUnLock()
			EndIf
		EndIf
		
		DBSelectArea("TMP")
		TMP->( DBSkip() )
		
	EndDo
	
	DBSelectArea("TMP")
	TMP->( DBCloseArea() )
	
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M030Inc   �Autor  �Microsiga           � Data �  10/30/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �P.E. apos a gravacao do cliente                             ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M030Inc()

	cArea := GetArea()
	
	If INCLUI
		Processa( {|| AtuClasse()}	,"Aguarde" ,"Atualizando classe de valor...")
	EndIf
	
	RestArea(cArea)
	
Return .T. //Nil      


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M020Inc   �Autor  �Microsiga           � Data �  10/30/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �P.E. apos a gravacao do fornecedor                          ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M020Inc()

	cArea := GetArea()
	
	If INCLUI
		Processa( {|| AtuClasse()}	,"Aguarde" ,"Atualizando classe de valor...")
	EndIf
	
	RestArea(cArea)
	
Return .T.