#INCLUDE 'PROTHEUS.CH'
					
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FILTROSB1 �Autor  �Fernando Alves      � Data �  10/05/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Filtro |Produto| na tela de Movimentos Intrnos.            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � ESTOQUE \ CUSTOS - DAISA                      	           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FILTROSB1()
       
Local _cFiltro	:= ""
Local _cUsers  := SuperGetMv("MV_USRFIL")     

Do Case

Case Alltrim(cUserName) $ _cUsers
	_cFiltro:= "SB1->B1_TIPO == 'PI'" 
Case Alltrim(cUserName) == 'PA1' .OR. Alltrim(cUserName) == 'PA2' 
	_cFiltro:= "SB1->B1_TIPO == 'PI' .Or. SB1->B1_TIPO == 'PA'  " 	
OtherWise
	_cFiltro:= "SB1->B1_FILIAL <> 'XX' " 	                      
EndCase

Return(&_cFiltro)