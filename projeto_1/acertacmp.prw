#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ACERTACMP �Autor  �Vitor Daniel        � Data �  05/12/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �FUNCAO PARA ACERTAR CAMPOS DO PROTHEUS           			  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function AcertaCMP()

If MsgYesNo("Confirma acerto das casas decimais?")
	//CAMPO
	ProcCMP()
EndIf

Return Nil  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PROCCMP   �Autor  �Vitor Daniel        � Data �  05/12/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �FUNCAO QUE ALTERAR OS CAMPOS                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ProcCMP()

cArquivo := "\CASAS\CAMPOS.DBF"
dbUseArea(.T.,"DBFCDXADS",cArquivo,"TMP",.T.,.F.)

dbSelectArea("TMP")
dbGotop()

While !EOF()  
	//PEGA O CAMPO DO DBF
	cCampo := TMP->QUANT
	cCampo := AllTrim(cCampo)  
	
	//ALTERA O CAMPO NO SX3
	dbSelectArea("SX3")
	dbSetOrder(2)
	If dbSeek(cCampo)
		RecLock("SX3",.F.)      
		SX3->X3_TAMANHO := 30
		SX3->X3_DECIMAL := 0
		SX3->X3_PICTURE := "@!"                                
		MsUnLock()
	EndIf
    //ALTERA O CAMPO NA TABELA TOP_FIELD     
	cQuery := "UPDATE TOP_FIELD "
	cQuery += "SET FIELD_DEC = 0, FIELD_PREC = 30 "
	cQuery += "WHERE FIELD_NAME = '"+cCampo+"' "
	TCSqlExec(cQuery)     

	dbSelectArea("TMP")
	dbSkip()
EndDo       

MsgAlert("Altera��o concluida com sucesso!")
           
Return nil