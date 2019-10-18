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

User Function ImpSE1()

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
	
	CNUM:=STRZERO(val(MEUTRB->E1_NUM),7,0)
	
	
	aValores := {}
	IncProc("Importando Título : " + CNUM)
	
	cChave := PadR(AllTrim(MEUTRB->E1_FILIAL),6," ")+PadR(AllTrim(MEUTRB->E1_PREFIXO),3," ")+PadR(AllTrim(CNUM),9," ")+AllTrim(MEUTRB->E1_PARCELA)
	
	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek(cChave)
		dbSelectArea("SE1")
		RecLock("SE1",.F.)
		E1_SALDO:=VAL(MEUTRB->E1_SALDO)
		E1_VALOR:=VAL(MEUTRB->E1_SALDO)
		E1_VLCRUZ:=VAL(MEUTRB->E1_SALDO)
	EndIf
	MEUTRB->(dbSkip())
ENDDO
MsgAlert("Termino da importacao do contas a receber!")


MEUTRB->(dbCloseArea())

Return Nil


/*			lBlq := .F.
DBSELECTAREA("SA1")
DBSETORDER(3)

IF SA1->(dbSeek(xFilial("SA1")+SUBSTR(MEUTRB->E1_HIST,12,15)))
lBlq := .T.
RecLock("SA1",.F.)
SA1->A1_MSBLQL := "2"
SA1->(MsUnLock())
EndIf

cCliente := SA1->A1_COD
cLoja    := SA1->A1_LOJA

dbSelectArea("MEUTRB")

//			cMeuVend := AllTrim(MEUTRB->E1_VEND1)
//			SA3->(dbSetOrder(1))
//			If !SA3->(dbSeek(xFilial("SA3")+AllTrim(MEUTRB->E1_VEND1)))
cMeuVend := "000001"
//			EndIf

cMinhaFil := xFilial("SE1")

dbSelectArea("SE1")
RecLock("SE1",.T.)
E1_PREFIXO:=AllTrim('NF')
E1_NUM:=AllTrim(CNUM)
E1_PARCELA:=AllTrim(MEUTRB->E1_PARCELA)
E1_TIPO:=AllTrim(MEUTRB->E1_TIPO)
E1_NATUREZ:=AllTrim(MEUTRB->E1_NATUREZ)
E1_CLIENTE:=AllTrim(cCliente)
E1_LOJA:=AllTrim(CLOJA)
E1_NOMCLI:=AllTrim(MEUTRB->E1_NOMCLI)
E1_EMIS1:=MEUTRB->E1_EMISSAO
E1_MOEDA:=1
E1_EMISSAO:=MEUTRB->E1_EMISSAO
E1_VENCTO:=MEUTRB->E1_VENCTO
E1_VENCREA:=MEUTRB->E1_VENCREA
E1_VENCORI:=MEUTRB->E1_VENCORI

E1_VALOR:=MEUTRB->E1_SALDO
E1_VLCRUZ:=MEUTRB->E1_SALDO

E1_HIST:="MIGRACAO DE DADOS  "+AllTrim(MEUTRB->E1_HIST)
E1_VEND1:=cMeuVend

SE1->(MsUnLock())

EndIf
*/



