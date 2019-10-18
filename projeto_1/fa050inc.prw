#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FA050INC ºAutor  ³ ADVISE             º Data ³  30/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de Entrada no fim da Inclusao Manual do Contas a     º±±
±±º          ³ Pagar.                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FA050INC()
Local lRetorno := .T.                                         

//ALTERADO VITOR DANIEL TIRANDO O TIPO DE TAXA DA CONDICAO TX/
If INCLUI .And. Empty(M->E2_CCD) .And. !AllTrim(M->E2_TIPO) $ "FOL/FIS/IR/INS/ISS/RD " //.And. !Substr(M->E2_NATUREZ,1,2) $ "36/37/38/39"   
	lRetorno := .F.
	Alert("O Campo Centro de Custo é Obrigatório")
EndIf
	
If INCLUI .And. Empty(M->E2_CCD) // .And. Substr(M->E2_NATUREZ,1,2) $ "33/34/35/36/37"
	lRetorno := .F.
	Alert("Natureza obrigatoria para Centro de Custo")
EndIf
  
/*If INCLUI .And. !Empty(M->E2_CCD) .And. Substr(M->E2_NATUREZ,1,2) $ "36/37/38/39"
	lRetorno := .F.
	Alert("Natureza nao permite Centro de Custo")
EndIf
*/

Return lRetorno