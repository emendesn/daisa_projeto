#INCLUDE "rwmake.ch"
/*
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบExecBlock ณ LP597  บAutor  ณWALDIR ARRUDA         12/01/12              บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  CONTABILIZAวรO DE COMPENSAวรO DE TอTULO A RECEBER CREDITO  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ  SALTON                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/
User Function LP597CRE()
********************
Local aAREA_ATU	:= GetArea()
Local aAREA_SE5	:= SE5->( GetArea() )
Local cConta	:= ""
                                      
        
//cChave := SUBSTR(SE5->E5_DOCUMEN,1,18)+DTOS(dDataBase)+SE5->E5_FORNECE+SE5->E5_LOJA

cChave := SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA)
        
 If(ALLTRIM(SE5->E5_TIPO)=="NF")  .OR.  (ALLTRIM(SE5->E5_TIPO)=="PA")
 
	DbSelectArea("SE5")
	DbSetOrder(2)
	If DbSeek( xFilial("SE5") +"BA"+cChave)
	   
	   	SED->(dbSetOrder(1))
	    SED->(dbSeek(xFilial("SED")+SE5->E5_NATUREZ))

		cConta	:= SED->ED_CREDIT
		
	
	ElseIf DbSeek( xFilial("SE5") +"CP"+cChave)

	   	SED->(dbSetOrder(1))
	    SED->(dbSeek(xFilial("SED")+SE5->E5_NATUREZ))

		cConta	:= SED->ED_CREDIT

	ElseIf DbSeek( xFilial("SE5") +"PA"+cChave)

	   	SED->(dbSetOrder(1))
	    SED->(dbSeek(xFilial("SED")+SE5->E5_NATUREZ))

		cConta	:= SED->ED_CREDIT


	EndIf
	
	
	
EndIf

RestArea(aAREA_SE5)
RestArea(aAREA_ATU)
Return(cConta)