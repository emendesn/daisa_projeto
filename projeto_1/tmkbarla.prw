/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TMKCBPRO  �Autor  �Microsiga           � Data �  11/02/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

USER FUNCTION TMKBARLA( aBtnLat, aTitles )

//AADD( aBtnLat,{ "OBJETIVO",	{|| (U_PlanTMK() )} , "Planilha Financeira"})
AADD( aBtnLat,{ "OBJETIVO",	{|| (U_AC0029() )} , "Imprime Daisa"})

RETURN( aBtnLat )