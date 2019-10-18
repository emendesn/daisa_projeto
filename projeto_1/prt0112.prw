#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPRT0112	บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Tela de expedicao de pedidos                       		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PRT0112()

Local alCores := { { "C9_BLEST =='02' .AND. C9_EXPFLAG == '  ' .AND. C9_BLCRED = '  ' ", "BR_LARANJA"   },;
                   { "!Empty(C9_NFISCAL)",                                                "BR_PRETO"    },;// ITEM JA FATURADO
                   { "C9_EXPFLAG == '  '",                                                "BR_PINK"     },;	// ITEM AGUARDANDO COMPOSICAO
                   { "C9_BLEST $ 'XX/02' .AND. C9_EXPFLAG == '01'",                       "BR_AZUL"     },;	// ITEM COMPOSTO VOLUME
                   { "C9_BLEST $ 'XX/02' .AND. C9_EXPFLAG $ '02'",                        "BR_AMARELO"  },;	// ITEM GERADO ETIQUETA
                   { "C9_EXPFLAG == '03' .AND. C9_BLEST <> 'XX'",                         "ENABLE"      }} // ITEM LIBERADO PARA FATURAR
//                   { "(C9_BLCRED =='10' .And. C9_BLEST  == '10')" + ;
//                     ".OR. C9_BLCRED =='ZZ' .And. C9_BLEST  == 'ZZ'",                   "BR_PRETO"    },;	// ITEM JA FATURADO*/

Private cCadastro	:= "Expedi็ใo de Itens do Pedido de Vendas"
Private aRotina 	:= MenuDef()
Private aHeader	:= {}
Private aCols		:= {}
Private cpItemPV	:= ""
Private npVolLib	:= 0

Private opFont1		:= TFont():New("Arial",,20,.T.,.T.,,,,.F.,)
Private opFont2		:= TFont():New("Arial",,20,.T.,.F.,,,,.F.,)
Private opFont3		:= TFont():New("Arial",,15,.T.,.T.,,,,.F.,)

DBSelectArea("SC9")
SC9->(DbGoTop())
Set Filter to &("(((C9_EXPFLAG $ '01/02/03'.and. C9_BLEST $ 'XX/02/  ' .AND. C9_BLINF <> '2' ) .OR. C9_BLEST $ 'XX/02/10' ).AND. !(!SC9->C9_BLCRED=='  '.And. SC9->C9_BLCRED <> '09'.And. SC9->C9_BLCRED <> '10'.And. SC9->C9_BLCRED <> 'ZZ')			)")
mBrowse(6,1,22,75,"SC9",,,,,,alCores)

Return (Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMenuDef	บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que cria o menu                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function MenuDef()
Local alRet	:= { { "Pesquisar",          "AxPesqui"	,     0, 1, 0, .F.},;
                 { "Visualizar",         "U_ADCAD001(2)", 0, 2, 0, nil},;
                 { "Compor Volumes",     "U_ADCAD001(3)", 0, 3, 0, nil},;
                 { "Estornar",           "U_ADCAD001(5)", 0, 5, 0, nil},;
                 { "Legenda",            "U_ADLEG001",    0, 6, 0, .F.},;
                 { "Liberar P/ Faturar", "U_ADCAD001(7)", 0, 7, 0, .F.}}
Return (alRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMenuDef	บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que cria a legenda                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function ADLEG001()
Local aLegenda:= { {"BR_LARANJA", "Aguardando Lib. Estoque"},;
                   {"BR_PINK",    "Aguardando Composi็ใo"},;
                   {"BR_AZUL",    "Composto Volume"},;
                   {"BR_AMARELO", "Gerado Etiqueta"},;
                   {"ENABLE",     "Liberado para faturar"},;
                   {"DISABLE",    "Em Processo de Faturamento"},;
                   {"BR_PRETO",   "Item jแ Faturado"}}

   BrwLegenda(cCadastro, "Legenda",aLegenda)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMenuDef	บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que cria a tela de separacao                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function ADCAD001(nlOpc)

Local olDlg 	:= Nil
Local nOpcNewGD := Iif(nlOpc == 2 .OR. nlOpc == 5 .OR. nlOpc == 7,1  ,GD_INSERT + GD_UPDATE + GD_DELETE)
Local alAlter	:= Iif(nlOpc == 2 .OR. nlOpc == 5 .OR. nlOpc == 7,{} ,{"QTDPECA","VOLUME"})
Local nlI		:= 1
Local nlLinBtn	:= 015//080

//Variaveis que ira buscar no cadastro do Pedido de Vendas
Local clFilial		:= SC9->C9_FILIAL
Local clNumPed		:= SC9->C9_PEDIDO
Local clItemPV		:= SC9->C9_ITEM
Local clNomeCli	:= Alltrim(Posicione("SA1",1,xFilial("SA1")+SC9->C9_CLIENTE+SC9->C9_LOJA,"A1_NOME"))
Local dlDataEmis	:= ""
Local clObs			:= ""
Local cCondPag      := ""
Local dlDataPrazo	:= ""
Local clNotaFiscal	:= ""
Local dlEntrega		:= ""

Local alButtons	:= {}

If nlOpc == 7
	aAdd(alButtons,{"Liberar p/ Faturar"	,{|| /*LibFat()*/Iif(U_BtnClick("03",clFilial+clNumPed),olDlg:End(),.F.)	}})
ElseIf nlOpc == 5
	aAdd(alButtons,{"Estornar"				,{|| Iif(U_BtnClick("  ",clFilial+clNumPed),olDlg:End(),.F.)	}})
Else
	aAdd(alButtons,{"Compor Volumes"		,{|| Iif(ComporVol(clFilial,clNumPed),olDlg:End(),.F.)			}})
	aAdd(alButtons,{"Gerar Etiqueta"		,{|| Iif(GeraEtiqueta(clFilial,clNumPed),olDlg:End(),.F.)		}})
EndIf

aAdd(alButtons,{"Packing List"	,{|| MsgRun("Processando relat๓rio...","Aguarde",{ || U_PRT0090(clNumPed,clFilial)} ) }})
aAdd(alButtons,{"Espelho Pedido",{|| MsgRun("Processando relat๓rio...","Aguarde",{ || U_PRT0092(clNumPed,clFilial)} ) }})

Private npVol		:= 0
Private npPeso		:= 0
Private npPesoL		:= 0
Private lpFirst		:= .T.
Private apProd		:= {}
Private aObjects  	:= {}
Private aPosObj   	:= {}
Private lpExistVol	:= ExistVol(clFilial,clNumPed)

Private npPosItem 	:= 0
Private npPosDtLib	:= 0
Private npPosProd 	:= 0
Private npPosQL 	:= 0
Private npPosLote	:= 0
Private npPosB1QE 	:= 0
Private npPosPeca 	:= 0
Private npPosVol 	:= 0
Private npPosQE 	:= 0
Private npPosPeso	:= 0

	//Alimenta as variaveis com os dados do Pedido de Vendas
	DBSelectArea("SC5")
	SC5->(DbSetOrder(1))
	If SC5->(DBSeek(clFilial+clNumPed))
		dlDataEmis 	:= SC5->C5_EMISSAO
		clObs		:= Alltrim(SC5->C5_OBSERVP)
		
		// Condi็ใo de Pagamento
		cCondPagto  := AllTrim( SC5->C5_CONDPAG )
		DBSelectArea("SE4")
		SE4->( DBSetOrder(1) )
		If SE4->( DBSeek( xFilial("SE4") + SC5->C5_CONDPAG ) )
			cCondPagto += " - " + AllTrim( SE4->E4_DESCRI )
		EndIf
		
		// Prazo de Entrega
		DBSelectArea("SC6")
		SC6->(DbSetOrder(1))
		SC6->(DbGoTop())
		If SC6->(DBSeek(clFilial+clNumPed+clItemPV))
			dlDataPrazo	:= SC6->C6_ENTREG
		EndIf
	EndIf
	
	//Alimenta as variaveis com os dados do Faturamento
	DBSelectArea("SD2")
	SD2->(DbSetOrder(8))
	If SD2->(DBSeek(clFilial+clNumPed+clItemPV))
		clNotaFiscal 	:= SD2->D2_DOC+"-"+SD2->D2_SERIE
		dlEntrega		:= SD2->D2_EMISSAO
	EndIf
	
	If Select("SX2") == 0
		RpcSetType(3)
		RpcSetEnv("99","01",,,"FAT",GetEnvServer(),{"SB1"})
	EndIf
	
	If VldClick(nlOpc)
		GetHeader()
		GetProd(clFilial+clNumPed,nlOpc)
		If Len(apProd) > 0
			cpItemPV	:= apProd[1]
		EndIf
		
		olDlg := MSDialog():New(030,100,595,1085,"Expedi็ใo de Itens",,,,,,,,,.T.)
		
		/*CABECALHO DOS DADOS DO PEDIDO DE VENDA*/
		tSay():New(005,060,{||"Dados do Pedido"}                 ,    ,,opFont1,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		@ 015,005 To 077,400 Pixel of olDlg
		
		//Numero do Pedido
		tSay():New(020,009,{||"N๚mero:"}                 ,    ,,opFont3,,,,.T.,CLR_BLACK,CLR_WHITE,0,0)
		TGet():New(020,040,{|u| If(PCount()>0,clNumPed:=u,clNumPed)},olDlg,40,10,,,,,opFont3,,,.T.,,,{|| .F.},,,,.T.,,,("clNumPed"))
		
		//Nome do Cliente
		tSay():New(020,090,{||"Cliente:"}                 ,    ,,opFont3,,,,.T.,CLR_BLACK,CLR_WHITE,0,0)
		TGet():New(020,120,{|u| If(PCount()>0,clNomeCli:=u,clNomeCli)},olDlg,140,10,,,,,opFont3,,,.T.,,,{|| .F.},,,,.T.,,,("clNomeCli"))
		
		//Data Prazo
		tSay():New(020,270,{||"Prazo:"}                 ,    ,,opFont3,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		TGet():New(020,310,{|u| If(PCount()>0,dlDataPrazo:=u,dlDataPrazo)},olDlg,040,10,,,,,opFont3,,,.T.,,,{|| .F.},,,,.T.,,,("dlDataPrazo"))
		
		//Data Emissao
		tSay():New(035,270,{||"Emissใo:"}                 ,    ,,opFont3,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		TGet():New(035,310,{|u| If(PCount()>0,dlDataEmis:=u,dlDataEmis)},olDlg,040,10,,,,,,,,.T.,,,{|| .F.},,,,.T.,,,("dlDataEmis"))
		
		//Observacao
		tSay():New(035,009,{||"Obs:"}                 ,    ,,opFont3,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		oMemo := tMultiGet():New( 035, 040, {|u| If(PCount()>0, clObs:=u, clObs)}, olDlg, 220, 038,,,,,, .T.,,,,,, .F. )		
		
		//Cond. Pagamento
		tSay():New(050,270,{||"Cond. Pagto:"}           ,    ,,opFont3,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		TGet():New(050,310,{|u| If(PCount()>0,cCondPagto:=u,cCondPagto)},olDlg,040,10,,,,,,,,.T.,,,{|| .F.},,,,.T.,,,("cCondPagto"))
		
		
		/*CABECALHO DOS DADOS DO FATURAMENTO*/
		tSay():New(060,060,{||"Faturamento"}                 ,    ,,opFont1,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		//	@ 070,005 To 095,350 Pixel of olDlg
		
		//Volume
		tSay():New(082,009,{||"Volume:"}                 ,    ,,opFont2,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		opGetVol	:= TGet():New(080,051,{|u| If(PCount()>0,npVol:=u,npVol)},olDlg,035,10,,,,,,,,.T.,,,{|| .F.},,,,.T.,,,("npVol"))
		
		
		//Peso BRUTO
		tSay():New(082,090,{||"PesoB:"}                 ,    ,,opFont2,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		opGetPeso	:= TGet():New(080,120,{|u| If(PCount()>0,npPeso:=u,npPeso)},olDlg,040,10,"@E 999999.9999",,,,,,,.T.,,,{|| .T.},,,,Iif(nlOpc ==  7,.F.,.T.),,,("npPeso"))
		
		//peso liquido
		tSay():New(082,170,{||"PesoL:"}                 ,    ,,opFont2,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		opGetPeso	:= TGet():New(080,205,{|u| If(PCount()>0,npPesoL:=u,npPesoL)},olDlg,040,10,"@E 999999.9999",,,,,,,.T.,,,{|| .T.},,,,Iif(nlOpc ==  7,.F.,.T.),,,("npPesoL"))
		
		
		//Nota Fiscal
		tSay():New(082,260,{||"Nota:"}                 ,    ,,opFont2,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		TGet():New(080,295,{|u| If(PCount()>0,clNotaFiscal:=u,clNotaFiscal)},olDlg,050,10,,,,,,,,.T.,,,{|| .F.},,,,.T.,,,("clNotaFiscal"))
		
		//Data de Entrega
		tSay():New(082,360,{||"Entrega:"}                 ,    ,,opFont2,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		TGet():New(080,400,{|u| If(PCount()>0,dlEntrega:=u,dlEntrega)},olDlg,040,10,,,,,,,,.T.,,,{|| .F.},,,,.T.,,,("dlEntrega"))
		
		
		
		
		
		
		//Produto
		
		tSay():New(100,009,{||"Produto(s):"}                 ,    ,,opFont2,,,,.T.,CLR_BLACK,CLR_WHITE,250,250)
		opCombo := TComboBox():New(100,050,bSETGET(cpItemPV),apProd,240,8,olDlg,,,{|| Iif(nlOpc == 2 .OR. nlOpc == 5 .OR. nlOpc == 7,.T.,ChangeBox(clFilial,clNumPed))},,,.T.,,,,)
		
		/*CRIACAO DOS BOTOES*/
		For nlI := 1 To Len(alButtons)
			If ValType(alButtons[nlI]) == "A"
				&("opBtn"+Alltrim(Str(nlI))) := tButton():New(nlLinBtn,410,alButtons[nlI,1],olDlg,alButtons[nlI,2],080,15,,,,.T.)
				If (nlOpc == 2) .AND. nlI == 1
					&("opBtn"+Alltrim(Str(nlI))):LREADONLY := .T.
				EndIf
				nlLinBtn += 16
			EndIf
		Next nlI
		
		opGet 	:=	MsNewGetDados():New(120,005,275,490 ,nOpcNewGD,/*"U_VldLinha()"*/,/*"AllWaysTrue()"*/,,alAlter,,Iif(nlOpc == 2 .OR. nlOpc == 5 .OR. nlOpc == 7,Len(aCols),9999),/*"AllWaysTrue()"*/,,"U_WhenDelete(0)",olDlg,aHeader,aCols)
		opGet:bChange := {|| GetCols(clFilial,clNumPed)}
		olDlg:Activate(,,,.T.,,,)
	EndIf
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldClick  บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que valida o click do usuario                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function VldClick(nlOpc)

Local llRet := .T.
Local clMsg	:= ""

	If nlOpc == 2
		llRet := .T.
	ElseIf !Empty(SC9->C9_NFISCAL)//(SC9->C9_BLCRED == "10" .And. SC9->C9_BLEST  == "10") .Or. SC9->C9_BLCRED == "ZZ" .And. SC9->C9_BLEST  == "ZZ"
		clMsg := "Pedido ja Faturado, apenas conseguirแ visualizar caso queira emitir relat๓rios."
	ElseIf SC9->C9_EXPFLAG $ "  "		   						//Se o pedido esta aguardando composicao
		If nlOpc <> 3
			clMsg := "Pedido deverแ ser composto antes."
		EndIf
	ElseIf nlOpc == 5
		llRet := .T.
	ElseIf SC9->C9_EXPFLAG $ "01"		   						//Se o pedido ja foi composto, so pode haver alteracao e gerar etiqueta
		If nlOpc == 7
			clMsg := "Para liberar p/ faturar, primeiramente deverแ gerar etiqueta."
		EndIf
	ElseIf SC9->C9_EXPFLAG $ "03" 								//Se o pedido foi liberado para faturar, so podera visualizar ou estornar
		If nlOpc <> 2 .AND. nlOpc <> 5
			If SC9->C9_BLEST <> 'XX'
				clMsg := "Pedido ja foi Liberado p/ faturar, apenas poderแ visualizแ-lo ou estornแ-lo"
			EndIf
		EndIf
	EndIf
	
	If !Empty(clMsg)
		llRet := .F.
		MsgStop(clMsg)
	EndIf
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLinhaOK   บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que verifica se a linha ja foi preenchida           บฑฑ
ฑฑบDescricao ณ completamente.                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function LinhaOK(nLin)

Local llRet := .T.
Local nlI

	For nlI := 1 To Len(aHeader)
		If Empty(opGet:aCols[nLin,nlI]) .AND. nlI <> npPosLote .AND. nlI <> npPosPeso .AND. nlI <> npPosB1QE
			llRet := .F.
			Exit
		EndIf
	Next nlI
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณChangeBox บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ No momento que muda o cursor do combo box.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ChangeBox(clFilial,clNumPed)

Local nlQtdPeca := RetQtdPeca(1)
Local nlPos		:= aScan(opGet:aCols,{|aX| aX[1] == cpItemPV})
Local clMsg		:= ""
Local llRet		:= .T.

	SC9->(DbSetOrder(1))
	
	If nlPos <> 0
		If  nlQtdPeca >= opGet:aCols[nlPos,npPosQL] .AND. opCombo:LMODIFIED
			clMsg := "A quantidade de pe็as deste produto jแ foi totalmente distribuida!"
		EndIf
	EndIf
	If Empty(clMsg)
		If !LinhaOK(opGet:nAt)
			If SC9->(DBSeek(clFilial+clNumPed+cpItemPv))
				If SB1->(DBSeek(xFilial("SB1")+SC9->C9_PRODUTO+SC9->C9_LOCAL))
					
					opGet:aCols[opGet:nAt,npPosItem] 		:= Iif(Empty(cpItemPv),SC9->C9_ITEM,cpItemPV)
					opGet:aCols[opGet:nAt,npPosDtLib]		:= SC9->C9_DATALIB
					opGet:aCols[opGet:nAt,npPosProd] 		:= Alltrim(SB1->B1_DESCOMP)//SC9->C9_PRODUTO+"-"+Posicione("SB1",1,xFilial("SB1")+SC9->C9_PRODUTO+SC9->C9_LOCAL,"B1_DESC")
					opGet:aCols[opGet:nAt,npPosLote] 		:= SC9->C9_LOTECTL//space(15)
					opGet:aCols[opGet:nAt,npPosQL] 			:= SC9->C9_QTDLIB
					opGet:aCols[opGet:nAt,npPosB1QE]		:= SB1->B1_QE
					opGet:aCols[opGet:nAt,npPosPeca] 		:= Iif(RetQtdProd()<=1,0,SC9->C9_QTDLIB-RetQtdPeca())
					opGet:aCols[opGet:nAt,npPosVol] 		:= 0
					opGet:aCols[opGet:nAt,npPosQE]			:= Iif(SB1->B1_QE == 0, 1,Round(SC9->C9_QTDLIB/SB1->B1_QE,0))
					opGet:aCols[opGet:nAt,npPosPeso]		:= SB1->B1_PESO
					opGet:aCols[opGet:nAt,Len(aHeader)+1]	:= .F.
					opGet:Refresh()
				EndIf
			EndIf
		EndIf
	EndIf
	If !Empty(clMsg)
		MsgStop(clMsg)
	EndIf
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldLinha  บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Valida a linha que acabou de ser digitada do aCols.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function VldLinha()

Local clMsg := ""
Local llRet := .T.
Local nlPos	:= aScan(opGet:aCols,{|aX| aX[1] == cpItemPV})

	If !opGet:aCols[opGet:nAt,Len(aHeader)+1]
		If Empty(opGet:aCols[opGet:nAt,npPosPeca]) .OR.; //Empty(opGet:aCols[opGet:nAt,npPosLote]) .OR.;
			Empty(opGet:aCols[opGet:nAt,npPosVol])
			clMsg := "Favor preencher todos os campos!"
		Else
			/*
			If nlPos > 0
			If opGet:aCols[nlPos,npPosQL]-RetQtdPeca(1) == 0
			clMsg := "Esse produto nใo possui mais saldo!"
			EndIf
			EndIf
			If Empty(clMsg)*/
				clMsg := VldCols()
				//EndIf
			EndIf
			
			If !Empty(clMsg)
				llRet := .F.
				MsgStop(clMsg)
			EndIf
		EndIf
		
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCols   บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Valida os dados da aCols.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function VldCols(nlFlag)

Local clRet 	:= ""
Local nlI		:= 1
Local nlPos		:= 0
Local alProdAux	:= {}
Local llOk		:= .F.
Local nlReg		:= 0

Default nlFlag := 0

	For nlI := 1 To Len(opGet:aCols)
		If !opGet:aCols[nlI,Len(aHeader)+1]
			nlReg++
			If opGet:aCols[nlI,npPosPeca] <= 0
				clRet := "O item "+opGet:aCols[nlI,npPosItem]+" nใo possui quantidade de pe็as preenchida!"
				Exit
			ElseIf opGet:aCols[nlI,npPosVol] == 0
				clRet := "O item "+opGet:aCols[nlI,npPosItem]+" nใo possui o volume preenchido!"
				Exit
				
			Else
				nlPos := aScan(alProdAux,{|aX| aX[1] == opGet:aCols[nlI,npPosItem] .AND. aX[2] == opGet:aCols[nlI,npPosLote] .AND. aX[3] == Alltrim(Str(opGet:aCols[nlI,npPosVol]))})
				
				If nlPos == 0
					nlPos := aScan(alProdAux,{|aX| aX[1] == opGet:aCols[nlI,npPosItem]})
					If nlPos == 0
						aAdd(alProdAux,{ opGet:aCols[nlI,npPosItem], opGet:aCols[nlI,npPosLote],Alltrim(Str(opGet:aCols[nlI,npPosVol])),opGet:aCols[nlI,npPosQL], opGet:aCols[nlI,npPosPeca]})
					Else
						alProdAux[nlPos,5] += opGet:aCols[nlI,npPosPeca]
					EndIf
				Else
					clRet := "O item "+opGet:aCols[nlI,npPosItem]+" hแ duplicidade de lote e volume!"
					Exit
				EndIf
			EndIf
		EndIf
	Next nlI
	
	If nlFlag == 1 .AND. Empty(clRet)
		If Len(apProd) <> Len(alProdAux)
			//clRet := "Todos os itens do pedido deverใo ser composto seus volumes"
			If MsgNoYes("Nใo foram compostos todos os itens do Pedido de Vendas. Deseja continuar composi็ใo?")
				clRet := "Sim"
			Else
				clRet := "Nao"
			EndIf
			
		EndIf
		For nlI := 1 To Len(alProdAux)
			If alProdAux[nlI,4] <> alProdAux[nlI,5]
				clRet := "O item "+alProdAux[nlI,1]+" possui "+Transform(alProdAux[nlI,5],"@E 999,999,999.00")+ " pe็as e nใo pode ser diferente da quantidade liberada de "+Transform(alProdAux[nlI,4],"@E 999,999,999.00")+" !"
				Exit
			EndIf
		Next nlI
		
		If nlReg == 0
			clRet := "Nใo hแ registros para compor volume!"
		EndIf
	EndIf
	
Return (clRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExistVol  บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Verifica a existencia de volumes.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ExistVol(clFilial,clNumPed)

Local llRet := .F.
Local clQry

	clQry := "SELECT * FROM "+RetSqlName("SZD")+" SZD"
	clQry += " WHERE D_E_L_E_T_ = ''"
	clQry += " AND ZD_FILIAL = '"+clFilial+"'"
	clQry += " AND ZD_PEDIDO = '"+clNumPed+"'"
	
	If Select("RETVOL") > 0
		RETVOL->(DbCloseArea())
	EndIf
	
	TcQuery clQry New Alias "RETVOL"
	
	llRet := RETVOL->(!EoF())
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCols   บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Alimenta o aCols.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function GetCols(clFilial,clNumPed)

Local llRet 	:= .T.
Local nlLen	 	:= Len(opGet:aCols)
Local clItemPV 	:= ""
Local nlTotVols	:= 0
Local nlVolAux	:= 0
Local alVols	:= {}
Local nlPosVol	:= 0
Local llExistVol:= .F.

	If Empty(opGet:aCols[opGet:nAt,1])
		SC9->(DbSetOrder(1))
		SB1->(DbSetOrder(1))
		
		SZD->(DbSetOrder(1))
		//Enquanto houver item liberado
		For nlI := 1 To Len(apProd)
			If lpExistVol
				clItemPV := SubStr(apProd[nlI],1,Len(SC9->C9_ITEM))
			Else
				clItemPV := cpItemPV
			EndIf
			//Posiciona no Item
			If SC9->(DBSeek(clFilial+clNumPed+clItemPV))
				//Posiciona no produto
				If SB1->(DBSeek(xFilial("SB1")+SC9->C9_PRODUTO+SC9->C9_LOCAL))
					//Caso ache o volume desse item
					If SZD->(DBSeek(clFilial+clNumPed+SC9->C9_ITEM)) .AND. lpFirst
						llExistVol := .T.
						//Enquanto houver volumes esse item
						While SZD->(!EoF()) .AND.  SZD->ZD_FILIAL+SZD->ZD_PEDIDO+SZD->ZD_ITEMPV == clFilial+clNumPed+SC9->C9_ITEM
							
							nlLen	 := Len(opGet:aCols)
							
							opGet:aCols[nlLen,npPosItem] 		:= SZD->ZD_ITEMPV
							opGet:aCols[nlLen,npPosDtLib]		:= SC9->C9_DATALIB
							opGet:aCols[nlLen,npPosProd] 		:= Alltrim(SB1->B1_DESCOMP)//SC9->C9_PRODUTO+"-"+SB1->B1_DESC
							opGet:aCols[nlLen,npPosLote] 		:= SZD->ZD_LOTE
							opGet:aCols[nlLen,npPosQL] 		:= SC9->C9_QTDLIB
							opGet:aCols[nlLen,npPosB1QE]		:= SB1->B1_QE
							opGet:aCols[nlLen,npPosQE]			:= Iif(SB1->B1_QE == 0, 1,Round(SC9->C9_QTDLIB/SB1->B1_QE,0))
							opGet:aCols[nlLen,npPosPeso]		:= SB1->B1_PESO
							opGet:aCols[nlLen,npPosPeca] 		:= SZD->ZD_QTDVOL
							opGet:aCols[nlLen,npPosVol] 		:= SZD->ZD_VOLUME
							opGet:aCols[nlLen,Len(aHeader)+1] := .F.
							//npPeso	 += SB1->B1_PESO
							nlPosVol := aScan(alVols,{|aX| aX == SZD->ZD_VOLUME })
							If nlPosVol == 0
								aAdd(alVols,SZD->ZD_VOLUME)
								nlTotVols++
							EndIf
							aAdd(opGet:aCols,Array(Len(aHeader)+1))
							SZD->(DbSkip())
						EndDo
						If nlI == Len(apProd)
							SC5->(DbSetOrder(1))
							If SC5->(DBSeek(clFilial+clNumPed))
								npPeso := SC5->C5_PBRUTO
								npPesoL := SC5->C5_PESOL
							EndIf
							aSize(opGet:aCols,Len(opGet:aCols)-1)
							lpFirst := .F.
							npVol 	:= nlTotVols
							opGetVol:Refresh()
						EndIf
						
					ElseIf !lpExistVol
						opGet:aCols[nlLen,npPosItem] 		:= Iif(Empty(cpItemPv),SC9->C9_ITEM,cpItemPV)
						opGet:aCols[nlLen,npPosDtLib]		:= SC9->C9_DATALIB
						opGet:aCols[nlLen,npPosProd] 		:= Alltrim(SB1->B1_DESCOMP)//SC9->C9_PRODUTO+"-"+SB1->B1_DESC
						opGet:aCols[nlLen,npPosLote] 		:= SC9->C9_LOTECTL//space(15)
						opGet:aCols[nlLen,npPosQL] 		:= SC9->C9_QTDLIB
						opGet:aCols[nlLen,npPosB1QE]		:= SB1->B1_QE
						opGet:aCols[nlLen,npPosPeca] 		:= Iif(RetQtdProd()<=1,0,SC9->C9_QTDLIB-RetQtdPeca())
						opGet:aCols[nlLen,npPosVol] 		:= 0
						opGet:aCols[nlLen,npPosQE]			:= Iif(SB1->B1_QE == 0, 1,Round(SC9->C9_QTDLIB/SB1->B1_QE,0))
						opGet:aCols[nlLen,npPosPeso]		:= SB1->B1_PESO
						opGet:aCols[nlLen,Len(aHeader)+1]:= .F.
						
						npPeso += SB1->B1_PESO
						//opGet:Refresh()
						Exit
					EndIf
				EndIf
			EndIf
		Next nlI
		If ValType(opGet:aCols[Len(opGet:aCols),1]) == "U"
			SC5->(DbSetOrder(1))
			If SC5->(DBSeek(clFilial+clNumPed))
				npPeso := SC5->C5_PBRUTO
				npPesoL := SC5->C5_PESOL
				
			EndIf
			aSize(opGet:aCols,Len(opGet:aCols)-1)
			lpFirst := .F.
			npVol 	:= nlTotVols
			opGetVol:Refresh()
		EndIf
		
		opGet:Refresh()
		lpExistVol := .F.
		opGetPeso:Refresh()
	EndIf
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCols   บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Valida e Calcula a quantidade de pecas que o produto       บฑฑ
ฑฑบDescricao ณ corrente ja possui.                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CalcPeca()

Local llRet 	:= .T.
Local nlQtdPeca	:= 0
Local clMsg		:= ""
Local llOk		:= .F.

	If M->QTDPECA <= 0
		clMsg := "Digite uma quantidade superior เ zero!"
	ElseIf	M->QTDPECA > opGet:aCols[opGet:nAt,npPosQL]
		clMsg := "A quantidade de pe็as nใo pode ser superior a quantidade liberada!"
	Else
		nlQtdPeca := RetQtdPeca()
		
		If	(M->QTDPECA + nlQtdPeca) >  opGet:aCols[opGet:nAt,npPosQL]
			clMsg := "A quantidade de pe็as nใo pode ser superior a quantidade liberada deste item, possui saldo de: "+Transform(opGet:aCols[opGet:nAt,npPosQL]-nlQtdPeca,"@E 999,999,999.00")+"!"
		EndIf
	EndIf
	
	If !Empty(clMsg)
		llRet := .F.
		MsgStop(clMsg)
	EndIf
	
Return (llRet)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldVol    บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Valida o volume digitado.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function VldVol()

Local nlI 		:= 1
Local llRet 	:= .T.
Local clMsg 	:= ""
Local nlTotVols	:= 0
Local nlVolAux	:= 0
Local alVols	:= {}
Local nlPosVol	:= 0

	If M->VOLUME <= 0
		clMsg := "Digite uma quantidade superior เ zero!"
	Else
		For nlI := 1 To Len(opGet:aCols)
			If !opGet:aCols[nlI,Len(aHeader)+1]
				If nlI <> opGet:nAt
					If M->VOLUME == opGet:aCols[nlI,npPosVol]
						nlTotVols++
						If nlTotVols == 5
							clMsg := "Jแ existem 5 itens preenchidos nesse volume!"
							Exit
						EndIf
					EndIf
					If opGet:aCols[nlI,npPosItem]+opGet:aCols[nlI,npPosLote]+Alltrim(Str(opGet:aCols[nlI,npPosVol])) == ;
						opGet:aCols[opGet:nAt,npPosItem]+opGet:aCols[opGet:nAt,npPosLote]+Alltrim(Str(M->VOLUME))
						clMsg := "Jแ existe um item preenchido com esse lote nesse volume!"
						Exit
					EndIf
					nlVolAux := opGet:aCols[nlI,npPosVol]
				Else
					nlVolAux := M->VOLUME
				EndIf
				
				nlPosVol := aScan(alVols,{|aX| aX == nlVolAux })
				If nlPosVol == 0
					aAdd(alVols,nlVolAux)
					//nlTotVols++
				EndIf
			EndIf
		Next nlI
		npVol := Len(alVols)//nlTotVols
		opGetVol:Refresh()
	EndIf
	
	If !Empty(clMsg)
		llRet := .F.
		MsgStop(clMsg)
	EndIf
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetQtdProdบ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna a quantidade de vezes que o produto foi inserido   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RetQtdProd()

Local nlRet := 0
Local nlI

	For nlI := 1 To Len(opGet:aCols)
		If !opGet:aCols[nlI,Len(aHeader)+1]
			If opGet:aCols[nlI,npPosItem] == opGet:aCols[opGet:nAt,npPosItem]
				nlRet++
			EndIf
		EndIf
	Next nlI
	
Return (nlRet)
	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetQtdProdบ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna a quantidade de pecas que ja foi inserida para o   บฑฑ
ฑฑบ          ณ produto corrente.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RetQtdPeca(nlFlag)

Local nlRet  := 0
Local nlI	 := 0
Local llOk	:= .T.
Local clItem := ""

Default nlFlag := 0

	For nlI := 1 To Len(opGet:aCols)
		If !opGet:aCols[nlI,Len(aHeader)+1]
			If nlFlag == 0 .AND. nlI == opGet:nAt
				llOk := .F.
			Else
				llOk := .T.
			EndIf
			If llOk
				If opGet:aCols[nlI,npPosItem] == Iif(nlFlag == 1,cpItemPV,opGet:aCols[opGet:nAt,npPosItem])
					nlRet +=  opGet:aCols[nlI,npPosPeca]
				EndIf
			EndIf
		EndIf
	Next nlI
	
Return (nlRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetProd   บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna os produtos que estใo liberados para compor volumesบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
Static Procedure GetProd(clKeySC9,nlOpc)

Local clFlag 	:= SC9->C9_EXPFLAG
Local clBlEst	:= SC9->C9_BLEST
Local llOK		:= .T.

	SB1->(DbSetOrder(1))
	SC9->(DbGoTop())
	SC9->(DbSetOrder(1))
	If SC9->(DBSeek(clKeySC9))
		While SC9->(!EoF()) .AND. SC9->C9_FILIAL+SC9->C9_PEDIDO == clKeySC9
			//Se nao bloqueou por credito
			If !(!SC9->C9_BLCRED=='  '.And. SC9->C9_BLCRED <> '09'.And. SC9->C9_BLCRED <> '10'.And. SC9->C9_BLCRED <> 'ZZ')
				If SC9->C9_BLEST $ "XX/02" .AND. nlOpc == 3 .AND. SC9->C9_EXPFLAG <> "03"
					llOk := .T.
				ElseIf SC9->C9_EXPFLAG == clFlag .AND. SC9->C9_BLEST == clBlEst
					llOk := .T.
				Else
					llOk := .F.
				EndIf
				If llOk//((SC9->C9_EXPFLAG $ "01/02/03" .OR. SC9->C9_BLEST == "XX" ).AND. SC9->C9_BLCRED <> "09" .AND. !(SC9->C9_BLEST $ "10/ZZ") )
					If SB1->(DBSeek(xFilial("SB1")+SC9->C9_PRODUTO+SC9->C9_LOCAL))
						aAdd(apProd,SC9->C9_ITEM+"="+Alltrim(SB1->B1_DESCOMP))//SC9->C9_PRODUTO+"-"+Posicione("SB1",1,xFilial("SB1")+SC9->C9_PRODUTO+SC9->C9_LOCAL,"B1_DESC"))
					EndIf
				EndIf
			EndIf
			SC9->(DbSkip())
		EndDo
	EndIf
	
Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetSumVol บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que retorna a soma das quantidade de volume         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
Static Function RetSumVol(clFil,clPed)

Local nlRet := 0
Local clQry

	clQry := "SELECT SUM(C9_QTDEMB) AS TOTVOL FROM "+RetSqlName("SC9") +" SC9"
	clQry += " WHERE SC9.D_E_L_E_T_ = ''"
	clQry += " AND SC9.C9_FILIAL = '"+clFil+"'"
	clQry += " AND SC9.C9_PEDIDO = '"+clPed+"'"
	
	If Select("XVOL") > 0
		XVOL->(DbCloseArea())
	EndIf
	
	TcQuery clQry New Alias "XVOL"
	
	If XVOL->(!EoF())
		nlRet := XVOL->TOTVOL
	EndIf
	
Return (nlRet)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณComporVol บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que compoe os volume por item do pedido de vendas e บฑฑ
ฑฑบ          ณ chama a funcao de gerar etiqueta.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
Static Function ComporVol(clFilial,clNumPed)

Local nlI 		:= 1
Local llRet 	:= .F.
Local nlPos		:= 0
Local alItemPV	:= {}
Local clMsg		:= VldCols(1)
Local alAreaSC9	:= SC9->(GetArea())
Local llOk		:= .T.

	If Empty(clMsg) .OR. clMsg == "Sim" .OR. clMsg == "Nao"
		If clMsg == "Sim"
			llOk := .T.
		ElseIf clMsg == "Nao"
			llOk := .F.
		ElseIf MsgNoYes("Deseja Compor Volumes?")
			llOk := .T.
		Else
			llOk := .F.
		EndIf
		
		If llOk
			SC9->(DbSetOrder(1))
			Begin Transaction
			
			For nlI := 1 To Len(apProd)
				If SC9->(DBSeek(clFilial+clNumPed+SubStr(apProd[nlI],1,Len(SC9->C9_ITEM))))
					U_DeleteVol(clFilial+clNumPed+SC9->C9_ITEM)
					If RecLock("SC9",.F.)
						SC9->C9_EXPFLAG := "  "
						SC9->(MsUnlock())
					EndIf
				EndIf
			Next nlI
			For nlI := 1 To Len(opGet:aCols)
				If !opGet:aCols[nlI,Len(aHeader)+1]
					If RecLock("SZD",.T.)
						SZD->ZD_FILIAL 	:= clFilial
						SZD->ZD_PEDIDO	:= clNumPed
						SZD->ZD_ITEMPV	:= opGet:aCols[nlI,npPosItem]
						SZD->ZD_LOTE	:= opGet:aCols[nlI,npPosLote]
						SZD->ZD_VOLUME	:= opGet:aCols[nlI,npPosVol]
						SZD->ZD_QTDVOL	:= opGet:aCols[nlI,npPosPeca]
						SZD->(MsUnLock())
						If SC9->(DBSeek(clFilial+clNumPed+opGet:aCols[nlI,npPosItem]))
							If RecLock("SC9",.F.)
								SC9->C9_BLEST	:= "XX"  // Processo de expedicao
								SC9->C9_EXPFLAG := "01"
								SC9->C9_QTDEMB	:= opGet:aCols[nlI,npPosQE]
								SC9->(MsUnLock())
								llRet := .T.
							EndIf
						EndIf
					EndIf
				EndIf
			Next nlI
			
			llRet := GeraEtiqueta(clFilial,clNumPed)
			
			End Transaction
		EndIf
	Else
		MsgStop(clMsg)
	EndIf
	RestArea(alAreaSC9)
	
Return (llRet)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraEtiqueบ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que gera etiqueta do volume.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
Static Function GeraEtiqueta(clFilial,clNumPed)

Local llRet 	:= .F.
Local clPerg	:= "ADVOL"
Local nlI		:= 1
Local clMsg		:= ""
Local alAreaSC9	:= SC9->(GetArea())

	If SC9->C9_EXPFLAG <> "  "
		//clMsg := VldCols(1)
		If Empty(clMsg)
			If MsgNoYes("Deseja Gerar Etiqueta?")
				alVols 		:= RetVolume() //2 - Minimo , 1 - Maximo
				
				DBSelectArea("SX1")
				SX1->(DbsetOrder(1))
				SX1->(DbGoTop())
				If SX1->(DBSeek(PadR(clPerg,10)))
					While SX1->(!EoF()) .AND. SX1->X1_GRUPO == PadR(clPerg,10)
						If Reclock("SX1",.F.)
							SX1->X1_CNT01 := Alltrim(Str(Iif(SX1->X1_ORDEM == "01",alVols[2],alVols[1])))
							SX1->(MsUnlock())
						EndIf
						SX1->(DbSkip())
					EndDo
				Else
					PutSx1(clPerg, "01", "Do Volume?"			," ", "","mv_ch1","N", 04,0,0,"G","","","","","mv_par01", "", "", "", "", "", "", "","", "", "", "", "", "", "", "", "", "", "" )
					PutSx1(clPerg, "02", "At้ o Volume?"		," ", "","mv_ch2","N", 04,0,0,"G","","","","","mv_par02", "", "", "", "", "", "", "","", "", "", "", "", "", "", "", "", "", "" )
				EndIf
				
				If Pergunte(clPerg)
					If !(mv_par01 >= alVols[2] .AND. mv_par01 <= alVols[1] .AND. mv_par02 >= alVols[2] .AND. mv_par02 <= alVols[1])
						MsgStop("Digite o volume entre "+Alltrim(Str(alVols[2]))+" e "+Alltrim(Str(alVols[1])))
					ElseIf U_PRT0118(clFilial, clNumPed,Alltrim(Str(mv_par01)),Alltrim(Str(mv_par02)))
						//If SC9->C9_EXPFLAG == "01" // se compos volume
						For nlI := 1 To Len(apProd)
							If SC9->(DBSeek(clFilial+clNumPed+SubStr(apProd[nlI],1,Len(SC9->C9_ITEM))))
								If RecLock("SC9",.F.)
									If SC9->C9_EXPFLAG == "01" // se compos volume
										SC9->C9_BLEST		:= "XX"  // Processo de expedicao
										SC9->C9_EXPFLAG 	:= "02"  // Gerou etiqueta
									EndIf
									SC9->(MsUnLock())
									llRet := .T.
								EndIf
							EndIf
						Next nlI
						//EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		clMsg := "O Pedido ainda nใo foi composto volume"
	EndIf
	If !Empty(clMsg)
		MsgStop(clMsg)
	EndIf
	RestArea(alAreaSC9)
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetVolume บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna num array o menor e maior volume.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
Static Function RetVolume()

Local alRet := {}
Local nlI	:= 1
Local nlVol	:= 0

	For nlI := 1 To Len(opGet:aCols)
		If !opGet:ACOLS[nlI,Len(aHeader)+1]
			If opGet:aCols[nlI,npPosVol] >= nlVol
				nlVol := opGet:aCols[nlI,npPosVol]
			EndIf
		EndIf
	Next nlI
	
	//Adciona o maior volume do pedido
	aAdd(alRet,nlVol)
	
	For nlI := 1 To Len(opGet:aCols)
		If !opGet:ACOLS[nlI,Len(aHeader)+1]
			If opGet:aCols[nlI,npPosVol] <= nlVol
				nlVol := opGet:aCols[nlI,npPosVol]
			EndIf
		EndIf
	Next nlI
	
	//Adciona o menor volume do pedido
	aAdd(alRet,nlVol)
	
Return (alRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDeleteVol บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que deleta os dados de composicao de volume.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
User Function DeleteVol(clKeySZD)

	SZD->(DbSetOrder(1))
	If SZD->(DBSeek(clKeySZD))
		While SZD->(!EoF()) .AND. SZD->ZD_FILIAL+SZD->ZD_PEDIDO+SZD->ZD_ITEMPV == clKeySZD
			If RecLock("SZD",.F.)
				SZD->(DbDelete())
				SZD->(MsUnLock())
			EndIf
			SZD->(DbSkip())
		EndDo
	EndIf
	
Return
	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetMaxVol บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que retorna a quantidade maxima de volume.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
Static Function RetMaxVol(clFil,clPed)

Local nlRet := 0
Local clQry

	clQry := "SELECT MAX(ZD_VOLUME) AS MAXVOL FROM "+RetSqlName("SZD") +" SZD"
	clQry += " WHERE SZD.D_E_L_E_T_ = ''"
	clQry += " AND SZD.ZD_FILIAL = '"+clFil+"'"
	clQry += " AND SZD.ZD_PEDIDO = '"+clPed+"'"
	
	If Select("XMAX") > 0
		XMAX->(DbCloseArea())
	EndIf
	
	TcQuery clQry New Alias "XMAX"
	
	If XMAX->(!EoF())
		nlRet := XMAX->MAXVOL
	EndIf
	
Return (nlRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcQV    บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Calcula a quantidade por volume e refaz o saldo.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/	
User Function CalcQV()

Local llRet 	:= .T.
Local nlI		:= 1
Local nlCalc    := 0
Local nlSaldoAux:= npSaldo

	If Positivo()
		For nlI := 1 To Len(aCols)
			If !aCols[nlI,Len(aHeader)+1]
				If aCols[nlI,1] <> 0
					If nlI == opGet:NAT
						nlCalc += M->QTDVOL
					Else
						nlCalc += opGet:aCols[nlI,2]
					EndIf
				EndIf
			EndIf
		Next nlI
		npSaldo := npQtdLib - nlCalc
		If nlCalc > npQtdLib
			npSaldo := nlSaldoAux
			llRet 	:= .F.
			MsgStop("A quantidade por volume digitada nใo pode ultrapassar a quantidade liberada.")
		EndIf
		opSaySaldo:Refresh()
	Else
		llRet := .F.
	EndIf
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldEst    บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/		
Static Function VldEst(clKeySC9)

Local cRet	:= ""
Local nlI	:= 1
Local nlSld	:= 0

	SB2->(DbSetOrder(1))
	SC9->(DbSetOrder(1))
	//For nlI := 1 To Len(opGet:aCols)
	//If !opGet:aCols[nlI,Len(aHeader)+1]
	//If SC9->(DBSeek(clKeySC9+opGet:aCols[nlI,npPosItem]))
	//Buscar Saldo disponivel
	If SB2->(DBSeek( xFilial("SB2") + SC9->C9_PRODUTO+SC9->C9_LOCAL/*"01"*/))//ALTERADO P/ REGINALDO C9_LOCAL
		nlSld 	:= SB2->B2_QATU//SALDOSB2()
	Else
		nlSld	:= 0
	Endif
	//EndIf
	If nlSld < SC9->C9_QTDLIB
		cRet := SC9->C9_PRODUTO+", saldo: "+Alltrim(Transform(nlSld,"@E 999,999,999.99"))+;
		" e qtde. liberada: "+Alltrim(Transform(SC9->C9_QTDLIB,"@E 999,999,999.99"))
		/*cRet := "O Produto: "+SC9->C9_PRODUTO+", Armazem: "+SC9->C9_LOCAL+" possui saldo de: "+Alltrim(Transform(nlSld,"@E 999,999,999.99"))+;
		" , por้m sua quantidade liberada foi de "+Alltrim(Transform(SC9->C9_QTDLIB,"@E 999,999,999.99"))+" !"*/
		//Exit
	EndIf
	//EndIf
	//Next nlI
	
Return (cRet)
	
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLibFat    บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
Static Procedure LibFat()

Local olDlg 	:= MSDialog():New(030,100,300,400,"Libera็ใo de Itens p/ Faturamento",,,,,,,,,.T.)
Local alHeader	:= {}
Local alCols	:= {}
Local nlI		:= 1

Private nOk		:= 1
Private nProd   := 2
Private opOK 		:= LoadBitmap(GetResources(),'LBOK')
Private opNO 		:= LoadBitmap(GetResources(),'LBNO')

	Aadd(alHeader, {" "			,"OK"		,'@BMP'	,01,0,".T." ,,"C","",,,})
	Aadd(alHeader, {"Produto"	,"PRODUTO"  ,'@!'	,01,0,".T." ,,"C","",,,})
	
	For nlI := 1 To Len(apProd)
		
		aAdd(alCols,Array(Len(alHeader)+1))
		alCols[nlI,nOk] 	:= opOk
		alCols[nlI,nProd]	:= apProd[nlI]
		
		alCols[nlI,Len(alHeader)+1] := .F.
	Next nlI
	
	olGet 	:=	MsNewGetDados():New(10,005,300,200 ,1  /*,GD_INSERT + GD_UPDATE + GD_DELETE*/,/*"U_VldLinha()"*/,/*"AllWaysTrue()"*/,,{},,Len(alCols),/*"AllWaysTrue()"*/,,"U_WhenDelete(0)",olDlg,alHeader,alCols)
	olGet:oBrowse:bldblclick := {|| MarkUm(@olGet) }
	
	olDlg:Activate(,,,.T.,,,)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMarkUm    บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
Static Function MarkUm(olGet)

Local n:= olGet:nAt

	If olGet:oBrowse:COLPOS == 1
		If olGet:aCols[n,1]:CNAME == 'LBOK'
			olGet:aCols[n,1]:= opOK
		Else
			olGet:aCols[n,1]:= opOK
		EndIF
	EndIF
	olGet:Refresh()
	
Return .F.

	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBtnClick  บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que libera para o faturamento os itens que forem    บฑฑ
ฑฑบ          ณ separados.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
User Function BtnClick(clFlag,clKeySC9)

Local llRet 	:= .F.
Local nlI		:= 1
Local llOk 		:= .F.
Local clConfirm	:= ""
Local clMsg		:= ""
Local clProd	:= ""
Local alProd	:= {}

	If clFlag == "03"
		clConfirm := "a libera็ใo"
		clMsg	  := VldCols(1)
		//If Empty(clMsg)
		//	clMsg := VldEst(clKeySC9)
		//EndIf
	ElseIf	clFlag == "  "
		clConfirm := "o estorno"
	EndIf
	
	If Empty(clMsg)
		DBSelectArea("SC9")
		SC9->(DbSetOrder(1))
		If MsgNoYes("Confirma "+clConfirm+" dos itens?")
			llRet := .T.
			
			For nlI := 1 To Len(apProd)
				If SC9->(DBSeek(clKeySC9+SubStr(apProd[nlI],1,Len(SC9->C9_ITEM))))
					If clFlag == "  "
						U_DeleteVol(clKeySC9+SC9->C9_ITEM)
					EndIf
					If clFlag == "03"
						clProd := VldEst()
					EndIf
					If Empty(clProd)
						llOk := .T.
						If RecLock("SC9",.F.)
							SC9->C9_EXPFLAG	:= clFlag							// Flag com a operacao corrente
							SC9->C9_BLEST	:= Iif(clFlag=="03","  ","XX") 		// Libera estoque para faturamento
							SC9->C9_QTDEMB	:= opGet:aCols[nlI,npPosQE]			// Grava a quantidade de embalagem, nesse Zero, pois o item esta deletado
							SC9->(MsUnLock())
						EndIf
					Else
						
						If RecLock("SC9",.F.)
							SC9->C9_BLINF := '1'
							SC9->(MsUnLock())
						EndIf
						
						aAdd(alProd,clProd)
					EndIf
					
				EndIf
			Next nlI
			
			If .t. //llOk
				SC5->(DbSetOrder(1))
				If SC5->(DBSeek(clKeySC9))
					If RecLock("SC5",.F.)
						//	nlVolLib := RetVolLib(clKeySC9)
						//	If clFlag == "03"
						SC5->C5_PBRUTO	:= npPeso
						If npPesoL >0
							SC5->C5_PESOL 	:= npPesoL
						Else
							SC5->C5_PESOL 	:= npPeso
						EndIf
						
						
						SC5->C5_VOLUME1	:= npVol //nlVolLib
						SC5->C5_ESPECI1	:= "CAIXA"
						//	Else
						//	SC5->C5_PESOL 	:= 0
						//	SC5->C5_PBRUTO 	:= 0
						//	SC5->C5_VOLUME1	:= 0
						//SC5->C5_ESPECI1	:= ""
						//EndIf
						SC5->(MsUnlock())
					Else
						clProd := "Nao foi possivel atualizar peso e volume do pedido!"
					EndIf
				EndIf
			EndIf
			
			clProd := ""
			For nlI := 1 To Len(alProd)
				clProd += alProd[nlI]+CRLF
			Next nlI
			If !Empty(clProd)
				Aviso("AVISO","Os produtos abaixo nใo possuem saldo:"+CRLF+clProd,{"Ok"},3)
			EndIf
		EndIf
	Else
		MsgStop(clMsg)
	EndIf
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetVolLib บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
Static Function RetVolLib(clKeySC9)

Local nlI 		:= 1
Local nlRet 	:= 0
Local nlPosVol  := 1
Local alVols	:= {}

	For nlI := 1 To Len(opGet:aCols)
		If !opGet:aCols[nlI,Len(aHeader)+1]
			If SC9->(DBSeek(clKeySC9+opGet:aCols[nlI,1]))
				If Empty(VldEst())
					nlPosVol := aScan(alVols,{|aX| aX == opGet:aCols[nlI,npPosVol]})
					If nlPosVol == 0
						aAdd(alVols,opGet:aCols[nlI,npPosVol])
						nlRet++
					EndIf
				EndIf
			EndIf
		EndIf
	Next nlI
	
Return (nlRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetHeader บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que alimenta o cabecalho do array aHeader.          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
Static Procedure GetHeader()

Local nlI			:= 1
Local alCampos		:= {"C9_ITEM","C9_DATALIB","C9_PRODUTO","C9_QTDLIB","C9_LOTECTL","QTDPECA","VOLUME","B1_QE","QTDEMB","B1_PESO"}

	aHeader := {}
	//Preenchimento do aHeader
	DBSelectArea("SX3")
	SX3->(DbSetOrder(2))
	For nlI := 1 To Len(alCampos)
		If alCampos[nlI] == "QTDEMB"
			aAdd(aHeader,{"Qtd. de Embalagem","QTDEMB","@E 999,999,999          ",9,0,;
			"U_CalcQE()","€€€€€€€€€€€€€€ ","N","",""  })
		ElseIf alCampos[nlI] == "QTDPECA"
			aAdd(aHeader,{"Qtd. de Pe็a","QTDPECA","@E 999,999,999          ",9,0,;
			"U_CalcPeca()","€€€€€€€€€€€€€€ ","N","",""  })
		ElseIf alCampos[nlI] == "VOLUME"
			aAdd(aHeader,{"Volume","VOLUME","@E 9,999          ",4,0,;
			"U_VldVol()","€€€€€€€€€€€€€€ ","N","",""  })
		ElseIf SX3->(DBSeek(alCampos[nlI]))
			If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
				aAdd(aHeader,{Iif(alCampos[nlI] == "B1_QE","Qtd. por Embalagem",Trim(X3Titulo())),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,;
				SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT  })
			EndIf
		EndIf
	Next nlI
	
	npPosItem 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "C9_ITEM"		})
	npPosDtLib	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "C9_DATALIB"	})
	npPosProd 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "C9_PRODUTO"	})
	npPosQL 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "C9_QTDLIB"	})
	npPosLote	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "C9_LOTECTL"	})
	npPosB1QE 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "B1_QE"		})
	npPosPeca 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "QTDPECA"		})
	npPosVol 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "VOLUME"		})
	npPosQE 	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "QTDEMB"		})
	npPosPeso	:= aScan(aHeader,{|aX| Alltrim(aX[2]) == "B1_PESO"		})
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcQE    บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que calcula a quantidade de embalagem, no momento   บฑฑ
ฑฑบ          ณ que digita.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
User Function CalcQE()

Local llRet		:= .T.

	If !opGet:aCols[opGet:NAT,Len(aHeader)+1]
		If Positivo()
			npVol -= aCols[opGet:NAT,npPosQE]
			npVol += M->QTDEMB
			
			opGetVol:Refresh()
		Else
			llRet	:= .F.
		EndIf
	EndIf
	
Return (llRet)
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWhenDeleteบ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que refaz os calculos de volume e peso no momento   บฑฑ
ฑฑบ          ณ que deleta uma linha do aCols.                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
User Function WhenDelete(nlFlag)

Local llRet		:= .T.
Local alVols	:= {}
Local nlPosVol  := 0
Local nlI		:= 0
Local lCont		:= .F.

	For nlI := 1 To Len(opGet:aCols)
		If opGet:aCols[nlI,npPosVol] == 0
			lCont := .F.
		ElseIf opGet:aCols[nlI,Len(aHeader)+1] .AND. nlI == opGet:nAt		//Se tiver desdeletando
			lCont := .T.
		ElseIf nlI <> opGet:nAt .AND. !opGet:aCols[nlI,Len(aHeader)+1]
			lCont := .T.
		Else
			lCont := .F.
		EndIf
		
		If lCont
			nlPosVol := aScan(alVols,{|aX| aX == opGet:aCols[nlI,npPosVol] })
			
			If nlPosVol == 0
				aAdd(alVols,opGet:aCols[nlI,npPosVol])
			EndIf
		EndIf
	Next nlI
	npVol 	:= Len(alVols)
	If !opGet:aCols[opGet:NAT,Len(aHeader)+1]
		npPeso -= opGet:aCols[opGet:NAT,npPosPeso]
	Else
		npPeso += opGet:aCols[opGet:NAT,npPosPeso]
	EndIf
	opGetVol:Refresh()
	opGet:Refresh()
	//aCols[opGet:NAT,Len(aHeader)+1] := .T.
	
Return (llRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCols   บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao que alimenta com os valor do array aCols da tela de บฑฑ
ฑฑบ          ณ Separacao.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
/*
Static Function GetCols(nlOpc,clFilial,clNumPed)

Local clQry

aCols := {}
clQry := "SELECT C9_ITEM"
clQry += " ,C9_DATALIB"
clQry += " ,C9_PRODUTO"
clQry += " ,C9_QTDLIB"
clQry += " ,C9_EXPFLAG"
clQry += " ,B1_QE"
clQry += " ,B1_PESO"
clQry += " ,B1_DESC"
If nlOpc == 3
clQry += " , CASE B1_QE WHEN 0 THEN 0 ELSE C9_QTDLIB/B1_QE END AS QTDEMB"
Else
clQry += " , C9_QTDEMB AS QTDEMB"
EndIf
clQry += " FROM "+RetSqlName("SC9")+" SC9"
clQry += " JOIN "+RetSqlName("SB1")+" SB1"
clQry += " ON ( "
//clQry += " B1_FILIAL = '"+xFilial("SB1")+"' AND"
clQry += " B1_COD = C9_PRODUTO AND B1_LOCPAD = C9_LOCAL )"
clQry += " WHERE SC9.D_E_L_E_T_ = ''"
clQry += " AND SB1.D_E_L_E_T_ = ''"
clQry += " AND C9_FILIAL = '"+clFilial+"'"
clQry += " AND C9_PEDIDO = '"+clNumPed+"'"
If nlOpc == 8
clQry += " AND (C9_EXPFLAG IN ('02','03','04')"
Else
If nlOpc == 2 .OR. nlOpc == 5
clQry += " AND ((C9_EXPFLAG IN ('00','01','02','03','04') "
Else
clQry += " AND ((C9_EXPFLAG IN ('00','01') "
EndIf
clQry += " OR (C9_EXPFLAG = '  ' AND C9_BLEST = 'XX'))"
EndIf
clQry += " AND C9_BLCRED <> '09') "//AND C9_BLCRED <> '10' AND C9_BLCRED <> 'ZZ'))"

If Select("XQRY") > 0
XQRY->(DbCloseArea())
EndIf

TcQuery clQry New Alias "XQRY"

While XQRY->(!EoF())

npVol 	+= Iif(XQRY->QTDEMB < 1,1,Round(XQRY->QTDEMB,0))
npPeso	+= XQRY->B1_PESO

aAdd(aCols,Array(Len(aHeader)+1))
For nlI :=  1 To Len(aHeader)
If aHeader[nlI,2] == "C9_DATALIB"
aCols[Len(aCols),nlI] := StoD(XQRY->C9_DATALIB)
ElseIf aHeader[nlI,2] == "QTDEMB"
aCols[Len(aCols),nlI] := Iif(XQRY->QTDEMB < 1,1,round(XQRY->QTDEMB,0))
ElseIf aHeader[nlI,2] == "C9_PRODUTO"
aCols[Len(aCols),nlI] := XQRY->C9_PRODUTO+"-"+Alltrim(XQRY->B1_DESC)
Else
aCols[Len(aCols),nlI] := &("XQRY->"+aHeader[nlI,2])
EndIf
Next nlI
If XQRY->C9_EXPFLAG == "00"
aCols[Len(aCols),Len(aHeader)+1] := .T.
Else
aCols[Len(aCols),Len(aHeader)+1] := .F.
EndIf

XQRY->(DbSkip())
EndDo

Return (Nil)*/


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณM440SC9I  บ Autor ณ Rafael P. Goncalvesบ Data ณ  26/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/			
User Function M440SC9I()

	If Posicione("SF4",1,xFilial("SF4")+SC6->C6_TES,"F4_ESTOQUE") == "S"
		SC9->C9_BLINF := ""
	Else
		SC9->C9_BLINF := "2"
	EndIF
	                                     
Return .T.
