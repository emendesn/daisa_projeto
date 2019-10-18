#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT415BRW  �Autor  �Henrique Pereira    � Data �  04/09/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Validacao para mostrar apenas os orcamentos pertinentes a   ���
���          �seus clientes na tela de orcamento, caso o usuario seja um  ���
���          �representante.                                              ���
�������������������������������������������������������������������������͹��
���Uso       � Todas as empresas.                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MT415BRW()

LOCAL aArea
LOCAL cVendCod

PUBLIC cClieFilt := ""  
PUBLIC cVndFitOr := ""  

	//Pesquisa o codigo do vendedor de acordo com o sus�rio logado no sistema
	DBSelectArea("SA3")
	SA3->( DBSetOrder(7) )
	IF SA3->( DBSeek( xFilial("SA3") + __CUSERID ) )
		cVendCod := SA3->A3_COD
		
		IF Empty( SA3->A3_GEREN )
			// Separa todos os representantes atrelados a este gerente
			aArea := SA3->( GetArea() )
			SA3->( DBGotop() )
			WHILE .NOT. SA3->( Eof() )
				IF SA3->A3_GEREN == cVendCod
					cClieFilt += IIF( Empty( cClieFilt ), '(SA1->A1_VEND=="' + SA3->A3_COD + '"', '.OR.SA1->A1_VEND=="' + SA3->A3_COD + '"' )
					cVndFitOr += IIF( Empty( cVndFitOr ), 'SCJ->CJ_CODVEND=="' + SA3->A3_COD + '"', '.OR.SCJ->CJ_CODVEND=="' + SA3->A3_COD + '"' )
				ENDIF
				SA3->( DBSkip() )
			EndDo
			cClieFilt += IIF( .NOT. Empty( cClieFilt ), ').AND.SA1->A1_MSBLQL<>"1"', "" )
			RestArea( aArea )
		ELSE
			cClieFilt := 'SA1->A1_VEND=="' + SA3->A3_COD + '".AND.SA1->A1_MSBLQL<>"1"'
			cVndFitOr := 'SCJ->CJ_CODVEND=="' + SA3->A3_COD + '"'
		ENDIF
		
		// Se encontrado algum cadastro atrelado ao ua�rio, � aplicado o filtro
		If .NOT. Empty( cVndFitOr )
			DBSelectArea("SA1")
			SET FILTER TO &cClieFilt.
			
			DBSelectArea("SCJ")
			SET FILTER TO &cVndFitOr.
			
			SCJ->( DBGotop() )
		EndIf
		
	EndIf
				
Return