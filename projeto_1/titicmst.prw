//PONTO DE ENTRADA PARA AJUSTAR O VENCIMENTO DAS PARCELAS

User Function TITICMST()
//Local	cOrigem	:=	PARAMIXB[1]
Local	cTipoImp	:= PARAMIXB[2]

//If AllTrim(cOrigem)='MATA954'	//Apuracao de ISS	
//  SE2->E2_NUM			:=	SE2->(Soma1(E2_NUM,Len(E2_NUM)))	
//  SE2->E2_VENCTO  	:= DataValida(dDataBase+30,.T.)	
//  SE2->E2_VENCREA 	:= DataValida(dDataBase+30,.T.)
//EndIf    

//EXEMPLO 2 (cTipoImp)
If AllTrim(cTipoImp)='3' // ICMS ST	  
  SE2->E2_NUM 			:= SE2->(Soma1(E2_NUM,Len(E2_NUM)))	  
  SE2->E2_VENCTO 		:= DataValida(SE2->E2_EMISSAO+1,.T.)	  
  SE2->E2_VENCREA 	:= DataValida(SE2->E2_EMISSAO+1,.T.)
EndIf

Return {SE2->E2_NUM,SE2->E2_VENCTO}                      