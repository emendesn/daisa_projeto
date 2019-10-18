#include "Protheus.ch"
#include "TopConn.ch"
#include "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PRT0117   � Autor � Rafael P. Goncalves� Data �  06/10/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio de Itens de Pedido de Vendas Pendentes.          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function PRT0117()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := ""
Local cPict         := "Logo-Daisa.jpg"
Local titulo       	:= "Relatorio de Itens Pendentes"
Local nLin         	:= 80

Local Cabec1       	:= "Pedido  Item  Cliente                                     Produto                                         Qtde    Prazo Entrega"
Local Cabec2       	:= ""
Local imprime      	:= .T.
Local aOrd 			:= {}

Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "M"
Private nomeprog    := "RELPED" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cPerg       := "PEDPEN"
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "RELPED" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "SC9"

AjustSX1(cPerg)
If !Pergunte(cPerg,.T.)
	Return (Nil)
EndIf


//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  06/10/11   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local clQry := ""

clQry := "SELECT DISTINCT C9_PEDIDO, C9_ITEM, C9_QTDLIB, A1_NREDUZ, B1_XCODCAT, C6_DESCRI, C6_ENTREG FROM "+RetSqlName("SC9")+" SC9"
clQry += " JOIN "+RetSqlName("SA1")+" SA1"
clQry += "	ON ( A1_FILIAL = '"+xFilial("SA1")+"' AND A1_COD = C9_CLIENTE AND A1_LOJA = C9_LOJA )"
clQry += " JOIN "+RetSqlName("SB1")+" SB1"
clQry += "	ON ( B1_FILIAL = '"+xFilial("SB1")+"' AND B1_COD = C9_PRODUTO AND B1_LOCPAD = C9_LOCAL )"
clQry += " JOIN "+RetSqlName("SC6")+" SC6"
clQry += "	ON ( C6_FILIAL = C9_FILIAL AND C6_NUM = C9_PEDIDO AND C6_ITEM = C9_ITEM )"
clQry += " WHERE SC9.D_E_L_E_T_ <> '*'"
clQry += " AND SA1.D_E_L_E_T_ <> '*'"
clQry += " AND SB1.D_E_L_E_T_ <> '*'"
clQry += " AND SC6.D_E_L_E_T_ <> '*'"
clQry += " AND SC9.C9_FILIAL BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'"
clQry += " AND SC9.C9_PEDIDO BETWEEN '"+mv_par03+"' AND '"+mv_par04+"'"
clQry += " AND SC9.C9_EXPFLAG <> '03' AND C9_BLEST = 'XX' AND C9_BLCRED <> '09'" // Itens que nao foram liberados para faturar

If Select("XPED") > 0
	XPED->(DbCloseArea())
EndIf

TcQuery clQry New Alias "XPED"

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������

SetRegua(RecCount())


XPED->(dbGoTop())
While XPED->(!EOF())

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ   
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

	If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	@ nLin, 00 PSAY XPED->C9_PEDIDO
	@ nLin, 08 PSAY XPED->C9_ITEM
	@ nLin, 14 PSAY Alltrim(XPED->A1_NREDUZ)
	@ nLin, 58 PSAY Alltrim(XPED->B1_XCODCAT)+" - "+Alltrim(XPED->C6_DESCRI)
	@ nLin, 100 PSAY Transform(XPED->C9_QTDLIB,"@E 999,999.99")	
	@ nLin, 115 PSAY SubStr(XPED->C6_ENTREG,7,2)+"/"+SubStr(XPED->C6_ENTREG,5,2)+"/"+SubStr(XPED->C6_ENTREG,1,4)
	
	nLin++	
	XPED->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo

//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return (Nil)
Static Function AjustSx1(cPerg)

	PutSx1(cPerg,"01","Da Filial?            	","Da Filial?               ","Da Filial?               ","MV_CH1" ,"C",2,0,0,"G","               ","SM0","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"02","Ate a Filial?            ","Ate a Filial?            ","Ate a Filial?            ","MV_CH2" ,"C",2,0,0,"G","               ","SM0","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"03","Do Pedido?               ","Do Pedido?               ","Do Pedido?               ","MV_CH3" ,"C",6,0,0,"G","               ","SC5","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"04","Ate o Pedido?            ","Ate o Pedido?            ","Ate o Pedido?            ","MV_CH4" ,"C",6,0,0,"G","               ","SC5","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

	
Return (Nil)