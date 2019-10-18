#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MC090BRW  ºAutor  ³Edilson Nascimento  º Data ³  02/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se o usuario logado e um representante e filtra    º±±
±±º          ³as NF(s) na rotina CONSULTA NF DE SAIDA.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Todas as empresas.                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MC090BRW()

LOCAL aArea
LOCAL cVendCod
LOCAL cVendFilt := ""  

	//Pesquisa o codigo do vendedor de acordo com o susário logado no sistema
	DBSelectArea("SA3")
	SA3->( DBSetOrder(7) )
	IF SA3->( DBSeek( xFilial("SA3") + __CUSERID) )
		cVendCod := SA3->A3_COD
		
		IF Empty( SA3->A3_GEREN )
			// Separa todos os representantes atrelados a este gerente
			aArea := SA3->( GetArea() )
			SA3->( DBGotop() )
			WHILE .NOT. SA3->( Eof() )
				IF SA3->A3_GEREN == cVendCod
					cVendFilt += IIF( Empty( cVendFilt ), 'SF2->F2_VEND1=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND2=="' + SA3->A3_COD + '"' +'.OR.SF2->F2_VEND3=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND4=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND5=="' + SA3->A3_COD + '"', ;
					                                       '.OR.SF2->F2_VEND1=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND2=="' + SA3->A3_COD + '"' +'.OR.SF2->F2_VEND3=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND4=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND5=="' + SA3->A3_COD + '"' )
				ENDIF
				SA3->( DBSkip() )
			EndDo
			RestArea( aArea )
		ELSE
			cVendFilt := 'SF2->F2_VEND1=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND2=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND3=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND4=="' + SA3->A3_COD + '"' + '.OR.SF2->F2_VEND5=="' + SA3->A3_COD + '"'
		ENDIF
		
	EndIf
				
Return( cVendFilt )