#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT410BRW  ºAutor  ³Henrique Pereira    º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao para mostrar apenas os pedidos pertinentes a seus º±±
±±º          ³clientes na tela de pedidos de venda, caso o usuario seja   º±±
±±º          ³um representante.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Todas as empresas.                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MT410BRW()

LOCAL aArea
LOCAL cVendCod

PUBLIC cClieFilt := ""  
PUBLIC cVendFilt := ""  

	//Pesquisa o codigo do vendedor de acordo com o susário logado no sistema
	DBSelectArea("SA3")
	SA3->( DBSetOrder(7) )
	IF SA3->( DBSeek( xFilial("SA3")+__CUSERID) )
		cVendCod := SA3->A3_COD
		
		IF Empty( SA3->A3_GEREN )
			// Separa todos os representantes atrelados a este gerente
			aArea := SA3->( GetArea() )
			SA3->( DBGotop() )
			WHILE .NOT. SA3->( Eof() )
				IF SA3->A3_GEREN == cVendCod
					cClieFilt += IIF( Empty( cClieFilt ), '(SA1->A1_VEND=="' + SA3->A3_COD + '"', '.OR.SA1->A1_VEND=="' + SA3->A3_COD + '"' )
					cVendFilt += IIF( Empty( cVendFilt ), 'SC5->C5_VEND1=="' + SA3->A3_COD + '"' + '.OR.SC5->C5_VEND2=="' + SA3->A3_COD + '"' +'.OR.SC5->C5_VEND3=="' + SA3->A3_COD + '"' +'.OR.SC5->C5_VEND4=="' + SA3->A3_COD + '"', ;
					                                       '.OR.SC5->C5_VEND1=="' + SA3->A3_COD + '"' + '.OR.SC5->C5_VEND2=="' + SA3->A3_COD + '"' +'.OR.SC5->C5_VEND3=="' + SA3->A3_COD + '"' +'.OR.SC5->C5_VEND4=="' + SA3->A3_COD + '"' )
				ENDIF
				SA3->( DBSkip() )
			EndDo
			cClieFilt += IIF( .NOT. Empty( cClieFilt ), ').AND.SA1->A1_MSBLQL<>"1"', "" )
			RestArea( aArea )
		ELSE
			cClieFilt := 'SA1->A1_VEND=="' + SA3->A3_COD + '".AND.SA1->A1_MSBLQL<>"1"'
			cVendFilt := 'SC5->C5_VEND1=="' + SA3->A3_COD + '".OR.SC5->C5_VEND2=="' + SA3->A3_COD + '".OR.SC5->C5_VEND3 == "' + SA3->A3_COD + '".OR.SC5->C5_VEND4=="' + SA3->A3_COD + '"'
		ENDIF
		
		// Se encontrado algum cadastro atrelado ao uaário, é aplicado o filtro
		If .NOT. Empty( cVendFilt )
			DBSelectArea("SA1")
			SET FILTER TO &cClieFilt.
			
			DBSelectArea("SC5")
			SET FILTER TO &cVendFilt.
			
			SC5->( DBGotop() )
		EndIf
		
	EndIf
				
Return