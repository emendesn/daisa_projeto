#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออปฑฑ
ฑฑบPrograma    ณ AC0030    บAutor  ณ Vitor Daniel       บ Data ณ  27/10/10      บฑฑ
ฑฑฬออออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.       ณ IMPRIME O ORCAMENTO 											บฑฑ
ฑฑศออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

20/05/12- MARCIO AFLITOS - ACERTO PARA IMPRESSรO CORRETA DOS SUBTOTAIS

*/

USER FUNCTION FIIMPORC( cNumOrc )

Public  Orc_1  := "SCJ"
Private nPag   := 0

//NOME DA TELA
PRIVATE cTitulo := "Impressใo de Or็amento Instrumento"

//CRIANDO VARIAVEIS DO SISTEMA
PRIVATE cQuery  := ""
PRIVATE cQuery2 := ""
PRIVATE oPrn    := NIL
PRIVATE oFont1  := NIL
PRIVATE oFont2  := NIL
PRIVATE oFont3  := NIL
PRIVATE oFont4  := NIL
PRIVATE oFont5  := NIL
PRIVATE oFont6  := NIL
PRIVATE oFont7  := NIL
PRIVATE oFont8  := NIL
PRIVATE oFont9  := NIL

//DEFININDO AS FONTS
DEFINE FONT oFont2 NAME "Arial" SIZE 0,09 OF oPrn
DEFINE FONT oFont3 NAME "Arial" SIZE 0,11 OF oPrn
DEFINE FONT oFont4 NAME "Arial" SIZE 0,11 OF oPrn BOLD
DEFINE FONT oFont7 NAME "Arial" SIZE 0,09 OF oPrn
DEFINE FONT oFont8 NAME "Arial" SIZE 0,09 OF oPrn BOLD
DEFINE FONT oFont9 NAME "Arial" SIZE 0,16 OF oPrn BOLD

oPrn := TMSPrinter():New(cTitulo)

//MV_PAR01 := IIF(Valtype(cNumOrc)=="C" .and. !Empty(cNumOrc),cNumOrc,SCJ->CJ_NUM)
MV_PAR01 :=SCJ->CJ_NUM

IF .NOT. oPrn:Setup()
	RETURN
ENDIF

oPrn:SetLAndScape()

RegOrc()
//oPrn:End()

oPrn:Preview()

Ms_Flush()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRegOrc     บAutor  ณVitor Daniel        บ Data ณ  05/05/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Dados do Orcamento Contemp                                  บฑฑ
ฑฑบ          ณ                                                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                             บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION RegOrc()
cQuery  := ""


cQuery += " select  "
cQuery += "   ORC.CJ_NUM ORCA, "
cQuery += "   ORC.CJ_FILIAL FILIAL, "
cQuery += "   case when (ORC.CJ_CLIENTE <> '000000') then CLI.A1_EST else PROSP.US_EST end ESTADO, "
cQuery += "   case when (ORC.CJ_CLIENTE <> '000000') then CLI.A1_INSCR else PROSP.US_INSCR end INSCR, "
cQuery += "   case when (ORC.CJ_CLIENTE <> '000000') then CLI.A1_TIPO else PROSP.US_TIPO end DESTINO, "
cQuery += "   SUBSTRING(CJ_EMISSAO,7,2) + '/' + SUBSTRING(CJ_EMISSAO,5,2) + '/' + SUBSTRING(CJ_EMISSAO,1,4) EMISSAO, "
cQuery += "   ORC.CJ_CLIENTE CODCLI, "
cQuery += "   ORC.CJ_LOJA LOJACLI, "  
cQuery += "   CLI.A1_CONTATO CONTATO, " 
cQuery += "   CLI.A1_TEL FONE_CONTATO, "   
cQuery += "   CLI.A1_EMAIL EMAIL_CONTATO, "
// cQuery += "   case when (ORC.CJ_CLIENTE <> '000000') then CLI.A1_NOME when ORC.CJ_PROSPEC = '' then CLI.A1_NOME else PROSP.US_NOME end CLIENTE, "
cQuery += "   case when (ORC.CJ_CLIENTE <> '000000')  then CLI.A1_NOME ELSE PROSP.US_NOME end CLIENTE, "
cQuery += "   CLI.A1_DESCREG REGIAO, "
//cQuery += "   CONT.U5_CONTAT CONTATO, "
//cQuery += "   ' ( ' + RTRIM(CONT.U5_DDD) + ' ) ' + RTRIM(CONT.U5_FONE) FONE_CONTATO, "
//cQuery += "   CONT.U5_EMAIL EMAIL_CONTATO, "
cQuery += "   VEND.A3_NOME VENDEDOR, "
cQuery += "   VEND.A3_TEL TEL_VEND, "
cQuery += "   VEND.A3_EMAIL EMAIL_VEND, "
//cQuery += "   ORC.CJ_OPERADO EMITENTE, "
cQuery += "   ORC.CJ_OBSFAB CODOBS, "
cQuery += "   COND.E4_DESCRI COND_PAGTO, "
cQuery += "	  ORC.CJ_NUM PEDCLI "
//cQuery += "   case when ORC.CJ_PROSPEC IN (' ','F') then CLI.A1_EST ELSE PROSP.US_EST end ESTCLI "
cQuery += " from  "
cQuery += RetSqlName("SCJ") + " ORC "
cQuery += " left outer join "
cQuery += RetSqlName("SA1") + " CLI "
cQuery += " on "
cQuery += "   CLI.A1_COD = ORC.CJ_CLIENTE "
cQuery += "   and CLI.A1_LOJA = ORC.CJ_LOJA "
cQuery += "   and CLI.D_E_L_E_T_ = '' "
cQuery += "   and ORC.D_E_L_E_T_ = '' "
cQuery += "   AND A1_FILIAL = '" + xFilial("SA1") + "'"
cQuery += " left outer join "
cQuery += RetSqlName("SE4") + " COND "
cQuery += " on "
cQuery += "   COND.E4_CODIGO = ORC.CJ_CONDPAG "
cQuery += "   and COND.D_E_L_E_T_ = '' "
cQuery += "   AND E4_FILIAL = '" + xFilial("SE4") + "'"
cQuery += " left outer join "
cQuery += RetSqlName("SA3") + " VEND "
cQuery += " on "
cQuery += "   VEND.A3_COD = ORC.CJ_CODVEND "
cQuery += "   AND A3_FILIAL = '" + xFilial("SA3") + "'"
cQuery += "   and VEND.D_E_L_E_T_ = '' "
//cQuery += " left outer join "
//cQuery += RetSqlName("SU5") + " CONT "
//cQuery += " on "
//cQuery += "   CONT.U5_CODCONT = ORC.CJ_CODCONT "
//cQuery += "   and CONT.D_E_L_E_T_ = '' "
//cQuery += "   AND U5_FILIAL = '" + xFilial("SU5") + "'"
cQuery += " left outer join "
cQuery += RetSqlName("SUS") + " PROSP "
cQuery += " on "
cQuery += "   PROSP.US_COD = ORC.CJ_CLIENTE"//ORC.CJ_PROSPEC "
cQuery += "   and PROSP.D_E_L_E_T_ = '' "
cQuery += "   AND US_FILIAL = '" + xFilial("SUS") + "'"
cQuery += " where  "
cQuery += " ORC.CJ_NUM = '" + MV_PAR01 + "' "
cQuery += "   and ORC.CJ_FILIAL = '" + xFilial("SCJ")+ "' "

cQuery += "   and ORC.D_E_L_E_T_ <> '*' "


If Select("TRB1") > 0
	TRB1->(DbCloseArea())
EndIf
//VALIDA QUERY
cQuery := ChangeQuery(cQuery)
MEMOWRITE("query_or็amento",cQuery )
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TRB1',.T.,.T.)

dbSelectArea(Orc_1)
dbSetOrder(1)
dbSeek(xFilial(Orc_1)+TRB1->ORCA)

while TRB1->(!eof())
	//oPrn:StartPage()
	
	LayOutOP()
	
	TRB1->(dbSkip())
	
	//oPrn:EndPage()
End
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLayOutOP  บAutor  ณVitor Daniel        บ Data ณ  10/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Layout do Orcamento                           			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CTFR0001                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION LayOutOP()
Local nVTmerc	 := 0
Local nQtdPeso	 := 0
Local nItem		 := 0

PRIVATE cTam      := 50
PRIVATE aAllUser  := AllUsers()
PRIVATE aUser     := {}
PRIVATE cUsuar    := RetCodUSR()
PRIVATE lRod      := .T.
PRIVATE cUsuario
PRIVATE cNomeUser:=cCargo:=cEmail:=""

//CABECALHO
Cabec()

lRod:=.F.
cCol := 430

oPrn:Say(cCol,0100,"Cliente:",oFont4)
oPrn:Say(cCol,0350,TRB1->CODCLI + ' - ' + TRB1->CLIENTE,oFont3)                    //CLIENTE

//oPrn:Say(cCol,2300,"Regiใo:",oFont4)
//oPrn:Say(cCol,2450,TRB1->REGIAO,oFont3)

cCol += 60
oPrn:Say(cCol,0100,"A/C:",oFont4)
oPrn:Say(cCol,0350,TRB1->CONTATO,oFont3)
oPrn:Say(cCol,1700,"Fone:",oFont4)
oPrn:Say(cCol,1850,TRB1->FONE_CONTATO,oFont3)
oPrn:Say(cCol,2300,"E-mail:",oFont4)
oPrn:Say(cCol,2450,TRB1->EMAIL_CONTATO,oFont3)

cCol += 60
oPrn:Line(cCol,0080,cCol,3150)

cCol += 20
oPrn:Say(cCol,0100,"A DAISA INDฺSTRIA METALฺRGICA LTDA, agradece pela consulta. A seguir, passamos a cota็ใo solicitada.",oFont4)

cCol += 60
oPrn:Say(cCol,0100,"Representante:",oFont4)
oPrn:Say(cCol,0400,TRB1->VENDEDOR,oFont3)
oPrn:Say(cCol,1700,"Fone:",oFont4)
oPrn:Say(cCol,1850,TRB1->TEL_VEND,oFont3)
oPrn:Say(cCol,2300,"E-mail:",oFont4)
oPrn:Say(cCol,2450,TRB1->EMAIL_VEND,oFont3)

cCol += 60

/*
For i:=1 to Len(aAllUser)
If aAllUser[i][01][01] == TRB1->EMITENTE
cNomeUser := aAllUser[i][01][04]
cEmail    := aAllUser[i][01][14]
Exit
Endif
Next i
*/
/*
DbSelectArea("SU7")
DbSetOrder(1)
If DbSeek(xFilial("SU7") + TRB1->EMITENTE )
	cNomeUser := SU7->U7_NOME
EndIf
*/
//PEGA OS DADOS DO CFOP
cQuery5  := ""

if SELECT ("TRB5") > 0
	dbSelectArea("TRB5")
	dbCloseArea("TRB5")
endif

cQuery5  += " SELECT DISTINCT "
cQuery5  += "   CK_NUM ORCAMENTO, "
cQuery5  += "   F4_CF CF, "
cQuery5  += "   F4_TEXTO TEXTO "
cQuery5  += " FROM "
cQuery5  += RetSqlName("SCK") + " PED "
cQuery5  += " LEFT OUTER JOIN "
cQuery5  += RetSqlName("SF4") + " TES "
cQuery5  += " ON "
cQuery5  += "   F4_CODIGO = CK_TES "
cQuery5  += "   AND TES.D_E_L_E_T_ <> '*' "
cQuery5  += "   AND F4_FILIAL = '" + xFilial("SF4") + "' "
cQuery5  += " WHERE "
cQuery5  += "   CK_NUM = '" + TRB1->ORCA + "' "
cQuery5  += "   and PED.D_E_L_E_T_ <> '*' "
cQuery5  += "   and PED.CK_FILIAL  = '" + xFilial("SCK") + "' "
cQuery5  += " order by 2 "

//VALIDA QUERY
cQuery5 := ChangeQuery(cQuery5)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery5),'TRB5',.T.,.T.)

cCFOP := ""
While TRB5->(!Eof()) .And. TRB5->ORCAMENTO == TRB1->ORCA
	cCFOP += TRB5->CF + " - " + TRB5->TEXTO + ", "
	
	TRB5->(dbSkip())
End

oPrn:Say(cCol,0100,"Emitente:",oFont4)
//oPrn:Say(cCol,0400,cNomeUser,oFont3)
oPrn:Say(cCol,1000,"CFOP:",oFont4)
oPrn:Say(cCol,1200,cCFOP,oFont3)

cCol += 80
oPrn:Line(cCol,0080,cCol,3150)

//VERIFICA SE O CLIN ATINGE 2400
fVerPag()

//CABECALHO ITENS DO ORCAMENTO
cCol += 10

//PARTE 4
oPrn:Say(cCol,0100,"Item",oFont8)
oPrn:Say(cCol,0200,"C๓digo",oFont8)
oPrn:Say(cCol,0600,"Descri็ใo",oFont8)
oPrn:Say(cCol,1650,"Qtd.",oFont8)
oPrn:Say(cCol,1800,"Apr.",oFont8)
oPrn:Say(cCol,1970,"Val. Unit.",oFont8)
oPrn:Say(cCol,2200,"% ICMS",oFont8)
oPrn:Say(cCol,2400,"% Desc",oFont8)
oPrn:Say(cCol,2600,"Val. Total",oFont8)
oPrn:Say(cCol,2850,"% IPI",oFont8)
oPrn:Say(cCol,2980,"Item Cli.",oFont8)

cCol += 50
oPrn:Line(cCol,0080,cCol,3150)

cQuery2  := ""


cQuery2  += " select "
cQuery2  += "   CK_NUM ORCAMENTO, "
cQuery2  += "   CK_ITEM ITEM, "
cQuery2  += "   RTRIM(I_ORC.CK_PRODUTO) COD_PRODUTO, "
cQuery2  += "   RTRIM(B1_COD)CODIGO, "
cQuery2  += "   RTRIM(B1_DESC) PRODUTO, "
cQuery2  += "   B1_UM UNIDADE, "
cQuery2  += "   CK_QTDVEN QTDE, "
cQuery2  += "   CK_PRCVEN VAL_UNIT, "
cQuery2  += "   CK_VALOR VALOR, "
cQuery2  += "   CK_ITECLI ITEM, "
cQuery2  += "   CASE WHEN F4_IPI = 'S' THEN B1_IPI ELSE 0 END IPI, "
cQuery2  += "   B1_PICM ICMS, "
cQuery2  += "   CJ_DESC1 DESCONTO, "//CK_DESC DESCONTO, "
cQuery2  += "   F4_ICM ICM, "
cQuery2  += "   B1_POSIPI CLASSFISC "
cQuery2  += " from "
cQuery2  += RetSqlName("SCK") + " I_ORC "
cQuery2  += " left outer join "
cQuery2  += RetSqlName("SB1") + " PROD "
cQuery2  += " on "
cQuery2  += "   PROD.B1_COD = I_ORC.CK_PRODUTO "
cQuery2  += "   AND B1_FILIAL = '" + xFilial("SB1") + "'"
cQuery2  += "   AND PROD.D_E_L_E_T_ <> '*'"
cQuery2  += " left outer join "
cQuery2  += RetSqlName("SCJ") + " ORC "
cQuery2  += " on "
cQuery2  += "   ORC.CJ_NUM = I_ORC.CK_NUM "
cQuery2  += "   AND CJ_FILIAL = '" + xFilial("SCJ") + "'"
cQuery2  += "   AND ORC.D_E_L_E_T_ <> '*'"
cQuery2  += " left outer join "
cQuery2  += RetSqlName("SF4") + " TES "
cQuery2  += " on "
cQuery2  += "   TES.F4_CODIGO = I_ORC.CK_TES "
cQuery2  += "   AND TES.D_E_L_E_T_ <> '*' "
cQuery2  += "   AND F4_FILIAL = '" + xFilial("SF4") + "'"
cQuery2  += " where "
cQuery2  += "   I_ORC.D_E_L_E_T_ <> '*' "
cQuery2  += "   and CK_NUM = '" + TRB1->ORCA+ "' "      //PEGAR O NUMERO DO ORCAMENTO
cQuery2  += "   and CK_FILIAL = '" + TRB1->FILIAL+ "' " //PEGAR A FILIAL DO ORCAMENTO
cQuery2  += " ORDER BY CK_NUM, CK_ITEM"

If Select("TRB2") > 0
	TRB2->(DbCloseArea())
EndIf
//VALIDA QUERY
cQuery2 := ChangeQuery(cQuery2)

MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),'TRB2',.T.,.T.)},"Aguarde...") //"Selecionando Registros..."

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLOOPING PARA PEGAR ITENS DO ORCAMENTOณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nPorc := TRB2->DESCONTO
While TRB2->(!Eof()) .And. TRB2->ORCAMENTO == TRB1->ORCA
	
	cColu := 0
	
	//VERIFICA SE O CLIN ATINGE 2400
	Iif( cCol+100 > 2350, (cCol:=2351), NIL)  //teste se vai caber o item na pagina
	fVerPag()
	
	nPerRet   := 0                // Percentual de retorno
	cEstado   := GetMV("MV_ESTADO")
	tNorte    := GetMV("MV_NORTE")
	
	cEstCli   := TRB1->ESTADO
	cInscrCli := TRB1->INSCR


DbSelectArea("SA1")
DbSetOrder(1)

If SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
	//If SubStr(M->CJ_DESCCLI,1,10) == SubStr(SA1->A1_NOME,1,10)
		cEstCli:= SA1->A1_EST
	//EndIf
EndIf


DbSelectArea("SUS")
DbSetOrder(1)

If SUS->(DbSeek(xFilial("SUS")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
	//If SubStr(M->CJ_DESCCLI,1,10) == SubStr(SUS->US_NOME,1,10)
		cEstCli:= SUS->US_EST
	//EndIf
EndIf


	
	If TRB2->ICM == "S"
		If TRB1->DESTINO == "F" .and. Empty(cInscrCli)
			nPerRet := iif(TRB2->ICMS>0,TRB2->ICMS,GetMV("MV_ICMPAD"))
		Elseif TRB1->DESTINO == "F" .and. ALLTRIM(UPPER(cInscrCli)) == "ISENTO"
			nPerRet := iif(TRB2->ICMS>0,TRB2->ICMS,GetMV("MV_ICMPAD"))
		Elseif TRB2->ICMS > 0 .And. cEstCli == cEstado
			nPerRet := TRB2->ICMS
		Elseif cEstCli == cEstado
			nPerRet := GetMV("MV_ICMPAD")
		Elseif cEstCli $ tNorte .And. At(cEstado,tNorte) == 0
			nPerRet := 7
		Elseif TRB1->DESTINO == "X"
			nPerRet := 13
		Else
			nPerRet := 12
		Endif
	Endif
	
	oPrn:Say(cCol+cTam,0120,TRB2->ITEM,oFont7)                                	//ITEM
	
	cCodCli := POSICIONE("SA7",1,xFilial("SA7")+TRB1->CODCLI+TRB1->LOJACLI+TRB2->COD_PRODUTO,"A7_CODCLI")
	oPrn:Say(cCol+cTam,0160,TRB2->CODIGO,oFont7)                                	//Codigo
	
	//VERIFICA QUANTIDADE DE CARACTERES
	cCodDesc := Alltrim(TRB2->PRODUTO)
   /*	if Len(cCodDesc) <= 45
		oPrn:Say(cCol+cTam,0410,cCodDesc,oFont7)									//PRODUTO
		cColu := cCol+cTam
	ElseIf Len(cCodDesc) <= 110
		oPrn:Say(cCol+cTam,0610,     SUBSTR(cCodDesc,1,45),oFont7)
		oPrn:Say(cCol+cTam+cTam,0610,SUBSTR(cCodDesc,46,45),oFont7)
		cColu := cCol+cTam+cTam
	Else
		oPrn:Say(cCol+cTam,0610,          SUBSTR(cCodDesc,1,45),oFont7)
		oPrn:Say(cCol+cTam+cTam,0610,     SUBSTR(cCodDesc,46,45),oFont7)
		oPrn:Say(cCol+cTam+cTam+cTam,0610,SUBSTR(cCodDesc,91,45),oFont7)
		cColu := cCol+cTam+cTam+cTam
	EndIf */
	
	oPrn:Say(cCol+cTam,/*1680*/0200,Transform(TRB2->QTDE,"@ 999,999.99"),oFont7)      	//QTDE
	oPrn:Say(cCol+cTam,1830,TRB2->UNIDADE,oFont7)								//UNIDADE
	oPrn:Say(cCol+cTam,2000,Transform(TRB2->VAL_UNIT,"@E 999,999.99"),oFont7)	//VALOR UNITARIO
	oPrn:Say(cCol+cTam,2230,Transform(nPerRet,"@ 99"),oFont7)					//ICMS
	oPrn:Say(cCol+cTam,2400,Transform(TRB2->DESCONTO,"@E 999.99"),oFont7)		//DESCONTO
	oPrn:Say(cCol+cTam,2600,Transform(TRB2->VALOR,"@E 999,999,999.99"),oFont7)	//VALOR TOTAL
	oPrn:Say(cCol+cTam,2900,Transform(TRB2->IPI,"@ 99"),oFont7)					//IPI
	oPrn:Say(cCol+cTam,2980,TRB2->ITEM,oFont7)			      					//CODIGO CLIENTE
	
	cCol  := cColu+50
	
	OPRN:LINE(cCol,0080,cCol,3150)
	
	cCol  := cCol - 20
	TRB2->(dbSkip())
End

//VERIFICA SE O CLIN ATINGE 2400
fVerPag()

cCol := cCol+30

//TOTAL ITENS DO ORCAMENTO
cQuery3  := ""


cQuery3  += " select "
cQuery3  += "   SA1.A1_COD CODCLI , "
cQuery3  += "   SA1.A1_LOJA LOJA, "
cQuery3  += "   SA1.A1_TIPO TIPOCLI, "
cQuery3  += "   SCJ.CJ_FRETE FRETE, "
cQuery3  += "   SCJ.CJ_DESPESA, "
//cQuery3  += "   SCJ.CJ_OPER TIPO, "
cQuery3  += "   SCJ.CJ_NUM ORCAMENTO, "
cQuery3  += "   SCK.CK_ITEM ITEM_ORC, "
cQuery3  += "   SCK.CK_PRODUTO PRODUTO, "
cQuery3  += "   SCK.CK_TES TES, "
cQuery3  += "   SCK.CK_QTDVEN QUANTIDADE, "
cQuery3  += "   SCK.CK_PRCVEN  PRECO,"
cQuery3  += "   ((SCJ.CJ_DESC1*SCK.CK_VALOR)/100) DESCONTO, " //cQuery3  += "   SCK.CK_VALDESC DESCONTO,"
cQuery3  += "   SCK.CK_VALOR VALOR"
cQuery3  += " from "
cQuery3  += RetSqlName("SCJ") + " SCJ, "
cQuery3  += RetSqlName("SCK") + " SCK, "
cQuery3  += RetSqlName("SA1") + " SA1 "
cQuery3  += " where   SCJ.CJ_NUM = SCK.CK_NUM "
cQuery3  += "   AND SCJ.CJ_CLIENTE = SA1.A1_COD AND SCJ.CJ_LOJA = SA1.A1_LOJA AND SCJ.D_E_L_E_T_ = ''"
cQuery3  += "   AND SA1.D_E_L_E_T_ = '' AND SCK.D_E_L_E_T_ = ''
cQuery3  += "   AND CK_NUM = '" + TRB1->ORCA+ "'"
cQuery3  += "   AND CK_FILIAL = '" + xFilial("SCK") + "'"
cQuery3  += "   AND CJ_FILIAL = '" + xFilial("SCJ") + "'"

If Select("TRB3") > 0
	TRB3->(DbCloseArea())
EndIf
//VALIDA QUERY
cQuery3 := ChangeQuery(cQuery3)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery3),'TRB3',.T.,.T.)

VAL_SUF		:= 0
VAL_PRD 	:= 0
VAL_IPI 	:= 0
VAL_TOT 	:= 0
VAL_ST  	:= 0
VAL_FER	:= 0
ST_AUX		:= 0
VAL_FRETE	:= TRB3->FRETE
VAL_DESPESA := TRB3->CJ_DESPESA
VAL_DESCONTO:= 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณcalculo dos valores fiscais                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializa a funcao fiscal                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nTOT_ST := 0
DBSelectArea("SB1")
WHILE !TRB3->(EOF())
	
	nfreteIt	:= (TRB3->VALOR / nVTmerc)* TRB3->FRETE
	
	nItem++
	MaFisSave()
	MaFisEnd()
	MaFisIni((TRB3->CODCLI),;// 1-Codigo Cliente/Fornecedor
	TRB3->LOJA,;		// 2-Loja do Cliente/Fornecedor
	"C",;				// 3-C:Cliente , F:Fornecedor
	"N",;
	TRB3->TIPOCLI,;		// 5-Tipo do Cliente/Fornecedor
	Nil,;
	Nil,;
	Nil,;
	Nil,;
	"MATA641")
	
	
	MaFisAdd(TRB3->PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
	TRB3->TES,;	   	// 2-Codigo do TES ( Opcional )
	TRB3->QUANTIDADE,;  	// 3-Quantidade ( Obrigatorio )
	TRB3->PRECO,;		  	// 4-Preco Unitario ( Obrigatorio )
	0,; //TRB3->DESCONTO,; 	// 5-Valor do Desconto ( Opcional )
	"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
	"",;				// 7-Serie da NF Original ( Devolucao/Benef )
	0,;					// 8-RecNo da NF Original no arq SD1/SD2
	0,;					// 9-Valor do Frete do Item ( Opcional )
	0,;					// 10-Valor da Despesa do item ( Opcional )
	0,;					// 11-Valor do Seguro do item ( Opcional )
	0,;					// 12-Valor do Frete Autonomo ( Opcional )
	TRB3->VALOR,;			// 13-Valor da Mercadoria ( Obrigatorio )
	0)					// 14-Valor da Embalagem ( Opiconal )
	
	
	SB1->(dbSetOrder(1))
	If SB1->(MsSeek(xFilial("SB1")+TRB3->PRODUTO))
		nQtdPeso := TRB3->QUANTIDADE*SB1->B1_PESO
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAltera peso para calcular frete              ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	MaFisAlt("IT_PESO",nQtdPeso,nItem)
	MaFisAlt("IT_PRCUNI",TRB3->PRECO,nItem)
	MaFisAlt("IT_VALMERC",TRB3->VALOR,nItem)
	
	//nValFrete:=TRB3->VALOR_FRETE/nItem
	
	MaFisAlt("NF_FRETE",nfreteIt)
	MaFisWrite(1)
	
	ST_AUX := MaFisRet(,"NF_VALSOL")
	
	DbSelectArea("SF4")
	SF4->(DbSetOrder(1))
	If SF4->(DbSeek(xFilial("SF4")+TRB3->TES))
		If SF4->F4_ART274 $ "2/ "
			nTOT_ST += ST_AUX
		EndIf
	EndIf
	
	VAL_FER	 += MaFisRet(1,"LF_ICMSRET")
	VAL_PRD 	 += MaFisRet(,"NF_VALMERC")
	VAL_IPI 	 += MaFisRet(,"NF_VALIPI")
	VAL_TOT 	 += MaFisRet(,"NF_TOTAL")
	VAL_ST  	 += ST_AUX//MaFisRet(,"NF_VALSOL")
	VAL_SUF		 += MaFisRet(,"NF_DESCZF")
	VAL_DESCONTO += TRB3->DESCONTO//MaFisRet(,"NF_DESCONTO")
	//VAL_FRETE    += MaFisRet(,"NF_FRETE")
	//VAL_DESPESA  += MaFisRet(,"NF_DESPESA")
	
	TRB3->(DBSKIP())
END

oPrn:Say(cCol,0100,"Subtotal ",oFont4)
oPrn:Say(cCol,0500,"Frete ",oFont4)
oPrn:Say(cCol,0900,"Despesa ",oFont4)
oPrn:Say(cCol,1300,"IPI ",oFont4)
oPrn:Say(cCol,1700,"S.T. ",oFont4)
oPrn:Say(cCol,2100,"Desconto ",oFont4)
//oPrn:Say(cCol,2500,"Desc. Suframa",oFont4)
oPrn:Say(cCol,2900,"Total Geral ",oFont4)
cCol += 50

nTOTAL := VAL_PRD + VAL_FRETE + VAL_DESPESA + VAL_IPI + nTOT_ST-VAL_SUF



oPrn:Say(cCol,0100,Transform(VAL_PRD,     "@E 999,999,999.99"),oFont3)
oPrn:Say(cCol,0500,Transform(VAL_FRETE,   "@E 999,999,999.99"),oFont3)
oPrn:Say(cCol,0900,Transform(VAL_DESPESA, "@E 999,999,999.99"),oFont3)
oPrn:Say(cCol,1300,Transform(VAL_IPI,     "@E 999,999,999.99"),oFont3)

/*If SCJ->CJ_PROSPEC
	For i:= 1 to Len(aObj[8]:AARRAY)
		If aObj[8]:AARRAY[i][1] == "ICR"
			oPrn:Say(cCol,1700,Transform(aObj[8]:AARRAY[i][5],"@E 999,999,999.99"),oFont3)
		EndIf
	Next i		
Else 
*/
	oPrn:Say(cCol,1700,Transform(VAL_ST,      "@E 999,999,999.99"),oFont3)
//EndIf
//oPrn:Say(cCol,1700,Transform(,      "@E 999,999,999.99"),oFont3)
oPrn:Say(cCol,2100,Transform(VAL_DESCONTO,"@E 999,999,999.99"),oFont3)
//oPrn:Say(cCol,2500,Transform(VAL_SUF,	  "@E 999,999,999.99"),oFont3)
oPrn:Say(cCol,2900,Transform(nTOTAL,      "@E 999,999,999.99"),oFont3)
cCol += 50
//fVerPag()
OPRN:LINE(cCol,0080,cCol,3150)

IF cCol+450 >= 2350   //30/05/12-Marcio Aflitos-Aqui testa se vai caber o rodape final com todas as observa็๕es
	cCol:=2351
ENDIF
fVerPag()

//OBSERVACAO PADRAO
cCol += 80
oPrn:Say(cCol,0100,"Observa็๕es Or็amento ",oFont4)
cCol+= 50	

//If TRB1->ESTCLI == "SP"
nValObs := 1200.00
//Else
//	nValObs := 800.00
//EndIf

cValObs := Alltrim(Transform(nValObs,"@E 999,999,999.99"))
DbSelectArea("SCJ")
DbSeek(xFilial("SCJ")+TRB1->ORCA)
OBS1 := 	"Validade da proposta: 15 Dias"+chr(13) + chr(10)+;
"Desconto Concedido: "+ Alltrim(Transform(nPorc,"@E 999.99"))+chr(13) + chr(10)+;
"Faturamento Mํnimo: R$ "+cValObs+" (valor lํquido)"+chr(13) + chr(10)+;
"Prazo de expedi็ใo de nossa Fแbrica: "+chr(13) + chr(10)+;
"Frete CIF: pedidos acima de R$ "+cValObs+" com entrega na Grande Sใo Paulo. Frete FOB: Pedidos abaixo de R$ "+cValObs+" e demais regi๕es de entrega."+chr(13) + chr(10)+;
"Favor verificar se os itens e quantidades cotados estใo de acordo com o solicitado."

//OBS1 := M->CJ_OBS

cColu := cCol

//USANDO O MEMOLINE PARA IMPRESSAO
If !EMPTY(OBS1)
	cJ  := 200	//TAMANHO DA QUEBRA
	
	t_linhas := mlcount(AllTrim(OBS1),cJ,3,.t.)
	
	for f:= 1 to t_linhas
		oPrn:Say(cColu,0100,memoline(OBS1,cJ,f,3,.t.) ,oFont7) //SINTAXE = MEMOLINE(CAMPO,TAMANHO_QUEBRA,LINHA_IMPRESSA,3,.T.)
		
		cColu += 50
		cCol  := cColu
		fVerPag()
	next f
Endif

cCol += 30
OPRN:LINE(cCol,0080,cCol,3150)

cCol += 30

//VERIFICA SE O CLIN ATINGE 2400
fVerPag()

oPrn:Say(cCol,0100,"Sauda็๕es:",oFont8)

cCol += 210

//LINHA DO USUARIO
oPrn:Line(cCol,0080,cCol,1000)

oPrn:Say(cCol,0110,SM0->M0_NOMECOM,oFont3)

Return

//ฺฤฤฤฤฤฤฤฤฤฟ
//ณCabecalhoณ
//ภฤฤฤฤฤฤฤฤฤู
Static Function Cabec()
//IMPRESSAO DO DESENHO(LOGO)
DO CASE
	Case xFilial("SCJ") == "01"//DAISA MATRIZ
		cLogo  := '\system\logo_daisa.jpg'
	Case xFilial("SCJ") == "02"//FUNDICAO
		cLogo  := '\system\logo_fundicao.jpg'
	Case xFilial("SCJ") == "03"//DAIBRAS
		cLogo  := '\system\logo_daibras.jpg'
	Case xFilial("SCJ") == "04"//DAISA INDUSTRIAL
		cLogo  := '\system\logo_daisa.jpg'
	Case xFilial("SCJ") == "05"//DAISA COMERCIO
		cLogo  := '\system\logo_daisa.bmp'
	Case xFilial("SCJ") == "99"//EMPRESA TESTE
		cLogo  := '\system\logo_daisa.bmp'
ENDCASE

oPrn:SayBitmap( 0080, 0100,alltrim(cLogo),0480,0200)

DbSelectArea("SM0")
oPrn:Say(0080,0810,SM0->M0_NOMECOM,oFont9)

oPrn:Say(0200,0810,Alltrim(SM0->M0_ENDENT) + ' - BAIRRO: ' + Alltrim(SM0->M0_BAIRENT) + ' - CIDADE: ' + Alltrim(SM0->M0_CIDENT) + ' - CEP: ' + Alltrim(SM0->M0_CEPENT),oFont7)

//oPrn:Say(0250,2780,"Or็amento Nบ:",oFont4)
//oPrn:Say(0250,2930,TRB1->ORCA,oFont4)                  	  //NUMERO ORCAMENTO

oPrn:Say(0250,0810,'ESTADO: ' + Alltrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + SM0->M0_TEL + ' - FAX: ' + SM0->M0_FAX,oFont7)
oPrn:Say(0300,0810,'CNPJ - ' + Transform(SM0->M0_CGC,"@r 99.999.999/9999-99") + ' - INSCR. ESTADUAL: ' + Transform(SM0->M0_INSC,"@r 999.999.999.999"),oFont7)

oPrn:Say(0350,0100,"Or็amento Nบ:",oFont9)
oPrn:Say(0350,0500,TRB1->ORCA,oFont9)                  	  //NUMERO ORCAMENTO

oPrn:Say(0200,2780,"Data:",oFont4)
oPrn:Say(0200,2930,TRB1->EMISSAO,oFont3)                    //DATA EMISSAO
oPrn:Say(0250,2780,"Ped. Cliente:",oFont4)
oPrn:Say(0300,2930,TRB1->PEDCLI,oFont3)                  	  //NUMERO ORCAMENTO

nPag += 1
oPrn:Say(0360,2780,"Pแgina: ",oFont4)
oPrn:Say(0360,2930,AllTrim(Str(nPag)),oFont3) //NUMERO PAGINA

oPrn:Line(0420,0080,0420,3150)

//CABECALHO ITENS DO ORCAMENTO
If lRod = .F.
	lRod:=.T.
	cCol := cCol+30
	
	oPrn:Say(cCol,0100,"Item",oFont8)
	oPrn:Say(cCol,0200,"C๓digo",oFont8)
	oPrn:Say(cCol,0600,"Descri็ใo",oFont8)
	oPrn:Say(cCol,1650,"Qtd.",oFont8)
	oPrn:Say(cCol,1800,"Apr.",oFont8)
	oPrn:Say(cCol,1970,"Val. Unit.",oFont8)
	oPrn:Say(cCol,2200,"% ICMS",oFont8)
	oPrn:Say(cCol,2400,"% Desc",oFont8)
	oPrn:Say(cCol,2600,"Val. Total",oFont8)
	oPrn:Say(cCol,2850,"% IPI",oFont8)
	oPrn:Say(cCol,2980,"Item Cli.",oFont8)
	
	/*
	oPrn:Say(cCol,0100,"Item",oFont8)
	oPrn:Say(cCol,0200,"Produto",oFont8)
	oPrn:Say(cCol,1500,"Qtd.",oFont8)
	oPrn:Say(cCol,1700,"Apr.",oFont8)
	oPrn:Say(cCol,1800,"Val. Unit.",oFont8)
	oPrn:Say(cCol,2100,"% ICMS",oFont8)
	oPrn:Say(cCol,2300,"% Desc",oFont8)
	oPrn:Say(cCol,2500,"Val. Total",oFont8)
	oPrn:Say(cCol,2700,"% IPI",oFont8)
	oPrn:Say(cCol,2900,"Item Cli.",oFont8)
	*/
	cCol += 50
	oPrn:Line(cCol,0080,cCol,3150)
EndIf
Return

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncao para analise de paginasณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function fVerPag()
If ( cCol >= 2350 )
	oPrn :EndPage()
	cCol  := 0400
	oPrn :StartPage()
	Cabec()
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA415MNU  บAutor  ณMarcel Medeiros     บ Data ณ  05/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณP.E para adicionar botao no Orcamento Faturamento           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ faturamento/Orcamento                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EDI_MA415MNU()

aAdd(aRotina,{"Imprime Daisa","U_FIMPORC"  	, 0 , 4, 0,NIL})

Return (aRotina)
