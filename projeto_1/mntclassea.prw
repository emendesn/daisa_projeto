#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#include "PROTHEUS.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMntClasseAบAutor  ณStanko              บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monitor da Expedicao Daisa                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FAT                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MntClasseA()
Local cPerg := "MNTCLASSA"
Private cCadastro := "Monitor da Expedi็ใo"
Private aRotina   := {}

Private oDlgTV
Private oTelaTV
Private nRecTV := 1
Private cURL := "C:\TEMP\TELATV.HTML"
Private lAbreQry := .T.

AjustaSx1(cPerg)

If Pergunte(cPerg,.T.)
	ProcRot()
	AbreTela()
EndIf
 
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณProcRot   บAutor  ณStanko              บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento da Rotina                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcRot()
Local cQuery       
Local cEnter := Chr(13)
Local cAlias := GetNextAlias()                

CriaTrb()

BeginSql Alias "TMP"

	SELECT 
	B1_XCLASS CLASSE,
	B1_XBLANK BLANK,
	
	(SELECT SB1B.B1_DESC
	FROM SB1010 SB1B
	WHERE SB1B.B1_FILIAL = ' ' AND SB1B.D_E_L_E_T_ = ' '
	AND SB1B.B1_COD = SB1.B1_XBLANK) DESCRBLK,

	C9_PRODUTO PRODUTO, 
	B1_DESC  DESCRPROD,
	
	C9_LOCAL LOCALPRD, 
	
	'03' LOCALBLK,
	
	isnull((SELECT B2_QATU FROM SB2010 SB2
	WHERE B2_FILIAL = '01' AND SB2.D_E_L_E_T_ = ' '
	AND B2_LOCAL = '03'
	AND B2_COD = B1_XBLANK),0) ESTATU,
	
	B1_LM LOTEMIN,
	
	B1_LE LOTEPRD,
	
	B1_XDIAS DIASEST,
	
	SUM(C9_QTDLIB) QTDCART
	
	FROM SC9010 SC9, SC6010 SC6, SB1010 SB1
	WHERE C9_FILIAL = '01' AND SC9.D_E_L_E_T_ = ' '
	AND C9_BLCRED = ' '
	AND C9_NFISCAL = ' '
	AND C6_FILIAL = C9_FILIAL AND SC6.D_E_L_E_T_ = ' '
	AND C6_NUM = C9_PEDIDO
	AND C6_ITEM = C9_ITEM
	AND C6_PRODUTO = C9_PRODUTO
	AND B1_FILIAL = ' ' AND SB1.D_E_L_E_T_ = ' '
	AND B1_COD = C9_PRODUTO                
	
	AND C9_PRODUTO  BETWEEN %Exp:(MV_PAR01)% AND %Exp:(MV_PAR02)%
	AND B1_XBLANK  BETWEEN %Exp:(MV_PAR03)% AND %Exp:(MV_PAR04)%
	AND C9_LOCAL   BETWEEN %Exp:(MV_PAR05)% AND %Exp:(MV_PAR06)%
	AND C6_ENTREG  BETWEEN %Exp:(MV_PAR07)% AND %Exp:(MV_PAR08)%
	AND B1_XCLASS  BETWEEN %Exp:(MV_PAR12)% AND %Exp:(MV_PAR13)%
	


	GROUP BY B1_XCLASS, B1_XBLANK, C9_PRODUTO, B1_DESC, C9_LOCAL, B1_LM, B1_LE, B1_XDIAS
	ORDER BY B1_XCLASS, B1_XBLANK, C9_PRODUTO


EndSQL
    


dbSelectArea("TMP")
While !EOF()     
                         
    nDiasInic := 0     
    
    If TMP->ESTATU > 0  .And. Val(TMP->DIASEST) > 0  .And. TMP->LOTEPRD > 0
		nDiasAtu  := TMP->ESTATU / (TMP->LOTEPRD/Val(TMP->DIASEST))
	Else
		nDiasAtu  := 0
	EndIf	
    
	dbSelectArea("ZZZ")
	dbSetOrder(1)
	If dbSeek(xFilial("ZZZ")+DTOS(dDataBase)+TMP->BLANK+TMP->PRODUTO+TMP->LOCALPRD)
		nDiasInic := ZZZ->ZZZ_DIAS

	Else          
		nDiasInic := nDiasAtu
		RecLock("ZZZ",.T.)    
		ZZZ->ZZZ_DATA	:= dDataBase	
		ZZZ->ZZZ_FILIAL   := xFilial("ZZZ")
		ZZZ->ZZZ_BLANK    := TMP->BLANK
		ZZZ->ZZZ_PRODUTO  := TMP->PRODUTO
		ZZZ->ZZZ_LOCAL    := TMP->LOCALPRD       
		ZZZ->ZZZ_DIAS	  := nDiasAtu
		MsUnLock()
	EndIf		
	
		
	
	                  
//	For nX := 1 To 5
	dbSelectArea("TRB")
	RecLock("TRB",.T.)
	TRB->BLANK      := TMP->BLANK
	TRB->DESCRBLK   := TMP->DESCRBLK	
	TRB->PRODUTO    := TMP->PRODUTO
	TRB->DESCRPROD  := TMP->DESCRPROD
	TRB->LOCALPRD    := TMP->LOCALPRD
	TRB->LOCALBLK	 := TMP->LOCALBLK
	TRB->LOTEPRD    := TMP->LOTEPRD
	TRB->DIASINIC   := nDiasInic
	TRB->DIASATUAL  := nDiasAtu
	TRB->DIASEST    := Val(TMP->DIASEST)
	TRB->ESTATU		:= TMP->ESTATU
	TRB->(MsUnLock())                                                                                                                    
  //  Next
            
    dbSelectArea("TMP") 
	dbSkip()
EndDo
TMP->(dbCloseArea())



Return Nil


  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaTrb   บAutor  ณStanko              บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria o arquivo de trabalho principal                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaTrb()
Local aEstrut   := {}
Local cCampo
Local cArquivo   


//aAdd(aEstrut,{"CLASSE"		,	"C", 	, 	00})
aAdd(aEstrut,{"BLANK"		,	"C", 	30, 	00})
aAdd(aEstrut,{"DESCRBLK"	,	"C", 	30, 	00})
aAdd(aEstrut,{"PRODUTO"		,	"C", 	30, 	00})
aAdd(aEstrut,{"DESCRPROD"	,	"C", 	30, 	00}) 
aAdd(aEstrut,{"LOCALPRD"	,	"C", 	02,		00})
aAdd(aEstrut,{"LOCALBLK"	,	"C", 	02,		00})
aAdd(aEstrut,{"LOTEPRD"		,	"N", 	12,		02})
aAdd(aEstrut,{"DIASINIC"	,	"N", 	12,		05})
aAdd(aEstrut,{"DIASATUAL"	,	"N", 	12,		05})
aAdd(aEstrut,{"DIASEST"		,	"N", 	12,		05})
aAdd(aEstrut,{"ESTATU"		,	"N", 	12,		05})
 

cArquivo := CriaTrab( aEstrut, .T.)
dbUseArea(.T.,,cArquivo,"TRB",.F.,.F.)


dbSelectArea("TRB")
IndRegua("TRB",  Substr(cArquivo,1,7)+"A", "STR(DIASINIC)",,, 	"Criando Indice..." )
IndRegua("TRB",  Substr(cArquivo,1,7)+"B", "STR(DIASATUAL)+BLANK+PRODUTO",,, "Criando Indice..." )

dbClearIndex()
dbSetIndex(Substr(cArquivo,1,7)+"A"+OrdBagExt())
dbSetIndex(Substr(cArquivo,1,7)+"B"+OrdBagExt())

Return Nil
         
             


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAbreTela  บAutor  ณStanko              บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Abre a tela principal                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AbreTela()
Local aArea 	:= GetArea()
Local nOpcA 	:= 0
Local aCampos 	:= {}
Local aDados	:= {}	
Local aCpoTit := {}
             
Local oTimerCro

Local aHeader 	:= {}
Local aCols 	:= {}

Local aButtons := {}
Local aObjects := {}
Local aPosObj  := {}
Local aSize		:= MsAdvSize()
Local aInfo		:= {aSize[1], aSize[2], aSize[3], aSize[4], 1, 2}

Private oBrowse
Private oDlg
Private oVerde := LoadBitmap( GetResources(), "BR_VERDE" )
Private oAmarelo := LoadBitmap( GetResources(), "BR_AMARELO" )
Private oVermelho := LoadBitmap( GetResources(), "BR_VERMELHO" )

//aAdd(aButtons,{"RELATORIO",{|| 	MsAguarde( { || GeraExcel("TRB") } )}					,"Excel"})
aAdd(aButtons,{"RELATORIO",{|| 	MntExpLeg() }				   						,"Legenda"})
aAdd(aButtons,{"RELATORIO",{|| 	TelaTV(),TRB->(dbGotop()) }				   							,"Tela TV"})
 
 
dbSelectArea("TRB")
dbSetOrder(2)
dbGotop()

For nX := 1 To FCount()
	cCampo := FieldName(nx)       
	
	If Type(cCampo) == "N"        
		aAdd(aCampos,{cCampo,	   cCampo, 		  "@E 9,999,999.99"})
	Else
		aAdd(aCampos,{cCampo,	   cCampo, 		  "@!"})		
	EndIf
		
Next


aAdd( aObjects, {   100, 100, .t., .f. } )
aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],0 TO aSize[6], aSize[5] OF oMainWnd PIXEL


nPos1 := aPosObj[1,1]
nPos2 := aPosObj[1,2]
nPos3 := aPosObj[1,3]*2.5
nPos4 := aPosObj[1,4]

aAdd(aCpoTit,"")
aAdd(aCpoTit,"Blank")				//1
aAdd(aCpoTit,"Descr.Blank")            //2
aAdd(aCpoTit,"Produto")            //3
aAdd(aCpoTit,"Descr.Produto")               //4
aAdd(aCpoTit,"Local PA")            //5
aAdd(aCpoTit,"Local PI")            //5
aAdd(aCpoTit,"Lote Prod. PI")          //6
aAdd(aCpoTit,"Dias Inicio")             //7
aAdd(aCpoTit,"Dias Atual")             //8
aAdd(aCpoTit,"XDias PA")             //8
aAdd(aCpoTit,"Saldo Estoq PI")             //8


aAdd(aDados,RetCor())
aAdd(aDados,TRB->BLANK)
aAdd(aDados,TRB->DESCRBLK)
aAdd(aDados,TRB->PRODUTO)
aAdd(aDados,TRB->DESCRPROD)
aAdd(aDados,TRB->LOCALPRD)
aAdd(aDados,TRB->LOCALBLK)
aAdd(aDados,Transform(TRB->LOTEPRD,"@E 999,999.99"))
aAdd(aDados,Transform(TRB->DIASINIC,"@E 999.99"))
aAdd(aDados,Transform(TRB->DIASATUAL,"@E 999.99"))
aAdd(aDados,TRB->DIASEST)
aAdd(aDados,TRB->ESTATU)
                           



aAdd(aCampos,"")
aAdd(aCampos,"BLANK")
aAdd(aCampos,"DESCRBLK")
aAdd(aCampos,"PRODUTO")
aAdd(aCampos,"DESCRPROD")
aAdd(aCampos,"LOCALPRD")
aAdd(aCampos,"LOCALBLK")
aAdd(aCampos,"LOTEPRD")
aAdd(aCampos,"DIASINIC")
aAdd(aCampos,"DIASATUAL")
aAdd(aCampos,"DIASEST")
aAdd(aCampos,"ESTATU")
         
		
oBrowse := TWBrowse():New( nPos1, nPos2, nPos4, nPos3 , {|| {aCampos  } }, aCpoTit, , oDlg, , , ,,,,,,,,,,"TRB", .T. )
oBrowse:bLine := {|| { RetCor(), TRB->BLANK,TRB->DESCRBLK, TRB->PRODUTO, TRB->DESCRPROD, TRB->LOCALPRD, TRB->LOCALBLK,Transform(TRB->LOTEPRD,"@E 999,999.99"), Transform(TRB->DIASINIC,"@E 999.99999"), Transform(TRB->DIASATUAL,"@E 999.99999"),TRB->DIASEST,TRB->ESTATU } }
//oBrowse:bLine := {|| aDados }
//oBrowse:SetArray(aDados)
//oBrowse:bLDblClick := {|| A450Marcar(), oBrowse:Refresh() }

//oTimer:= TTimer():New(nTimeOut,{|| oDlg1:End() },oDlg1) // Ativa timer
//oTimer:Activate()


ACTIVATE MSDIALOG oDlg   ON INIT EnchoiceBar(oDlg, {||(ApagaTMP(),oDlg:End())}, {||ApagaTMP(),oDlg:End()},.F.,aButtons)
                      
TRB->(dbCloseArea())

Return Nil
                                                       

Static  Function ApagaTMP()
//TRB->(dbCloseArea())
Return .T.


Static Function RetCor()
Local oRet := oVerde

If TRB->DIASATUAL > 3
	oRet := oVerde

ElseIf TRB->DIASATUAL <= 1
	oRet := oVermelho

ElseIf TRB->DIASATUAL <= 3
	oRet := oAmarelo
EndIf
	
Return oRet	




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMntExpLeg บAutor  ณStanko              บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Legendas                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function MntExpLeg()

Local aLegenda := {	{"BR_VERDE"  											, "Positivo"	},;
{"BR_AMARELO"   , "Insuficiente"			 							},;
{"BR_VERMELHO"  , "Critico"					       						}}

BrwLegenda(cCadastro, "Estoque", aLegenda)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraExcel บAutor  ณStanko              บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GeraExcel(cAlias)
Local _cPathExcel:="C:\MICROSIGA\"

_cTmp := CriaTrab(,.F.)

dbSelectArea(cAlias)

COPY TO (_cTmp) VIA "DBFCDXADS"

MontaDir(_cPathExcel)
DbUseArea( .t., "DBFCDXADS", _cTmp, "TMP", .F. )

dbSelectArea("TMP")
dbCloseArea()

//Inicio da Planilha Excel
cArqTRB := _cTmp+".DBF"

If File(_cPathExcel+cArqTRB)
	FErase(_cPathExcel+cArqTRB)
EndIf

__CopyFile("\SYSTEM\"+cArqTRB,_cPathExcel+cArqTRB)
FRename(_cPathExcel+cArqTRB,_cPathExcel+_cTmp+".xls") // Renomeia para excel
If File(_cPathExcel+_cTmp+".xls")
	
	MsgAlert("Arquivo "+_cPathExcel+_cTmp+".xls"+" gerado com sucesso!")
	
Else
	MsgAlert("Problema ao gerar o Arquivo!!!")
EndIf
fErase(_cTmp+GetDBExtension())
fErase(_cTmp+OrdbagExt())

dbSelectArea(cAlias)
dbGotop()

Return Nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTelaTV    บAutor  ณStanko              บ Data ณ  29/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function TelaTV()

Local aButtons := {}
Local aObjects := {}
Local aPosObj  := {}
Local aSize		:= MsAdvSize()
Local aInfo		:= {aSize[1], aSize[2], aSize[3], aSize[4], 1, 2}

nRecTV := 1
GeraArq()          
          
aAdd( aObjects, {   100, 100, .t., .f. } )
aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

nPos1 := aPosObj[1,1]
nPos2 := aPosObj[1,2]
nPos3 := aPosObj[1,3]*4
nPos4 := aPosObj[1,4]


DEFINE MSDIALOG oDlgTV TITLE "Monitor Expedi็ใo" FROM aSize[7],0 TO aSize[6], aSize[5] OF oMainWnd PIXEL
	
	                

If MV_PAR10 > 0                              
	nTimeOut := 20 * MV_PAR10
	oTimer:= TTimer():New(nTimeOut,{|| AtuTela() },oDlgTV) // Ativa timer
	oTimer:Activate()
EndIf		
	
oDlgTV:lMaximized := .T.
oTelaTv:=TiBrowser():New(nPos1,nPos2,nPos4,nPos3,'',oDlgTV)
oTelaTv:Navigate(cURL)
	
ACTIVATE MSDIALOG oDlgTV CENTERED ON INIT ( EnchoiceBar(oDlgTV,{|| oDlgTV:End()},{|| oDlgTV:End()}) )


Return Nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraArq   บAutor  ณStanko              บ Data ณ  29/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GeraArq()
Local lMuda := .F.
Local cHtml := ""
                 

cHtml += "<style type='text/css'>"
cHtml += ".TAMANHO {"
cHtml += "	font-size: 80px;"
cHtml += "}"
cHtml += "</style>"

cHtml += "<style type='text/css'>"
cHtml += ".TAMANHO2 {"
cHtml += "	font-size: 70px;"       
cHtml += "	font-weight: bold; "
cHtml += "}"
cHtml += "</style>"


cHtml += "<style type='text/css'>"
cHtml += ".TAMANHO3 {"
cHtml += "	font-size: 120px;"
cHtml += "}"
cHtml += "</style>"


cHtml += "<style type='text/css'>"
cHtml += ".TAMANHO4 {"
cHtml += "	font-size: 70px;"       
cHtml += "	font-weight: bold; "
cHtml += "  text-align: right; "
cHtml += "}"
cHtml += "</style>"



cHtml += "<CENTER>" 

cHtml += "<font face='arial'>"

cHtml += "<TABLE BORDER=1>"
cHtml += "<TR>"           
cHtml += "<TD  style='color: rgb(255, 255, 255); background-color: #283371;'><H1 class='TAMANHO'>BLANK</H1></TD>"           
cHtml += "<TD  style='color: rgb(255, 255, 255); background-color: #283371;'><H1 class='TAMANHO'>PRODUTO</H1></TD>"
cHtml += "<TD  style='color: rgb(255, 255, 255); background-color: #283371;'><H1 class='TAMANHO'>&nbsp;LOTE&nbsp;</H1></TD>"
cHtml += "<TD  style='color: rgb(255, 255, 255); background-color: #283371;'><H1 class='TAMANHO'>INICIO</H1></TD>"
cHtml += "<TD  style='color: rgb(255, 255, 255); background-color: #283371;'><H1 class='TAMANHO'>ATUAL</H1></TD>"
cHtml += "<TD  style='color: rgb(255, 255, 255); background-color: #283371;'><H1 class='TAMANHO'></H1></TD>"
cHtml += "</TR>"            

dbSelectArea("TRB")
dbSetOrder(2)

If nRecTV == 1 
	dbGotop()    
EndIf

nQtd := 1
While !EOF()                            

	If AllTrim(TRB->BLANK) == "PITM034"
  //		MsgAlert("Para1!")
	ENDiF	
            
	If TRB->DIASATUAL >= 7
		dbSkip()
	EndIf	 
	
         
	           
	If nRecTV > MV_PAR11  .OR. TRB->(EOF())   
		lAbreQry := .T.
		nRecTV := 1
		Exit
	EndIf
		
	If nQtd > 7
		Exit
	EndIf
		

	cAuxB := Substr(TRB->BLANK,3,Len(TRB->BLANK)-2)
    cAuxP := TRB->PRODUTO
	cAuxL := Transform(TRB->LOTEPRD,"@E 999,999")
	cAuxI := Transform(TRB->DIASINIC,"@E 99.99")
	cAuxA := Transform(TRB->DIASATUAL,"@E 99.99")   
	cAuxC := "&nbsp;&nbsp;&nbsp;&nbsp;"
        
	If TRB->DIASATUAL > 3                           
		cCor1 := "#00FF00"     //VERDE
		cCor2 := "color: rgb(51, 204, 0)"     //VERDE
	ElseIf TRB->DIASATUAL <= 1
		cCor1 := "#FF0000" //VERMELHO
		cCor2 := "color: rgb(204, 0, 0)" //VERMELHO
	ElseIf TRB->DIASATUAL <= 3                     
		cCor1 := "#FFFF00" //AMARELO
		cCor2 := "color: rgb(255, 204, 0)" //AMARELO
	EndIf
            

	If lMuda

		cHtml += "<TR>"           
		cHtml += "<TD class='TAMANHO2' style='background-color: rgb(204, 204, 204); color: rgb(0, 0, 0);'>"+cAuxB+"</TD>"           
		cHtml += "<TD class='TAMANHO2' style='background-color: rgb(204, 204, 204); color: rgb(0, 0, 0);'>"+cAuxP+"</TD>"           
		cHtml += "<TD class='TAMANHO4' style='background-color: rgb(204, 204, 204); color: rgb(0, 0, 0);'>"+cAuxL+"</TD>"           
		cHtml += "<TD class='TAMANHO4' style='background-color: rgb(204, 204, 204); color: rgb(0, 0, 0);'>"+cAuxI+"</TD>"           
		cHtml += "<TD class='TAMANHO4' style='background-color: rgb(204, 204, 204); color: rgb(0, 0, 0);'>"+cAuxA+"</TD>"           
		cHtml += "<TD bgcolor="+cCor1+"><H1>"+cAuxC+"</H1></TD>"           
		cHtml += "</TR>"            
		lMuda := .F.
	Else                     
	
	
	
		cHtml += "<TR>"           
		cHtml += "<TD class='TAMANHO2'>"+cAuxB+"</TD>"           
		cHtml += "<TD class='TAMANHO2'>"+cAuxP+"</TD>"           
		cHtml += "<TD class='TAMANHO4'>"+cAuxL+"</TD>"           
		cHtml += "<TD class='TAMANHO4'>"+cAuxI+"</TD>"           
		cHtml += "<TD class='TAMANHO4'>"+cAuxA+"</TD>"  
		cHtml += "<TD bgcolor="+cCor1+"><H1>"+cAuxC+"</H1></TD>"           
		cHtml += "</TR>"            
		lMuda := .T.
	EndIf	
		
	                                   
	
	

/*	@ nLin, nCol5 Say cAuxA   Size 200, 030  PIXEL FONT oFontL OF oDlgTV
	If TRB->DIASATUAL > 3
		@ nLin, nCol5+70 Say "*"   Size 200, 030  PIXEL FONT oFontA  COLOR CLR_GREEN OF oDlgTV

	ElseIf TRB->DIASATUAL <= 1
		@ nLin, nCol5+70 Say "*"   Size 200, 030  PIXEL FONT oFontA  COLOR CLR_RED OF oDlgTV

	ElseIf TRB->DIASATUAL <= 3
		@ nLin, nCol5+70 Say "*"   Size 200, 030  PIXEL FONT oFontA  COLOR CLR_YELLOW OF oDlgTV
	EndIf
*/	
		

	

	nQtd++ 
	nRecTV++
	
	dbSkip()   

	If AllTrim(TRB->BLANK) == "PITM034"
//		MsgAlert("Para2!")
	ENDiF	
	
	If EOF() 
		nRecTV := 1
	EndIf	
	
EndDo          
cHtml += "</TABLE>"


MemoWrite(cUrl,cHTML)

Return .T.







/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuTela   บAutor  ณStanko              บ Data ณ  29/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AtuTela()

If lAbreQry          
	TRB->(dbCloseArea())
	ProcRot()         
	lAbreQry := .F.
EndIf	

GeraArq()          
        

oTelaTv:Navigate(cURL)
oTelaTV:Refresh()

//MsgALert("Passou")

Return Nil 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSx1 บAutor  ณStanko              บ Data ณ  29/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AjustaSx1(cPerg)
Local aRegs 	:= {}

aAdd(aRegs,{cPerg,"01","Produto De?"    ,"","","mv_ch1","C",30,00,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"02","Produto Ate?"   ,"","","mv_ch2","C",30,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"03","Blank De?"    ,"","","mv_ch3","C",30,00,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"04","Blank Ate?"   ,"","","mv_ch4","C",30,00,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
aAdd(aRegs,{cPerg,"05","Armazem De?"  ,"","","mv_ch5","C",02,00,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Armazem Ate?" ,"","","mv_ch6","C",02,00,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Entrega De?"  ,"","","mv_ch7","D",08,00,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Entrega Ate?" ,"","","mv_ch8","D",08,00,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09","% Acresc. Prod.?" ,"","","mv_ch9","N",6,02,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","Segundos Refresh?" ,"","","mv_cha","N",6,02,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","Maximo Produtos?" ,"","","mv_chb","N",6,02,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"12","Classe De?" ,"","","mv_chc","C",2,00,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"13","Classe Ate?" ,"","","mv_chd","C",2,00,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","",""})
ValidPerg(aRegs,cPerg,.F.)

Return Nil

