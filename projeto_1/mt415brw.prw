#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT415BRW  ºAutor  ³Henrique Pereira    º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao para mostrar apenas os orcamentos pertinentes a   º±±
±±º          ³seus clientes na tela de orcamento, caso o usuario seja um  º±±
±±º          ³representante.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Todas as empresas.                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MT415BRW()

LOCAL aArea
LOCAL cVendCod

PUBLIC cClieFilt := ""  
PUBLIC cVndFitOr := ""  

	//Pesquisa o codigo do vendedor de acordo com o susário logado no sistema
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
		
		// Se encontrado algum cadastro atrelado ao uaário, é aplicado o filtro
		If .NOT. Empty( cVndFitOr )
			DBSelectArea("SA1")
			SET FILTER TO &cClieFilt.
			
			DBSelectArea("SCJ")
			SET FILTER TO &cVndFitOr.
			
			SCJ->( DBGotop() )
		EndIf
		
	EndIf
				
Return