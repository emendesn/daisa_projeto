#INCLUDE "rwmake.ch"
/*
臼浜様様様様用様様様様様曜様様様用様様様様様様様様様様僕様様用様様様様様様融臼
臼�ExecBlock � LP597  �Autor  �WALDIR ARRUDA         12/01/12              艮�
臼麺様様様様謡様様様様様擁様様様溶様様様様様様様様様様瞥様様溶様様様様様様郵臼
臼�Desc.     �  CONTABILIZA巴O DE COMPENSA巴O DE T�TULO A RECEBER CREDITO  艮�
臼麺様様様様謡様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様郵臼
臼�Uso       �  SALTON                                                     艮�
臼藩様様様様溶様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕臼
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