#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"     
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fRetComis � Autor � AP6 IDE            � Data �  14/02/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna um Array com a porcentagem de comiss�o             ���
���          � nDesc = valor do desconto concedido                        ���
���          � cProd = codigo do produto, para verificar se o item tem    ���
���          � comiss�o                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Faturamento                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function fRetComis(nDesc,cProd)

Local cQuery
Local nComPrd1 := 0
Local nComPrd2 := 0
Local nComPrd3 := 0

Default	cProd := ""

	DBSelectArea("SB1")
	SB1->( DBSetOrder(1) )
	
	If SELECT("TMPBUS")>0
		DBselectArea("TMPBUS")
		DBCloseArea()
	EndIf
	
	//SELECT NA TABELA DE CONTROLE DE COMISS�O x DESCONTO
	cQuery := " SELECT  DISTINCT MIN(ZA_PORCENT) AS MINIMO"
	cQuery += " FROM SZA010 SZA"
	cQuery += " WHERE ZA_PORCENT>='"+cValToChar(nDesc)+"'"
	cQuery += " AND SZA.D_E_L_E_T_ = ''"
	
	DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPBUS',.T.,.T.)
	
	TMPBUS->(dbgotop())
	If TMPBUS->(Eof())
		If nDesc > 50
			cDescon := "50"
		EndIf
	Else
		cDescon := cValToChar(TMPBUS->MINIMO)
	EndIf
	
	If SELECT("TMPDES")>0
		DBselectArea("TMPDES")
		DBCloseArea()
	EndIf
	cQuery := " SELECT ZA_PCOMIRP,ZA_PCOMGR, ZA_PCOMGN FROM "+RetSqlName("SZA")+" SZA "
	cQuery += " WHERE SZA.ZA_PORCENT='"+cDescon+"'"
	cQuery += " AND SZA.D_E_L_E_T_ = ''"
	
	DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPDES',.T.,.T.)
	
	TMPDES->( DBgotop() )
	
	If !Empty(cProd)
		IF SB1->(dbSeek(xFilial("SB1")+cProd))
			nComPrd1 := SB1->B1_COMIS
			nComPrd2 := SB1->B1_XCOMIGR
			nComPrd3 := SB1->B1_XCOMIGN
		EndIf
	EndIf
	nComPrd1 += TMPDES->ZA_PCOMIRP
	nComPrd2 += TMPDES->ZA_PCOMGR
	nComPrd3 += TMPDES->ZA_PCOMGN
			
Return{nComPrd1,nComPrd2,nComPrd3}