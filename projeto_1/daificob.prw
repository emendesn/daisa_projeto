#Include "Protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDaiFicOb  บAutor  ณMauro Sano          บ Data ณ  01/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime a ficha de obra                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function DaiFicOb()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
LOCAL cString	:= "SZ4"
Local oRadio
Local nRadio
PRIVATE titulo 	:= ""
PRIVATE nLastKey:= 0
PRIVATE cPerg	:= Padr("DAIFICOB", 10)
PRIVATE nomeProg:= FunName()
Private nTotal	:= 0
Private nSubTot	:= 0
Private oDlg
private pag := 1

wnrel := FunName()            //Nome Default do relatorio em Disco

PRIVATE cTitulo := "Impressใo da Ficha de Obra"
PRIVATE oPrn    := NIL
PRIVATE oFont1  := NIL
PRIVATE oFont2  := NIL
PRIVATE oFont3  := NIL
PRIVATE oFont4  := NIL
PRIVATE oFont5  := NIL
PRIVATE oFont6  := NIL
Private nLastKey := 0
Private nLin := 1650 // Linha de inicio da impressao das clausulas contratuais

DEFINE FONT oFont1 NAME "Times New Roman" SIZE 0,20 BOLD  OF oPrn
DEFINE FONT oFont2 NAME "Times New Roman" SIZE 0,14 BOLD OF oPrn
DEFINE FONT oFont3 NAME "Times New Roman" SIZE 0,14 OF oPrn
DEFINE FONT oFont4 NAME "Times New Roman" SIZE 0,14 ITALIC OF oPrn
DEFINE FONT oFont5 NAME "Times New Roman" SIZE 0,14 OF oPrn
DEFINE FONT oFont6 NAME "Courier New" BOLD

oFont08v := TFont():New("Verdana",08,08,,.T.,,,,.T.,.F.)

oFont06	 := TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont06N := TFont():New("Arial",06,06,,.T.,,,,.T.,.F.)
oFont08	 := TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont08N := TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)
oFont10	 := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont11  := TFont():New("Arial",11,11,,.F.,,,,.T.,.F.)
oFont11N := TFont():New("Arial",11,11,,.T.,,,,.T.,.F.)
oFont12  := TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
oFont12N := TFont():New("Arial",12,12,,.T.,,,,.T.,.F.)
oFont14	 := TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)
oFont16	 := TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont10N := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
oFont12  := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12N := TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
oFont16N := TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
oFont14N := TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)
oFont06	 := TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont06N := TFont():New("Arial",06,06,,.T.,,,,.T.,.F.)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Tela de Entrada de Dados - Parametros                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nLastKey  := IIf(LastKey() == 27,27,nLastKey)

If nLastKey == 27
	Return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicio do lay-out / impressao                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oPrn := TMSPrinter():New(cTitulo)
oPrn:Setup()
oPrn:SetPortrait()
oPrn:StartPage()

Imprimir()

oPrn:EndPage()
oPrn:Preview()
oPrn:End()

Return(NIL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImprimir  บAutor  ณMauro Sano          บ Data ณ  12/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio tecnico para ida ao cliente                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION Imprimir()
Orcamento()
Ms_Flush()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOrcamento บAutor  ณMauro Sano          บ Data ณ  12/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio tecnico para ida ao cliente                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION Orcamento()
Local nSalto	:= 40
Local cQuery	:= ""
Local nResult	:= 1
Local nLinMem	:= 0
Local cNome		:= 0
Local cRelCli	:= ""
Local nX		:= 0
Local aItens	:= {}
Local nLinAux	:= 0
Local lPrint	:= .F.
Local nLin		:= 0

Private nLinha	:= 50
Private dData	:= Date()
Private cHora	:= Time()


DbSelectArea("SZ5")
DbSetOrder(1)
DbSeek( xFilial("SZ5") + SZ4->Z4_COD )

Cabec()
Partic()
Quadro()

DadosTMK()
If nLinha >= 2800
	oPrn:EndPage()
	nLinha := 50
	Cabec()
EndIf
DadosSUA()
If nLinha >= 2800
	oPrn:EndPage()
	nLinha := 50
	Cabec()
EndIf
Observacao()


/*
oPrn:Box(nLinha,0150,nLinha + 300,1500)
oPrn:Line(nLinha+100,0150,nLinha+100,1500)
oPrn:Line(nLinha+200,0150,nLinha+200,1500)
oPrn:Line(nLinha,0550,nLinha+300,0550)
oPrn:Line(nLinha,1000,nLinha+300,1000)
nLinha += 30*/



oPrn:EndPage()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec     บAutor  ณMauro Sano          บ Data ณ  01/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o cabecalho da ficha de obra                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Cabec()
nLinha := 100
++pag
oPrn:StartPage()
cBitMap := '\system\logo_daisa.jpg'
cNome := SM0->M0_NOMECOM

//oPrn:SayBitmap(0100,0100,alltrim(cBitMap),0300,0100)			// Imprime logo da Empresa: comprimento X altura    4
oPrn:SayBitmap(0100,0050,alltrim(cBitMap),0400,0200)

//oPrn:Box(0100,0450,0250,2100)

oPrn:Say(nLinha, 2200,DToC(dData),oFont08,100)
nLinha += 50

oPrn:Say(nLinha, 1100,"FICHA DE OBRA",oFont14N,100)
nLinha += 20
oPrn:Say(nLinha, 2200,cHora,oFont08,100)
nLinha += 200

oPrn:Say(nLinha, 0100,"Obra:",oFont10N,100)
oPrn:Say(nLinha, 0300,AllTrim(SUBSTR(SZ4->Z4_DESC,1,40)),oFont10,100)
oPrn:Say(nLinha, 1200,"Tipo:",oFont10N,100)
oPrn:Say(nLinha, 1400,AllTrim(SZ4->Z4_TIPO),oFont10,100)
oPrn:Say(nLinha, 2000,"Regiao:",oFont10N,100)
oPrn:Say(nLinha, 2200,AllTrim(SZ4->Z4_AREA),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"Endere็o:",oFont10N,100)
oPrn:Say(nLinha, 0300,AllTrim(SZ4->Z4_END),oFont10,100)
oPrn:Say(nLinha, 1200,"Operador:",oFont10N,100)
oPrn:Say(nLinha, 1400,AllTrim(SZ4->Z4_NOMOP),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"Bairro:",oFont10N,100)
oPrn:Say(nLinha, 0300,AllTrim(SZ4->Z4_BAIRRO),oFont10,100)
oPrn:Say(nLinha, 1200,"CEP:",oFont10N,100)
oPrn:Say(nLinha, 1400,AllTrim(SZ4->Z4_CEP),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"Cidade:",oFont10N,100)
oPrn:Say(nLinha, 0300,AllTrim(SZ4->Z4_CIDADE),oFont10,100)
oPrn:Say(nLinha, 1200,"UF:",oFont10N,100)
oPrn:Say(nLinha, 1400,AllTrim(SZ4->Z4_UF),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"Fase:",oFont10N,100)
oPrn:Say(nLinha, 0300,AllTrim(SZ4->Z4_DESOBRA),oFont10,100)
oPrn:Say(nLinha, 1200,"Segmento :",oFont10N,100)
oPrn:Say(nLinha, 1400,AllTrim(SZ4->Z4_SEGMENT),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"Investimento:",oFont10N,100)
oPrn:Say(nLinha, 0700,Transform(SZ4->Z4_INVEST,"@E 999,999,999,999.99"),oFont10,100)
oPrn:Say(nLinha, 1200,"Pot. Compra :",oFont10N,100)
oPrn:Say(nLinha, 1500,Transform(SZ4->Z4_POTCOMP,"@E 999,999,999,999.99"),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"% Chanc.:",oFont10N,100)
oPrn:Say(nLinha, 0300,Transform(SZ4->Z4_PCHANCE,"@E 999.99"),oFont10,100)
oPrn:Say(nLinha, 1200,"Chanceamento:",oFont10N,100)
oPrn:Say(nLinha, 1800,Transform(SZ4->Z4_CHANCEL,"@E 999,999,999,999.99"),oFont10,100)
nLinha += 80

oPrn:Say(nLinha, 0100,"Engenheiro Residente",oFont10N,100)
oPrn:Say(nLinha, 1200,"Previsao Inicio",oFont10N,100)
oPrn:Say(nLinha, 1600,"Previsao COMPRA",oFont10N,100)
oPrn:Say(nLinha, 2000,"Telefone na Obra",oFont10N,100)
nLinha += 50

oPrn:Line(nLinha,0100,nLinha,2250)
nLinha += 20

oPrn:Say(nLinha, 0100,AllTrim(SZ4->Z4_ENGRESP),oFont10N,100)
oPrn:Say(nLinha, 1300,DToC(SZ4->Z4_DTINI),oFont10N,100)
oPrn:Say(nLinha, 1700,DToC(SZ4->Z4_DTFIM),oFont10N,100)
oPrn:Say(nLinha, 2000,AllTrim(SZ4->Z4_TEL),oFont10N,100)
nLinha += 50

oPrn:Line(nLinha,0100,nLinha,2250)
nLinha += 80
if pag = 1
	oPrn:Say(nLinha, 0100,"CADEIA DE FORNECIMENTO DA OBRA:",oFont10N,100)
	nLinha += 50
endif


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPartic    บAutor  ณMauro Sano          บ Data ณ  01/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Participantes da obra                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Partic()
Local nEntidade	:= 0
Local cTipo		:= ""

DbSelectArea("SZ5")
DbSetOrder(2)
If SZ5->(DbSeek(xFilial("SZ5") + SZ4->Z4_COD ) )
	While !SZ5->(Eof()) .AND. SZ4->Z4_COD == SZ5->Z5_COD
		nEntidade += 1
		SZ5->(DbSkip())
	End
EndIf

oPrn:Box(nLinha ,0100,nLinha+(nEntidade*200),2250)
nLinha += 20
DbSelectArea("SZ5")
DbSetOrder(2)
DbGoTop()
If SZ5->(DbSeek(xFilial("SZ5") + SZ4->Z4_COD ) )
	While !SZ5->(Eof()) .AND. SZ4->Z4_COD == SZ5->Z5_COD
		oPrn:Say(nLinha, 0110,AcaX3Cmb("Z5_TIPO",SZ5->Z5_TIPO),oFont10N,100)
		oPrn:Say(nLinha, 0500,AllTrim(SZ5->Z5_NOME),oFont10,100)
		
		If SZ5->Z5_PROSPEC == "S"
			DbSelectArea("SUS")
			DbSetOrder(1)
			If DbSeek(xFilial("SUS") + SZ5->Z5_CODENV )
				oPrn:Say(nLinha, 1700,"มrea:",oFont10N,100)
				oPrn:Say(nLinha, 2000,SUS->US_REGIAO,oFont10,100)
			EndIf
		Else
			DbSelectArea("SA1")
			DbSetOrder(1)
			If DbSeek(xFilial("SA1") + SZ5->Z5_CODENV )
				oPrn:Say(nLinha, 1700,"มrea:",oFont10N,100)
				oPrn:Say(nLinha, 2000,SA1->A1_REGIAO,oFont10,100)
			EndIf
		EndIf
		nLinha += 40
		
		oPrn:Say(nLinha, 0110,"Telefone:",oFont10N,100)
		oPrn:Say(nLinha, 0500,AllTrim(SZ5->Z5_DDD) + " " + Alltrim(SZ5->Z5_TEL),oFont10,100)
		oPrn:Say(nLinha, 1000,"Contato:",oFont10N,100)
		oPrn:Say(nLinha, 1200,AllTrim(SZ5->Z5_NOMCONT),oFont10,100)
		//		oPrn:Say(nLinha, 1700,"Repres.:",oFont10N,100)
		oPrn:Say(nLinha, 2000,"",oFont10,100)
		//		nLinha += 40
		//		oPrn:Say(nLinha, 0110,"Obs:",oFont10N,100)
		//		oPrn:Say(nLinha, 0300,AllTrim(Msmm(SZ5->Z5_OBS)),oFont10,100)
		nLinha += 100
		
		SZ5->(DbSkip())
		//		nLinha += 20
		If nLinha >= 2800
			oPrn:EndPage()
			nLinha := 50
			Cabec()
		EndIf
	End
EndIf                      
nLinha += 80

oPrn:Say(nLinha, 0100,"DIVISAO DO TRABALHO EM CONJUNTO: ",oFont10N,100)


nLinha += 50

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDAIFICOB  บAutor  ณMicrosiga           บ Data ณ  01/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function DadosTMK()
LOCAL QRY:=''
Local cObs := ""
nLinha += 520
oPrn:Say(nLinha, 0100,"Data",oFont10N,100)
oPrn:Say(nLinha, 0500,"Contato",oFont10N,100)
oPrn:Say(nLinha, 1200,"Operador",oFont10N,100)
//oPrn:Say(nLinha, 1200,"Observa็๕es",oFont10N,100)

nLinha += 40
oPrn:Line(nLinha,0100,nLinha,2250)
nLinha += 40
 
QRY:="SELECT * FROM "
QRY += RetSqlName("SUC")
QRY += " WHERE D_E_L_E_T_ <> '*' AND UC_XCODOB = "+SZ4->Z4_COD       
cQuery := ChangeQuery(QRY)
//ABRE A QUERY
dbUseArea(.T.,"TOPCON",TcGenQry(,,QRY),'TRB1',.T.,.T.)


/*DbSelectArea("SUC")
DbSetOrder(1) 
If SUC->(DbSeek(xFilial("SUC") + SZ4->Z4_COD))*/
	do While !TRB1->(Eof()) .AND. TRB1->UC_XCODOB == SZ4->Z4_COD
		
		IF ALLTRIM(TRB1->UC_CODCANC)=''
			cObs := UPPER(Msmm(TRB1->UC_CODOBS))
			oPrn:Say(nLinha, 0100,cValTochar(STOD(TRB1->UC_DATA)),oFont10,100)
			oPrn:Say(nLinha, 0500,Posicione("SU5", 1, xFilial("SU5") + TRB1->UC_CODCONT, "U5_CONTAT"),oFont10,100)
			oPrn:Say(nLinha, 1200,"Op.:"+Posicione("SU7",1,xFilial("SU7") + TRB1->UC_OPERADO, "U7_NOME"),oFont10,100)
			nLinha += 40

			oPrn:Line(nLinha,0100,nLinha,2250)
			
			cMemo:=cObs
			cDecret := ""
			nMemCount	:= MlCount( cMemo ,100 )
			If !Empty( nMemCount )
				For nLoop := 1 To nMemCount
					cDecret += MemoLine( cMemo, 100, nLoop )
					cDecret += "||"
				Next nLoop
			Else
				cDecret   := cMemo
			EndIf
			cDecret   := if( Empty(cDecret), " ", cDecret )
			for w:= 1 to nMemCount
				oPrn:Say(nLinha, 0100,SUBSTR(cDecret,1,at("||",cDecret)-1),oFont08v,100)
				cDecret	:= SUBSTR(cDecret,at("||",cDecret)+2)
				nLinha += 40
				If nLinha >= 2800
					oPrn:EndPage()
					nLinha := 50
					Cabec()
				EndIf
			next w
			nLinha += 40
			nLinha += 40
			oPrn:Line(nLinha,0100,nLinha,2250)
			If nLinha >= 2800
				oPrn:EndPage()
				nLinha := 50
				Cabec()
			EndIf
				
		ENDIF
		TRB1->(DbSkip())
	Enddo   
	DbSelectArea("TRB1")
	DbCloseArea("TRB1")
//EndIf  
nLinha += 50
Return()

Static Function DadosSUA()

LOCAL QRY:=''

QRY:="SELECT * FROM "
QRY += RetSqlName("SUA")
QRY += " WHERE D_E_L_E_T_ <> '*' AND UA_XCODOB = "+SZ4->Z4_COD

//VALIDA A QUERY
cQuery := ChangeQuery(QRY)
//ABRE A QUERY
dbUseArea(.T.,"TOPCON",TcGenQry(,,QRY),'TRB1',.T.,.T.)

nLinha += 120
oPrn:Say(nLinha, 0100,"Data",oFont10N,100)
oPrn:Say(nLinha, 0500,"Cliente",oFont10N,100)
oPrn:Say(nLinha, 1200,"Valor",oFont10N,100)
oPrn:Say(nLinha, 1700,"Opera็ใo",oFont10N,100)
oPrn:Say(nLinha, 2000,"No Atendimento",oFont10N,100)

nLinha += 50

oPrn:Line(nLinha,0100,nLinha,2500)
nLinha += 20

DbSelectArea("TRB1")
While !TRB1->(Eof())
	oPrn:Say(nLinha, 0100,DToC(stod(TRB1->UA_EMISSAO)),oFont10,100)
	oPrn:Say(nLinha, 0500,SUBSTR(Posicione("SA1", 1, xFilial("SA1") + TRB1->UA_CLIENTE + TRB1->UA_LOJA, "A1_NOME"),1,30),oFont10,100)
	oPrn:Say(nLinha, 1200,TRANSFORM(TRB1->UA_VALBRUT,"@E 999,999,999.99"),oFont10,100)
	oPrn:Say(nLinha, 1700,IIF(TRB1->UA_OPER='1','FATURAMENTO',IIF(TRB1->UA_OPER='2','ORวAMENTO','ATENDIMENTO')),oFont10,100)
	oPrn:Say(nLinha, 2000,TRB1->UA_NUM,oFont10,100)
	
	nLinha += 40
	TRB1->(DbSkip())
End

nLinha += 50
oPrn:Line(nLinha,0100,nLinha,2500)
nLinha += 20

DBCLOSEAREA()

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQuadro    บAutor  ณMicrosiga           บ Data ณ  01/18/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Quadro()

oPrn:Box(nLinha,0100,nLinha + 500,2250)
oPrn:Line(nLinha+83,0100,nLinha+83,2250)
oPrn:Line(nLinha+166,0100,nLinha+166,2250)
oPrn:Line(nLinha+249,0100,nLinha+249,2250)
oPrn:Line(nLinha+332,0100,nLinha+332,2250)
oPrn:Line(nLinha+415,0100,nLinha+415,2250)


oPrn:Line(nLinha,0350,nLinha+500,0350)
oPrn:Line(nLinha,0700,nLinha+500,0700)
oPrn:Line(nLinha,1500,nLinha+500,1500)
oPrn:Line(nLinha,2100,nLinha+500,2100)

nLinha += 20
oPrn:Say(nLinha, 0110,"DATA",oFont10N,100)
oPrn:Say(nLinha, 0360,"AREA",oFont10N,100)
oPrn:Say(nLinha, 0710,"NOME COMPLETO",oFont10N,100)
oPrn:Say(nLinha, 1510,"ASSINATURA",oFont10N,100)
oPrn:Say(nLinha, 2110,"%",oFont10N,100)

Return (Nil)

Static Function Observacao()

nLinha += 250

oPrn:Say(nLinha, 0100,"OBS: FAVOR DEVOLVER ESTE FORMULมRIO COM AS DEVIDAS INFORMAวีES E ASSINATURAS NO PRAZO MมXIMO DE 05 DIAS ฺTEIS.",oFont08N,100)
nLinha += 50
oPrn:Say(nLinha, 0100,"A OBRA ACIMA MENCIONADA Sำ TERม EFEITO PARA CRษDITO DE COMISSีES PARA OS REPRESENTANTES QUE TIVEREM ASSINADO ESTE FORMULมRIO ",oFont08N,100)
nLinha += 50
oPrn:Say(nLinha, 0100,"E QUE TIVERAM INFORMAวีES DE TRABALHOS EFETUADOS COM DETALHES.",oFont08N,100)
nLinha += 50

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ AcaX3Cmb       ณ Autor ณ Mauro Sano      ณ Data ณ 09/06/05 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Retorna o conteudo do campo X3_Combo referente ao campo    ณฑฑ
ฑฑณ          ณ passado como parametro.                     				  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function AcaX3Cmb(cCampo,cCod)

Local aSx3Box   := RetSx3Box( Posicione("SX3", 2, cCampo, "X3CBox()" ),,, 1 )
Local cConteudo :=cCod

REturn Upper(AllTrim( aSx3Box[Ascan( aSx3Box, { |aBox| aBox[2] = cConteudo } )][3] ))
