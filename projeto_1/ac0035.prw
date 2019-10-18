#INCLUDE "FWBROWSE.CH"
#include "rwmake.ch"

User Function AC0035()

SetPrvt("LEND,LABORTPRINT")
SetPrvt("_ASTRU,_CARQ,_CINDEX,_CCHAVE,I,_CCODCLI,_nTotValor")
SetPrvt("_CNUMPED,_CARQUIVO,_NHA,_CNREDUZ,_ACAMPOS")
SetPrvt("_CMARCA,_AEMPRESAS")
SetPrvt("ACAMPOS,CNOMARQ,CARQNTX,_ALINTXT,_NHDLY,_NI")
SetPrvt("_CTIPOREG,_CLOJCLI,_DEMISSAO,_CCODPRO,_NQTDUM")
SetPrvt("_CCODUM2,_NQTDUM2,_CTES,_CCF,_CSITTRIB")
SetPrvt("_NITEM,_NPEDN,_CCFOANT,_CARQTMP")

PRIVATE aInd:={}

/*/
***************************************************************************
*+-----------------------------------------------------------------------+*
*|Funcao    | AC0035   | Autor | Anderson Silva	       | Data |07.11.2005|*
*+----------+------------------------------------------------------------+*
*|Descricao | Seleciona pedidos para impressao                           |*
*+----------+------------------------------------------------------------+*
*|Revisoes	|01/06/2012-M.AFLITOS-AJUSTADO PARA CLIENTE DAISA			 |*
*+----------|------------------------------------------------------------+*
***************************************************************************
/*/

IF .NOT. AC0035Param()
	RETURN
ENDIF

lEnd:= .F.

Processa( {|lEnd| _MontaTRB(MV_PAR09, (MV_PAR10==1),MV_PAR11)} , "Processando..." , "Selecionando pedidos..." , .t. )

FormBrowse()

//FormBrwTable()
IF Select("TRB")<>0
	TRB->(DbCloseARea())
ENDIF

IF File( _cArq )
	FErase(_cArq )
	FErase(_cIndex)
ENDIF

Return

//************************//
Static Function _MontaTRB(nSitPed, lListaItens, nGeraFin)
//************************//
LOCAL aSitua:={}
LOCAL aTipo:={}
LOCAL aF4Duplic:={"S","N","S;N"}
LOCAL _aStru := {}
LOCAL cNF:=""
LOCAL cSerieNf:=""
LOCAL cDtNF
LOCAL _nTotValor:=0
LOCAL _nQtdVen:=0
LOCAL dDtEntrega:=Ctod("  /  /  ")
LOCAL aItens:={}
LOCAL nItem:=0

AAdd( _aStru , { "OK"        , "C" , 02 , 0 })
AAdd( _aStru , { "CODCLI"    , "C" , 09 , 0 })
AAdd( _aStru , { "CLIENTE"   , "C" , 20 , 0 })
AAdd( _aStru , { "PEDIDO"    , "C" , 06 , 0 })
AAdd( _aStru , { "EMISSAO"   , "D" , 08 , 0 })
AAdd( _aStru , { "VENDEDOR"  , "C" , 10 , 0 })
AAdd( _aStru , { "TOTVEN_QTD", "N" , 10 , 0 })
AAdd( _aStru , { "TOTVEN_VLR", "N" , 12 , 2 })
AAdd( _aStru , { "ENTREGA"   , "D" , 08 , 0 })
IF !lListaItens
	AAdd( _aStru , { "DATANF"    , "D" ,  8 , 0 })
	AAdd( _aStru , { "NOTAFISC"  , "C" , 09 , 0 })
	AAdd( _aStru , { "SERIENF"   , "C" ,  3 , 0 })
ELSE
	AAdd( _aStru , { "PRODUTO"  ,'C' , 15 , 0 })
	AAdd( _aStru,  { "DESCRICAO",'C' , 30 , 0 })
	AAdd( _aStru,  { "VLRITEMPED",'N', 12 , 2 })
	AAdd( _aStru , { "NOTAFISC", 'C' , 09 , 0 })
	AAdd( _aStru , { "SERIENF" , 'C' ,  3 , 0 })
	AAdd( _aStru , { "DATANF"  , 'D' ,  8 , 0 })
	AAdd( _aStru , { "VLRITEMNF", 'N' , 12 , 2 })
ENDIF

_cArq   := Criatrab(NIL,.F.)
_cIndex := _cArq+".CDX"
_cArq   += ".DBF"

DBCREATE( _cARq, _aStru, 'DBFCDXADS' )
USE (_cArq) VIA "DBFCDXADS" ALIAS "TRB" NEW

//Indexação
//AAdd( aInd ,{"TRB->PEDIDO+TRB->CODCLI+TRB->LOJACLI", "Pedido" })
AAdd( aInd ,{"TRB->PEDIDO+TRB->CODCLI", "Pedido" })
AAdd( aInd ,{"TRB->CODCLI+TRB->PEDIDO", "Cod.Cliente + Emissao" } )
AAdd( aInd ,{"DTOS(TRB->EMISSAO)+TRB->CLIENTE","Emissao Pedido + Cliente "} )
AAdd( aInd ,{"TRB->CLIENTE+TRB->PEDIDO","Nome Cliente" } )
AAdd( aInd ,{"TRB->VENDEDOR+TRB->CLIENTE","Nome Vendedor" } )
AAdd( aInd ,{"DTOS(TRB->ENTREGA)+TRB->CLIENTE","Previsao Entrega"} )
AAdd( aInd ,{"DTOS(TRB->DATANF)","Data da N.Fiscal" } )

Aeval( aInd, {|ii,ss| OrdCreate(_cIndex,Str(ss,1), ii[1], {|| ii[1] }) })

DbSelectArea("SC5")
ProcRegua( RecCount() )
DbSetOrder(2) //Filial + Emissao
DbSeek(xFilial()+DTOS(MV_PAR01),.T.) //Posiciona na primeira data de pedido

aSitua:={}
AAdd(aSitua,{|| SC5->C5_LIBEROK == " " .or. SC6->C6_QTDENT <> 0 })  //1=Já Entregues
AAdd(aSitua,{|| SC5->C5_LIBEROK == "S" .or. SC6->C6_QTDENT = 0 })   //2=Lista pedidos com quant. a entregar
AAdd(aSitua,{|| .F. })                                              //3-Todos

//aTipo:={}
//AAdd(aTipo,{|| Empty(SC5->C5_NUM_AC) })         //Somente AC
//AAdd(aTipo,{|| .NOT. Empty(SC5->C5_NUM_AC) })   //Somente Pedidos s/AC
//AAdd(aTipo,{|| .F. })                           //Ambos

//1-Data de
//2-Data ate
//3-Pedido de
//4-Pedido ate
//5-Cli/Lj de
//6-Cli/Lj ate
//7-Vendedor de
//8-Vend    ate
//9-Situacao do ped

While !EOF() .and. SC5->C5_EMISSAO <= MV_PAR02  //Lista até a data
	
	IncProc("Processando Pedidos...")
	
	IF (SC5->C5_NUM < MV_PAR03 .or. SC5->C5_NUM > MV_PAR04 )//Intervalo dos pedidos
		DbSkip()
		Loop
	End
	
	IF (MV_PAR05 > SC5->C5_CLIENTE+SC5->C5_LOJACLI .or. MV_PAR06 < SC5->C5_CLIENTE+SC5->C5_LOJACLI) //Intervalo de Clientes
		DbSkip()
		Loop
	End
	
	IF Eval( aSitua[nSitPed] )    //Situação do Pedido
		DbSkip()
		LOOP
	ENDIF
	
	DbSelectArea("SD2")
	DbSetOrder(8)   //D2_FILIAL + D2_PEDIDO + D2_ITEMPV
	
	DbSelectArea("SC6")
	DbSetOrder(1)
	DbSeek(xFilial()+SC5->C5_NUM)
	
	cNf:=Space(6)
	dDtNf:=Ctod("  /  /  ")
	cSerieNF:=""
	dDtEntrega:=Ctod("  /  /  ")
	_nTotValor := 0
	_nQtdven   := 0
	aItens:={}
	DO WHILE !EOF().and. SC5->C5_NUM == SC6->C6_NUM
		IF SF4->(DbSeek(xFilial("SF4")+SC6->C6_TES)) .AND. (SF4->F4_DUPLIC $ (aF4Duplic[nGeraFin]))
			_nTotValor := _nTotValor + SC6->C6_VALOR
			_nQtdven   := _nQtdven + SC6->C6_QTDVEN
			
			IF SC6->C6_NOTA > cNF
				cNf:= SC6->C6_NOTA
				cSerieNF:=SC6->C6_SERIE
				dDtNf:=SC6->C6_DATFAT
			ENDIF
			IF SC6->C6_ENTREG > dDtEntrega
				dDtEntrega:=SC6->C6_ENTREG
			ENDIF
			
			IF lListaItens
				nItem:=0
				SD2->(DbSeek( xFilial("SD2")+SC6->C6_NUM+SC6->C6_ITEM ))
				DO WHILE (SD2->D2_PEDIDO+SD2->D2_ITEMPV) == (SC6->C6_NUM+SC6->C6_ITEM) .OR. nItem==0
					AAdd(aItens,{;
					SC6->C6_XCODANT,;
					SC6->C6_DESCRI,;
					SC6->C6_VALOR,;
					SD2->D2_DOC,;
					SD2->D2_SERIE,;
					SD2->D2_EMISSAO,;
					SD2->D2_TOTAL })

					++nItem
					SD2->(DbSkip())
				ENDDO
			ENDIF
		ENDIF
		DbSkip()
	ENDDO
	
	IF _nTotValor <> 0
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial()+SC5->C5_CLIENTE+SC5->C5_LOJACLI)
		
		DbSelectArea("SA3")
		DbSetOrder(1)
		DbSeek(xFilial()+SC5->C5_VEND1)
		
		FOR nItem:=1 TO (IIf( lListaItens,Len(aItens),1))
			DbSelectArea("TRB")
			RecLock("TRB",.T.)
			TRB->PEDIDO   := SC5->C5_NUM
			TRB->EMISSAO  := SC5->C5_EMISSAO
			TRB->CODCLI   := SC5->C5_CLIENTE+"/"+SA1->A1_LOJA
			//TRB->LOJACLI  := SC5->C5_LOJACLI
			TRB->CLIENTE  := OemtoAnsi(Alltrim(SA1->A1_NREDUZ))
			TRB->VENDEDOR := SA3->A3_NOME
			TRB->ENTREGA  := dDtEntrega      //SC6->C6_ENTREG
			TRB->TOTVEN_QTD:= _nQtdVen
			TRB->TOTVEN_VLR:= _nTotValor
			
			IF !lListaItens
				TRB->NOTAFISC := cNF
				TRB->SERIENF  := cSerieNF
				TRB->DATANF   := dDtNF
			ELSE
				TRB->PRODUTO  := aItens[nItem, 1]
				TRB->DESCRICAO:= aItens[nItem, 2]
				TRB->VLRITEMPED:=aItens[nItem, 3]
				TRB->NOTAFISC := aItens[nItem, 4]
				TRB->SERIENF  := aItens[nItem, 5]
				TRB->DATANF   := aItens[nItem, 6]
				TRB->VLRITEMNF:= aItens[nItem, 7]
			ENDIF
			
		NEXT
		MsUnLock()
	ENDIF
	
	DbSelectArea("SC5")
	DbSkip()
	
Enddo

TRB->(OrdSetFocus(1))
TRB->(DbGotop())

RETURN


STATIC FUNCTION FormBrowse()

@ 200,001 TO 600,550 DIALOG oDlg2 TITLE "Selecao de Pedidos para impressao"

_aCampos := {}
AADD( _aCampos , { "OK"       , ""            , "@!" , "02" , "0" })
AADD( _aCampos , { "PEDIDO"   , "Pedido"      , "@!" , "06" , "0" })
AADD( _aCampos , { "EMISSAO"  , "Emissao"     , "@!" , "08" , "0" })
AADD( _aCampos , { "CODCLI"   , "Cli/Loj"     , "@!" , "09","0" })
AADD( _aCampos , { "CLIENTE"  , "Nome Cliente", "@!" , "20" , "0" })
AAdd( _aCampos , { "VENDEDOR" , "Repr/Regiao" , "@!" , "10" , "0" })

@ 010,010 TO 150,270 BROWSE "TRB" FIELDS _aCampos MARK "OK" object _oMark

_cPedido := Space(6)

@ 155,040 SAY "Numero Pedido "
@ 155,085 GET _cPedido SIZE 64,10

@ 180,010 BUTTON "_Fechar"        	  SIZE 40,15 ACTION Close(oDlg2)
@ 180,050 BUTTON "_Pesquisar"         SIZE 40,15 ACTION Pesquisar()
@ 180,090 BUTTON "_Marcar Tudo"   	  SIZE 40,15 ACTION Marca()
@ 180,130 BUTTON "_Desmarcar Tudo"	  SIZE 40,15 ACTION Desmarca()
@ 180,180 BUTTON "_Imprimir Pedidos"  SIZE 40,15 ACTION _ProcPed()
@ 180,220 BUTTON "_Gerar Planilha"    SIZE 40,15 ACTION _GeraPlan()

ACTIVATE DIALOG oDlg2 CENTERED

Return

//*********************//
Static Function Pesquisar()
//*********************//
DbSeek(_cPedido,.f.)
_oMark:oBrowse:Refresh()
Return

//*********************//
Static Function Marca()
//*********************//
_cMarca:=GetMark()

DbSelectArea("TRB")
ProcRegua( TRB->(RecCount()))
DbGoTop()
While !Eof()
	
	IncProc("Marcando Todos os Registros")
	
	If !Marked("OK")
		Reclock("TRB",.F.)
		TRB->OK := _cMarca
		MsUnlock()
	EndIf
	DbSkip()
Enddo
DbGoTop()
_oMark:oBrowse:Refresh()

Return


//***********************//
Static Function DesMarca()
//***********************//
DbSelectArea("TRB")
ProcRegua( TRB->(RecCount()) )
DbGoTop()
While !EOF()
	
	IncProc("Desmarcando Todos os Registros")
	
	If Marked("OK")
		Reclock("TRB",.F.)
		TRB->OK := ThisMark()
		MsUnlock()
	EndIf
	DbSkip()
End
DbGoTop()
_oMark:oBrowse:Refresh()

Return


// ******************
Static Function _GeraPlan()
LOCAL oExcelApp
Local cDirDocs   := MsDocPath()
Local cPath := AllTrim(GetTempPath())  //"c:\relprotheus\"
Local lCpy:=.F.
Local cArqXLS:=""

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf

DbSelectArea("TRB")

ProcREgua( TRB->(RecCount()) )
DbGoTop()
DO WHILE !TRB->(Eof())
	
	IncProc("Gerando a Planilha dos Pedidos Marcados")
	
	IF .NOT. Marked("OK")
		RecLock("TRB",.F.)
		DbDeleted()
		DbUnLock()
	ENDIF
	DbSkip()
ENDDO

//CK  //elimina os deletados
TRB->(DbCloseArea())  //precisa fechar para gerar a planilha

//cArqXls:=StrTran(Lower(_cArq), ".dbf",".xls")
cArqXls:=_cArq + ".xls"
lCpy:=__CopyFile(_cArq, (cPath+cARqXls))
//testcopy( _cArq , ( cAPath+_cARq))
IF lCpy
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open(cPath+cArqXls) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	oExcelApp:Destroy()
ELSE
	MsgStop("Não foi possível concluir a cópia dos dados para abertura da planilha")
ENDIF

Close(oDlg2)

RETURN



//*************************//
Static Function _ProcPed()
//*************************//
cDesc1        := "Este programa tem como objetivo imprimir relatorio "
cDesc2        := "de acordo com os parametros informados pelo usuario."
cDesc3        := "Relatorio ACs/Pedidos"
cPict         := ""
titulo        := "Relatorio de AC/Pedidos de Venda"
nLin          := 80

//         10        20        30        40        50        60        70        80        90        100
//123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//Cabec1      := " Num.AC | Pedido | Emissao  | Cliente   | Vendedor   | Descricao Cliente        | Quantidade  | Vlr.Total  | Prev.Entr | Data NF  |
Cabec1      := "------ | Pedido | Emissao  | Cliente   | Vendedor   | Descricao Cliente    | Quantidade |  Vlr.Total  | Prev.Entr | Data NF  |"
Cabec2      := ""
imprime     := .T.
aOrd			:= {}
lEnd        := .F.
lAbortPrint := .F.
CbTxt       := ""
limite      := 80
tamanho     := "M" //Determina o tamanho da fonte de impressao
nomeprog    := "AC0035"
nTipo       := 18
aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
nLastKey    := 0
cbtxt      := Space(10)
cbcont     := 00
CONTFL     := 01
m_pag      := 01
wnrel      := "AC0035"
cPerg	     := "AC0035"
cString    := "TRB"

Aeval( aInd, {|zz| AAdd( aOrd, zz[2]) })  //Ordens (indices) a serem escolhidos

dbSelectArea("TRB")
DbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

//***************************************************//
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
LOCAL dDtNF:=""

DbSelectArea("SC5")
DbSetOrder(1)

DbSelectArea("SA3")
DbSetOrder(1)

DbSelectArea("SC6")
DbSetOrder(1)

DbSelectArea("SF2")
DbSetOrder(1) //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO

SF4->(OrdSetFocus(1))

dbSelectArea("TRB")
OrdSetFocus( aReturn[8] )
DbGoTop()

Titulo:=Titulo +"por: "+aInd[aReturn[8],2]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())
_nTotalP   :=0
While !EOF()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If !Marked("OK")
		IncProc("Pulando Pedido ==> "+TRB->PEDIDO)
		DbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
		
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	
	/*
	Num.AC | Pedido | Emissao  | Cliente   | Vendedor   | Descricao Cliente    | Quantidade |  Vlr.Total  | Prev.Entr | Data NF  |
	xxxxxx   xxxxxx   xx/xx/xx   xxxxxx-xx   xxxxxxxxxx   xxxxxxxxxxxxxxxxxxxx   999,999,99   9999,999,99   99/99/99    99/99/99
	1        10       19         30          42           55                     78           91            105         117
	*/
	//@nLin,001 PSAY  TRB->NUM_AC
	//@nLin,008 PSAY	"| "
	@nLin,010 PSAY  TRB->PEDIDO
	@nLin,017 PSAY	"| "
	@nLin,019 PSAY  TRB->EMISSAO
	@nLin,028 PSAY	"| "
	@nLin,030 PSAY  TRB->CODCLI
	@nLin,040 PSAY	"| "
	@nLin,042 PSAY  ALLTRIM(Substr(TRB->VENDEDOR,1,10))
	@nLin,053 PSAY	"| "
	@nLin,055 PSAY  ALLTRIM(Substr(TRB->CLIENTE,1,25))
	@nLin,076 PSAY	"| "
	@nLin,078 PSAY  TRB->TOTVEN_QTD PICTURE "@E 999,999"
	@nLin,089 PSAY	"| "
	@nLin,091 PSAY  TRB->TOTVEN_VLR PICTURE "@E 999,999.99"
	@nLin,103 PSAY "| "
	@nLin,105 PSAY	TRB->EMISSAO
	@nLin,115 Psay "| "
	@nLin,117 PSay Transform(TRB->DATANF,"@D")
	nLin := nLin + 1 // Avanca a linha de impressao
	_nTotalP   := _nTotalP + TRB->TOTVEN_VLR
	
	DbSelectArea("TRB")
	DbSkip() // Avanca o ponteiro do registro no arquivo
	
EndDo

If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 8
Else
	nLin := nLin + 1 // Avanca a linha de impressao
End
@nLin,077 PSAY "Valor Total"
@nLin,093 PSAY _nTotalP PICTURE "@E 999,999,999.99"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


Static Function AC0035Param()
Local aPergs := {}
Local aParam := { ;
CtoD(""),;   //1-Data de
CtoD(""),;   //2-Data ate
Space(6),;   //3-Pedido de
Space(6),;   //4-Pedido ate
Space(8),;   //5-Cli/Lj de
Space(8),;   //6-Cli/Lj ate
Space(6),;   //7-Vendedor de
Space(6),;   //8-Vend    ate
3,;          //9-Situacao do ped
2,;          //10-Listar itens  
1,;          //Gera Financ
}

Local aRet := {}
Local lRet

aAdd(aPergs ,{1,"Data de..........",aParam[1],"@d",'.T.',,'.T.',50,.F.})
aAdd(aPergs ,{1,"Data ate.........",aParam[2],"@d",'.T.',,'.T.',50,.F.})
aAdd(aPergs ,{1,"Pedido de........",aParam[3],"@!",'.T.',,'.T.',30,.F.})
aAdd(aPergs ,{1,"Pedido ate.......",aParam[4],"@!",'.T.',,'.T.',30,.F.})
AADD(aPergs ,{1,"Cliente/Loja de..",aParam[5],"@!",'.T.',,'.T.',35,.F.})
AADD(aPergs ,{1,"Cliente/Loja ate.",aParam[6],"@!",'.T.',,'.T.',35,.F.})
AADD(aPergs ,{1,"Vend/Regiao de...",aParam[7],"@!",'.T.',,'.T.',30,.F.})
AADD(aPergs ,{1,"Vend/Regiao ate..",aParam[8],"@!",'.T.',,'.T.',30,.F.})
aAdd(aPergs ,{2,"Situacao Pedido..",aParam[9],{"1-Já Entregues","2-Com Quant.a entregar","3-Todos"},80,'.T.',.F.})
AAdd(aPergs ,{2,"Listar Itens.....",aParam[10],{"1-Sim","2-Nao"},35,'.T.',.F.})
AAdd(aPergs, {2,"TES Gera Financ..",aParam[11],{"1-Sim","2-Nao","3-Ambas"},35,'.T.',.F.})

lRet:=ParamBox(aPergs ,"(ESPECIFICO)Relacao de Pedidos-Parametros ",@aRet,,,.t.,,,,("AC0035"+cEmpAnt+cFilAnt),.t.,.t.)

Return lRet

/*
aSitua:={}
AAdd(aSitua,{|| SC5->C5_LIBEROK == " " .or. SC6->C6_QTDENT <> 0 })  //1=Já Entregues
AAdd(aSitua,{|| SC5->C5_LIBEROK == "S" .or. SC6->C6_QTDENT = 0 })   //2=Lista pedidos com quant. a entregar
AAdd(aSitua,{|| .F. })                                              //3-Todos

2 - Combo
[2] : Descrição
[3] : Numérico contendo a opção inicial do combo
[4] : Array contendo as opções do Combo
[5] : Tamanho do Combo
[6] : Validação
[7] : Flag .T./.F. Parâmetro Obrigatório ?
*/

STATIC Function FormBrwTable()
Local oBrowse
Local oButton
Local oColumn
Local oDlg

//-------------------------------------------------------------------
// Abertura da tabela
//-------------------------------------------------------------------
//DbUseArea(.T.,,"SX2990","SX2",.T.,.F.)
//DbSetOrder(1)

//-------------------------------------------------------------------
// Define a janela do Browse
//-------------------------------------------------------------------
DEFINE MSDIALOG oDlg FROM 200,001 TO 600,550 PIXEL TITLE "Selecao de Pedidos para impressao"
//@ 200,001 TO 600,550 DIALOG oDlg2 TITLE "Selecao de Pedidos para impressao"
//-------------------------------------------------------------------
// Define o Browse
//-------------------------------------------------------------------
DEFINE FWFORMBROWSE oBrowse DATA TABLE ALIAS "TRB" OF oDlg
//--------------------------------------------------------
// Cria uma coluna de marca/desmarca
//--------------------------------------------------------
ADD MARKCOLUMN oColumn DATA { || If(.T./* Função com a regra*/,'LBOK','LBNO') } DOUBLECLICK { |oBrowse| /* Função que atualiza a regra*/ } HEADERCLICK { |oBrowse| /* Função executada no clique do header */ } OF oBrowse
//--------------------------------------------------------
// Cria uma coluna de status
//--------------------------------------------------------
ADD STATUSCOLUMN oColumn DATA { || If( Empty(TRB->DATANF)/* Função com a regra*/,'BR_GREEN','BR_VERMELHO') } DOUBLECLICK { |oBrowse| /* Função executada no duplo clique na coluna*/ } OF oBrowse
//--------------------------------------------------------
// Adiciona legenda no Browse
//--------------------------------------------------------
ADD LEGEND DATA 'Empty(TRB->DATANF)'  COLOR "GREEN" TITLE "SEM Faturamento" OF oBrowse
ADD LEGEND DATA '!Empty(TRB->DATANF)' COLOR "RED"   TITLE "COM Faturamento" OF oBrowse
//-------------------------------------------------------------------
// Adiciona as colunas do Browse
//-------------------------------------------------------------------
ADD BUTTON oButton TITLE "Fechar"      ACTION {|| Close(oDlg) } OF oBrowse
ADD BUTTON oButton TITLE "Pesquisar"   ACTION {|| Pesquisar(oDlg) } OF oBrowse
ADD BUTTON oButton TITLE "Marcar Tudo" ACTION {|| Marca() } OF oBrowse
ADD BUTTON oButton TITLE "Desmarcar Tudo"	 ACTION {|| Desmarca() } OF oBrowse
ADD BUTTON oButton TITLE "Imprimir Pedidos" ACTION {|| _ProcPed() } OF oBrowse
ADD BUTTON oButton TITLE "Gerar Planilha"   ACTION {|| _GeraPlan() } OF oBrowse

//-------------------------------------------------------------------
// Adiciona as colunas do Browse
//-------------------------------------------------------------------
ADD COLUMN oColumn DATA { || NUM_AC     } TITLE "Num.AC"    SIZE  6 HEADERCLICK { |oBrowse| /* Função executada no clique do header */ } OF oBrowse
ADD COLUMN oColumn DATA { || PEDIDO     } TITLE "Pedido"    SIZE  6 HEADERCLICK { |oBrowse| /* Função executada no clique do header */ } OF oBrowse
ADD COLUMN oColumn DATA { || EMISSAO    } TITLE "Emissao"   SIZE  8 HEADERCLICK { |oBrowse| /* Função executada no clique do header */ } OF oBrowse
ADD COLUMN oColumn DATA { || CODCLI     } TITLE "Cli/Loja"   SIZE  9 HEADERCLICK { |oBrowse| /* Função executada no clique do header */ } OF oBrowse
//ADD COLUMN oColumn DATA { || LOJACLI    } TITLE "Loja"   SIZE  2 HEADERCLICK { |oBrowse| /* Função executada no clique do header */ } OF oBrowse

//-------------------------------------------------------------------
// Ativação do Browse
//-------------------------------------------------------------------
ACTIVATE FWFORMBROWSE oBrowse
//-------------------------------------------------------------------
// Ativação do janela
//-------------------------------------------------------------------
ACTIVATE MSDIALOG oDlg CENTERED

Return
