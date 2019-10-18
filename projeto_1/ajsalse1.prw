#include "Protheus.ch"
#include "TopConn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPSE1    ºAutor  ³Microsiga           º Data ³  12/29/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ajsalse1()

If MsgYesNo("Confirma importado do arquivo \TITULOS\RECEBER.DBF ? ")
	
	Processa( {|| ProcImp()}	,"Aguarde" ,"Procesando...")
	
EndIf

Return Nil

Static Function ProcImp()


cArquivo := "\TITULOS\RECEBER.DBF"
DbUseArea( .T., "DBFCDXADS", Alltrim(cArquivo), "MEUTRB", .T. ,.F. )

lArqOK := .T.


MEUTRB->(dbGoTop())
ProcRegua(MEUTRB->(RecCount()))

While !MEUTRB->(Eof())
	
	CNUM:=MEUTRB->E1_NUM
	
	
	aValores := {}
	IncProc("Importando Título : " + CNUM)
	
	cChave := AllTrim(MEUTRB->E1_FILIAL)+PadR(AllTrim(MEUTRB->E1_PREFIXO),3," ")+PadR(AllTrim(CNUM),9," ")+AllTrim(MEUTRB->E1_PARCELA)
	
	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek(cChave)
		dbSelectArea("SE1")
		RecLock("SE1",.F.)
		E1_SALDO:=MEUTRB->E1_SALDO
		E1_VALOR:=MEUTRB->E1_SALDO
		E1_VLCRUZ:=MEUTRB->E1_SALDO
	EndIf
	MEUTRB->(dbSkip())
ENDDO
MsgAlert("Termino da importacao do contas a receber!")


MEUTRB->(dbCloseArea())

Return Nil

