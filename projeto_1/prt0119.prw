#include "Protheus.ch"
#include "TopConn.ch"
#include "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PRT0119   � Autor � Rafael P. Goncalves� Data �  07/10/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio de Produtos em Carteira.				          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function PRT0119()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := ""
Local cPict         := "Logo-Daisa.jpg"
Local titulo       	:= "Relatorio de Produtos em carteira"
Local nLin         	:= 80

Local Cabec1       	:= "Produto                                        Local     Qtd. Liberada      Qtd. Separada      Qtd. Total            Estoque"
Local Cabec2       	:= ""
Local imprime      	:= .T.
Local aOrd 			:= {}

Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "M"
Private nomeprog    := "RELPROD" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cPerg       := "PRODCART"
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "RELPROD" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString 	:= "SC6"


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
Local clQry 	:= ""
Local nlQtdLib	:= 0 
Local nlQtdSep	:= 0
Local clProdAux	:= ""
Local nlSld		:= 0
Local clCodProd	:= ""
Local clLocProd	:= ""
Local clDescProd:= ""

clQry := "SELECT B1_XCODCAT, C6_LOCAL, B1_DESC, C9_QTDLIB , C9_EXPFLAG FROM "+RetSqlName("SC6")+" SC6"
clQry += " INNER JOIN "+RetSqlName("SB1")+" SB1"
clQry += "  ON ( B1_FILIAL = '"+xFilial("SB1")+"' AND B1_COD = C6_PRODUTO AND B1_LOCPAD = C6_LOCAL )"
clQry += " INNER JOIN "+RetSqlName("SC9")+" SC9"
clQry += "  ON ( C9_FILIAL = C6_FILIAL AND C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM "
//clQry += "  	 AND C9_EXPFLAG <> '00' "   												// Nao filtra os itens que nao foram separados
clQry += " 		 AND (C9_BLCRED <> '09' AND C9_BLCRED <> '10' AND C9_BLCRED <> 'ZZ'))"		// Nao filtra os itens que foram rejeitados
clQry += " LEFT JOIN "+RetSqlName("SD2")+" SD2"
clQry += "  ON ( D2_FILIAL = C9_FILIAL AND D2_PEDIDO = C9_PEDIDO AND D2_ITEMPV = C9_ITEM AND SD2.D_E_L_E_T_ <> '*'"
clQry += "		 AND D2_DOC IS NULL)"														// Filtra apenas os itens que nao possuirem nota de saida
clQry += " WHERE SC6.D_E_L_E_T_ <> '*'"
clQry += " AND SC9.D_E_L_E_T_ <> '*'"
clQry += " AND SB1.D_E_L_E_T_ <> '*'"
clQry += " AND SC6.C6_ENTREG BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"'"
clQry += " ORDER BY B1_XCODCAT, C6_LOCAL"

If Select("XPROD") > 0
	XPROD->(DbCloseArea())
EndIf

TcQuery clQry New Alias "XPROD"

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������

SetRegua(RecCount())


XPROD->(dbGoTop())
clProdAux 	:= XPROD->B1_XCODCAT + XPROD->C6_LOCAL
clCodProd	:= Alltrim(XPROD->B1_XCODCAT)
clLocProd	:= XPROD->C6_LOCAL
clDescProd	:= Alltrim(XPROD->B1_DESC)
While XPROD->(!EOF())

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   	If lAbortPrint
      	@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
    	Exit
   	Endif
	If clProdAux <> XPROD->B1_XCODCAT + XPROD->C6_LOCAL
			
	   	//Buscar Saldo disponivel	
		If SB2->(DbSeek( xFilial("SB2") + clProdAux))
			nlSld 	:= SALDOSB2()
			If nlSld < 0
				nlSld	:= 0
			EndIf
		Else
			nlSld	:= 0
		Endif				
	   
	   //���������������������������������������������������������������������Ŀ   
	   //� Impressao do cabecalho do relatorio. . .                            �
	   //�����������������������������������������������������������������������
	
		If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif
		@ nLin, 00 PSAY clCodProd+" - "+clDescProd
		@ nLin, 48 PSAY clLocProd
		@ nLin, 56 PSAY Transform(nlQtdLib/*Alltrim(Str(99999999999999))*/	,"@E 999,999,999.99")
		@ nLin, 75 PSAY Transform(nlQtdSep,"@E 999,999,999.99")
		@ nLin, 91 PSAY Transform(nlQtdLib+nlQtdSep 	,"@E 999,999,999.99")
		@ nLin, 110 PSAY Transform(nlSld 	,"@E 999,999,999.99")
		 
		clProdAux 	:= XPROD->B1_XCODCAT + XPROD->C6_LOCAL
		clCodProd	:= Alltrim(XPROD->B1_XCODCAT)
		clLocProd	:= XPROD->C6_LOCAL
		clDescProd	:= Alltrim(XPROD->B1_DESC)
		If XPROD->C9_EXPFLAG == '  '			// Se o item esta aguardando separacao
			nlQtdLib    := XPROD->C9_QTDLIB
			nlQtdSep	:= 0
		Else
			nlQtdLib	:= 0
			nlQtdSep    := XPROD->C9_QTDLIB
		EndIf
		nLin++
	Else

		If XPROD->C9_EXPFLAG == '  '			// Se o item esta aguardando separacao
			nlQtdLib    += XPROD->C9_QTDLIB
		Else
			nlQtdSep    += XPROD->C9_QTDLIB
		EndIf
	EndIf	
		
	XPROD->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo

If !Empty(clCodProd)
	If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	//Buscar Saldo disponivel	
	If SB2->(DbSeek( xFilial("SB2") + clProdAux))
		nlSld 	:= SALDOSB2()
		If nlSld < 0
			nlSld	:= 0
		EndIf
	Else
		nlSld	:= 0
	Endif
	@ nLin, 00 PSAY clCodProd+" - "+clDescProd
	@ nLin, 48 PSAY clLocProd
	@ nLin, 56 PSAY Transform(nlQtdLib/*Alltrim(Str(99999999999999))*/	,"@E 999,999,999.99")
	@ nLin, 75 PSAY Transform(nlQtdSep,"@E 999,999,999.99")
	@ nLin, 91 PSAY Transform(nlQtdLib+nlQtdSep 	,"@E 999,999,999.99")	
	@ nLin, 110 PSAY Transform(nlSld 	,"@E 999,999,999.99")
EndIf
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

	PutSx1(cPerg,"01","Da Data?            	","Da Filial?               ","Da Filial?               ","MV_CH1" ,"D",8,0,0,"G","               ","","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"02","Ate a Data?          ","Ate a Filial?            ","Ate a Filial?            ","MV_CH2" ,"D",8,0,0,"G","               ","","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	
Return (Nil)