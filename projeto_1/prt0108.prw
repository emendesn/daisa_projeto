#INCLUDE "PROTHEUS.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "rwmake.ch"  
#INCLUDE "PRINT.CH"
#INCLUDE "Ap5Mail.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออปฑฑ
ฑฑบPrograma  ณ PRT0108   บAutor  ณVinicius                  บ Data ณ 20/09/11 บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.     ณ IMPRIME Solicita็ใo de Compra   				                			  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

USER FUNCTION PRT0108()
Private nPag 

//NOME DA TELA                                                   
PRIVATE cTitulo := "Impressใo de Solicita็ใo de Cota็ใo"

//CRIANDO VARIAVEIS DO SISTEMA
PRIVATE cQuery  := ""
PRIVATE cQuery2 := ""

AjustaSX1("MV_PRT0108")

If !Pergunte("MV_PRT0108",.T.)
	Return()
EndIf	

//fa็o algumas consistencias
If !empty(MV_PAR01) .And. empty(MV_PAR02)                           
  MV_PAR02 := MV_PAR01
Elseif empty(MV_PAR01) .And. empty(MV_PAR02)                           
  Alert("Favor informar o n๚mero de solicita็ใo")
  Return
Endif     

Processa({|lEnd|RegOrc1()},"Processando impressใo","Colhendo informa็๕es...")      

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณRegOrc1  บAutor  ณVinicius (fonte base Vitor)บ Data ณ 20/09/11บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Dados da Solicita็ใo Daisa                                  บฑฑ
ฑฑบ          ณ                                                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                             บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION RegOrc1()
LOCAL   cQuery  := ""
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
PRIVATE oFont10 := NIL


//DEFININDO AS FONTS
DEFINE FONT oFont1  NAME "Arial" SIZE 0,14 OF oPrn 
DEFINE FONT oFont2  NAME "Arial" SIZE 0,20 OF oPrn BOLD
DEFINE FONT oFont3  NAME "Arial" SIZE 0,08 OF oPrn
DEFINE FONT oFont4  NAME "Arial" SIZE 0,10 OF oPrn BOLD
DEFINE FONT oFont7  NAME "Arial" SIZE 0,08 OF oPrn
DEFINE FONT oFont8  NAME "Arial" SIZE 0,08 OF oPrn BOLD
DEFINE FONT oFont9  NAME "Arial" SIZE 0,12 OF oPrn BOLD
DEFINE FONT oFont10 NAME "Arial" SIZE 0,07 OF oPrn BOLD

//RODO O AGRUPAMENTO
cQuery := " SELECT SC8.C8_FORNECE,SC8.C8_LOJA,SC8.C8_NUM "
cQuery += " FROM "+ RetSqlName("SC8")+ " SC8 " 
cQuery += " WHERE SC8.C8_FILIAL = '"+xFilial("SC8")/*cFilAnt*/+"'"
cQuery += " AND SC8.D_E_L_E_T_ <> '*'"
cQuery += " AND SC8.C8_NUM BETWEEN '"+MV_PAR01+"' and '"+MV_PAR02+"'"
cQuery += " GROUP BY SC8.C8_FORNECE,SC8.C8_LOJA,SC8.C8_NUM" 
VerTabela("PRT108_1")
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"PRT108_1",.T.,.T.)

PRT108_1->(DbGotop())
while PRT108_1->(!eof())
	nPag   := 0 
	
	oPrn   := NIL	
	oPrn   := TMSPrinter():New(cTitulo)
	oPrn:StartPage()
	
	LayOutOP1()
	
	PRT108_1->(dbSkip())
	
	oPrn:EndPage()
	
  //nova implementa็ใo
	oPrn:SetPortrait()
  oPrn:Setup()  
  oPrn:Preview()  
  oPrn:End()
  Ms_Flush()
End

PRT108_1->(DbCloseArea())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณLayOutOP1 บAutorณ Vinicius (fonte base Vitor)บData ณ20/09/11 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do Layout de Solicita็ใo de Cota็ใo              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AC0013                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION LayOutOP1()
Local	 cNome	   := ""
Local	 cEmail    := ""
public cTam      := 60
public aAllUser  := AllUsers()
public aUser     := {} 
public lRod      := .T. 
public cUsuario
public cCol
Public Orc_1     := "SC1" 
public lin1      := 250    //Vinicius

oPrn:Line(0050,0080,0050,2300)
oPrn:Line(0050,0080,3200,0080)
oPrn:Line(3200,0080,3200,2300)
oPrn:Line(0050,2300,3200,2300)    

//CABECALHO
Cabec(lRod)

//DADOS DO FORNECEDOR  
cQuery := " "
cQuery += " SELECT DISTINCT "
cQuery += "   C8_NUMPED PEDIDO, "
cQuery += "   C8_EMISSAO EMISSAO, "
cQuery += "   C8_FORNECE, "
cQuery += "   A2_NOME FORNECEDOR, "   
cQuery += "   C8_COND CONDICAO1,"
cQuery += "   '0' COTACAO,"
cQuery += "	  C8_MOEDA MOEDA, "
cQuery += "   E4_DESCRI CONDICAO2, "
cQuery += "   A2_END ENDER, "
cQuery += "   A2_BAIRRO BAIRRO, "
cQuery += "   A2_MUN MUN, "
cQuery += "   A2_EST ESTADO, "
cQuery += "   A2_CEP CEP, "
cQuery += "   A2_DDD DDD, "
cQuery += "   A2_TEL FONE, "
cQuery += "   A2_FAX FAX, "
cQuery += "   A2_CGC CGC_CPF, "
cQuery += "   A2_INSCR IE_RG, "
cQuery += "   A2_EMAIL EMAIL, "
cQuery += "   A2_CONTATO CONTATO, "
cQuery += "   A2_CONTATO CONTATO, "
cQuery += "   CASE "
cQuery += "     WHEN C7_TPFRETE  = 'C' THEN 'CIF' "  // nao tem frete  na SC1
cQuery += "     ELSE 'FOB' "
cQuery += "   END TIPO_FRETE, "
cQuery += "   YA_DESCR PAIS "
cQuery += " FROM " + RetSqlName("SC8") + " SC8 "
cQuery += " JOIN " + RetSqlName("SA2") + " SA2 "
cQuery += " ON "
cQuery += "   SC8.C8_FORNECE = SA2.A2_COD SC8.C8_LOJA= SA2.A2_LOJA"
cQuery += "   AND A2_FILIAL = '"+xFilial("SA2")+"'"
cQuery += "   AND SA2.A2_COD = '"+PRT108_1->C8_FORNECE+ "' "
cQuery += "   AND SA2.A2_LOJA = '"+PRT108_1->C8_LOJA+ "' "
cQuery += "   AND SA2.D_E_L_E_T_ <> '*'"
cQuery += " LEFT OUTER JOIN " + RetSqlName("SC7") + " SC7 "   //Vinicius
cQuery += " ON "
cQuery += "   C8_NUMPED = C7_NUM "  
cQuery += "   AND C8_FILIAL = C7_FILIAL "
cQuery += "   AND SC7.D_E_L_E_T_ <> '*'"
cQuery += " LEFT OUTER JOIN " + RetSqlName("SYA") + " SYA "
cQuery += " ON "
cQuery += "   YA_CODGI = A2_PAIS "
cQuery += "	  AND YA_FILIAL = '"+xFilial("SYA")+"'"
cQuery += "   AND SYA.D_E_L_E_T_ <> '*'"
cQuery += " LEFT OUTER JOIN " + RetSqlName("SE4") + " COND "
cQuery += " ON "
cQuery += "   COND.E4_CODIGO = SC8.C8_COND "
cQuery += "	  AND E4_FILIAL = '"+xFilial("SE4")+"'"
cQuery += "   AND COND.D_E_L_E_T_ <> '*'"
cQuery += " WHERE "
cQuery += "   SC8.D_E_L_E_T_ <> '*' "
cQuery += "   AND SC8.C8_NUM = '"+cValToChar(PRT108_1->C8_NUM)+ "' "
cQuery += "   AND SC8.C8_FILIAL = '"+cFilAnt+"'"
cQuery += " ORDER BY 1 "

VerTabela("TRB1")
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)

//Fornecedor
oPrn:Line(0335 + lin1,0080,0335 + lin1,2300)  //Vinicius

oPrn:Say(0350 + lin1,0100,"Fornecedor:",oFont8)
oPrn:Say(0350 + lin1,0350,cValToChar(TRB1->C8_FORNECE) + " - " +Alltrim(TRB1->FORNECEDOR),oFont3)

oPrn:Say(0350 + lin1,1700,"Data:",oFont8)                  
cData := subs(TRB1->EMISSAO,7,2)+'/'+subs(TRB1->EMISSAO,5,2)+'/'+subs(TRB1->EMISSAO,1,4)

oPrn:Say(0350 + lin1,1800,cData,oFont3)
//oPrn:Say(0350 + lin1,2000,"Hora:",oFont8)

cHora := subs(time(),01,02) + ":" + subs(time(),04,02) + ":" + substr(time(),07,02)
//oPrn:Say(0350 + lin1,2100,cHora,oFont3)

oPrn:Line(0395 + lin1,0080,0395 + lin1,2300)

oPrn:Say(0410 + lin1,0100,"Endere็o:",oFont8)
oPrn:Say(0410 + lin1,0350,TRB1->ENDER,oFont3)
oPrn:Say(0410 + lin1,1400,"Bairro:",oFont8)
oPrn:Say(0410 + lin1,1550,TRB1->BAIRRO,oFont3)

oPrn:Line(0455 + lin1,0080,0455 + lin1,2300)

oPrn:Say(0470 + lin1,0100,"Cidade:",oFont8)
oPrn:Say(0470 + lin1,0350,TRB1->MUN,oFont3)
oPrn:Say(0470 + lin1,1400,"Estado:",oFont8)
oPrn:Say(0470 + lin1,1550,TRB1->ESTADO,oFont3)
oPrn:Say(0470 + lin1,1700,"I. Estadual:",oFont8)
oPrn:Say(0470 + lin1,1900,Transform(TRB1->IE_RG,"@r 999.999.999.999"),oFont3)
                       
oPrn:Line(0515 + lin1,0080,0515 + lin1,2300)

oPrn:Say(0530 + lin1,0100,"CNPJ:",oFont8)   

If Len(TRB1->CGC_CPF) = 14
	cCNPJ := Transform(TRB1->CGC_CPF,"@r 99.999.999/9999-99")
Else
	cCNPJ := Transform(TRB1->CGC_CPF,"@r 999.999.999-99")
EndIf

oPrn:Say(0530 + lin1,0350,cCNPJ,oFont3)
oPrn:Say(0530 + lin1,1400,"CEP:",oFont8)
oPrn:Say(0530 + lin1,1550,Transform(TRB1->CEP,"@r 99999-999"),oFont3)

oPrn:Line(0575 + lin1,0080,0575 + lin1,2300)
            
oPrn:Say(0590 + lin1,0100,"Contato:",oFont8)
oPrn:Say(0590 + lin1,0350,TRB1->CONTATO,oFont3)
oPrn:Say(0590 + lin1,1000,"Fone:",oFont8)
oPrn:Say(0590 + lin1,1100,IF(!Empty(TRB1->DDD),'(' + Alltrim(TRB1->DDD) + ') '+ Transform(TRB1->FONE,"@r 9999-9999"),Transform(TRB1->FONE,"@r 9999-9999")),oFont3)
oPrn:Say(0590 + lin1,1400,"Fax:",oFont8)
oPrn:Say(0590 + lin1,1550,IF(!Empty(TRB1->DDD),'(' + Alltrim(TRB1->DDD) + ') '+ Transform(TRB1->FAX,"@r 9999-9999"),Transform(TRB1->FAX,"@r 9999-9999")),oFont3)
                       
oPrn:Line(0635 + lin1,0080,0635 + lin1,2300)
          
oPrn:Say(0650 + lin1,0100,"Seu Nบ: ",oFont8)   
oPrn:Say(0650 + lin1,0515,"Validade Proposta:",oFont8)    
oPrn:Say(0650 + lin1,1400,"E-mail:",oFont8)
oPrn:Say(0650 + lin1,1550,TRB1->EMAIL,oFont3)

oPrn:Line(0695 + lin1,0080,0695 + lin1,2300)

                    
For i:=1 to Len(aAllUser)
	If AllTrim(aAllUser[i][01][02]) == AllTrim(Substr(cUsuario,7,15))
		cNome	 := aAllUser[i][01][04]
		cEmail := aAllUser[i][01][14]
		Exit
	Endif
Next i
	
oPrn:Say(0710 + lin1,0100,"Comprador:",oFont8)
oPrn:Say(0710 + lin1,0350,Upper(cNome),oFont3)
oPrn:Say(0710 + lin1,1400,"E-mail:",oFont8)
oPrn:Say(0710 + lin1,1550,cEmail,oFont3)

oPrn:Line(0755 + lin1,0080,0755 + lin1,2300)

oPrn:Say(0770 + lin1,0100,"Local Entrega:",oFont8)
oPrn:Say(0770 + lin1,0350,Alltrim(SM0->M0_ENDENT) + ' - ' + Alltrim(SM0->M0_BAIRENT) + ' - ' + Alltrim(SM0->M0_CIDENT) + ' - ' + Alltrim(SM0->M0_ESTENT) + ' - ' + Transform(SM0->M0_CEPENT,"@r 99999-999"),oFont7)

oPrn:Line(0815 + lin1,0080,0815 + lin1,2300)

oPrn:Say(0830 + lin1,0100,"Local Cobran็a:",oFont8)
oPrn:Say(0830 + lin1,0350,Alltrim(SM0->M0_ENDCOB) + ' - ' + Alltrim(SM0->M0_BAIRCOB) + ' - ' + Alltrim(SM0->M0_CIDCOB) + ' - ' + Alltrim(SM0->M0_ESTCOB) + ' - ' + Transform(SM0->M0_CEPCOB,"@r 99999-999"),oFont7)

oPrn:Line(0875 + lin1,0080,0875 + lin1,2300)

oPrn:Say(0890 + lin1,0100,"Condi็ใo de Pagamento:",oFont8)
oPrn:Say(0890 + lin1,0450,Alltrim(TRB1->CONDICAO2),oFont7)
oPrn:Say(0890 + lin1,1400,"Frete: ",oFont8) //vinicius   TIPO_FRETE

oPrn:Line(0935 + lin1,0080,0935 + lin1,2300)

//oPrn:Say(0950 + lin1,0100,"Pagamento:",oFont8)
//oPrn:Say(0950 + lin1,0500,"Vencimento:",oFont8)
//oPrn:Say(0950 + lin1,0900,"Valor:",oFont8)
                                      
cCol := 1035 + lin1    //Vinicius

oPrn:Line(cCol,0080,cCol,2300)
                        
cCol += 20 

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQUADRO CABECALHO DOS ITENSณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
/*/
oPrn:Say(cCol,0090,"Item",oFont8)

oPrn:Say(cCol,0200,"Qtd.",oFont8)

oPrn:Say(cCol,0395,"Un",oFont8)

oPrn:Say(cCol,0450,"Descri็ใo",oFont8)

oPrn:Say(cCol,1250,"NCM",oFont8) //Vinicius

//oPrn:Say(cCol,1375,"Dt.Necessidade",oFont8)
oPrn:Say(cCol-20,1450,"Data",oFont8)
oPrn:Say(cCol+5,1395,"Necessidade",oFont8)

oPrn:Say(cCol,2086,"% ICMS",oFont8)  //Vinicius

oPrn:Say(cCol,2210,"% IPI",oFont8)

cCol += 40

oPrn:Line(cCol,0080,cCol,2300)

TRB1->(DbCloseArea())

cQuery2  := ""
cQuery2  += " SELECT "                                      
cQuery2  += "   C8_NUMPED PEDIDO, "
cQuery2  += "   C8_ITEM SEQ, "
cQuery2  += "   C8_QUANT QUANT, "
cQuery2  += "   C8_MOEDA MOEDA, "
cQuery2  += "   B1_UM UNIDADE, "
cQuery2  += "   B1_COD CODIGO, "
cQuery2  += "   B1_DESC PRODUTO, "
cQuery2  += "   B1_POSIPI NCM,"
cQuery2  += "   C1_DATPRF ENTREGA, "
cQuery2  += "   C8_PRECO VAL_UNIT, "   //C1_VUNIT ou C1_PRECO
cQuery2  += "   C8_TOTAL VAL_TOT, " 
cQuery2  += "   C8_ALIIPI IPI, "               //coloquei 0 por nใo haver o valor na SC1
cQuery2  += "   C8_PICM ICMS, "              //coloquei 0 por nใo haver o valor na SC1
cQuery2  += "   C1_OBS OBS "
cQuery2  += " FROM "
cQuery2  += RetSqlName("SC8") + " SC8 "
cQuery2  += " LEFT OUTER JOIN "+RetSqlName("SC1")+" SC1"
cQuery2	 += " ON ( C1_FILIAL = C8_FILIAL AND C1_NUM = C8_NUMSC AND C1_ITEM = C8_ITEMSC AND SC1.D_E_L_E_T_ <> '*')"
cQuery2  += " LEFT OUTER JOIN "
cQuery2  += RetSqlName("SB1") + " SB1 "
cQuery2  += " ON "
cQuery2  += "   SB1.B1_COD = SC8.C8_PRODUTO "
cQuery2  += "   AND B1_FILIAL = '"+xFilial("SB1")+"'"
cQuery2  += "   AND SB1.D_E_L_E_T_ <> '*' " 
cQuery2  += " WHERE "
cQuery2  += "   SC8.D_E_L_E_T_ <> '*' "
cQuery2  += "   AND SC8.C8_FILIAL = '"+cFilAnt+"'"
cQuery2  += "   AND SC8.C8_NUM = '" +cValToChar(PRT108_1->C8_NUM)+ "' "
cQuery2  += "	AND SC8.C8_FORNECE = '"+PRT108_1->C8_FORNECE+"'"
cQuery2  += "	AND SC8.C8_LOJA = '"+PRT108_1->C8_LOJA+"'"
cQuery2  += " ORDER BY 1,2,3 "
VerTabela("TRB2")
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),'TRB2',.T.,.T.)
                       
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLOOPING PARA PEGAR ITENS DO PEDIDO   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cCol := cCol - 40
cObs := ""
//Segundo o cliente se um item da cota็ใo for de uma certa moeda, todos serใo
If TRB2->MOEDA == 1
	cMascMoeda := "(R$)"
ElseIf TRB2->MOEDA == 2
	cMascMoeda := "(US$)"
Else
	cMascMoeda := ""
EndIf
oPrn:Say(cCol,1650,"Unit."+cMascMoeda,oFont8)

oPrn:Say(cCol,1900,"Total"+cMascMoeda,oFont8)   //mudei de 1950              
While TRB2->(!Eof()) 
  //VERIFICA SE O CLIN ATINGE 2400     
  fVerPag(lRod)   
                     
  lRod  := .T.
	cColu := 0
	cIni  := cCol-20

	oPrn:Say(cCol+cTam,0090,Alltrim(TRB2->SEQ),oFont7)								//SEQ
	//oPrn:Say(cCol+cTam,0165,AllTrim(Transform(999999999.999,"@E 999,999,999.999")),oFont7)				//QUANTIDADE
	oPrn:Say(cCol+cTam,0165,AllTrim(Transform(TRB2->QUANT,Iif(TRB2->UNIDADE$"KG/MT/CT/MI","@E 999,999,999.999","@E 999,999,999"))),oFont7)				//QUANTIDADE
	oPrn:Say(cCol+cTam,0395,TRB2->UNIDADE,oFont7)									//UNIDADE
	
	//VERIFICA QUANTIDADE DE CARACTERES
	cCodDesc := Alltrim(TRB2->CODIGO) + " - " + Alltrim(TRB2->PRODUTO)
	if Len(cCodDesc) <= 47        // era 55
		oPrn:Say(cCol+cTam,0450,cCodDesc,oFont7)	//PRODUTO
		cColu := cCol+cTam
	ElseIf Len(cCodDesc) <= 94    // era 110
		oPrn:Say(cCol+cTam,0450,     SUBSTR(cCodDesc,1,47),oFont7)									
		oPrn:Say(cCol+cTam+cTam,0450,SUBSTR(cCodDesc,48,47),oFont7)								
		cColu := cCol+cTam+cTam
	Else 
		oPrn:Say(cCol+cTam,0450,          SUBSTR(cCodDesc,1,47),oFont7)									
		oPrn:Say(cCol+cTam+cTam,0450,     SUBSTR(cCodDesc,48,47),oFont7)									
		oPrn:Say(cCol+cTam+cTam+cTam,0450,SUBSTR(cCodDesc,95,47),oFont7)									
		cColu := cCol+cTam+cTam+cTam
	EndIf

	oPrn:Say(cCol+cTam,1210,Transform(TRB2->NCM ,"@R 9999.99.99") ,oFont7)	
	//DATA ENTREGA        
	cData := subs(TRB2->ENTREGA,7,2)+'/'+subs(TRB2->ENTREGA,5,2)+'/'+subs(TRB2->ENTREGA,1,4)
	oPrn:Say(cCol+cTam,1400,cData,oFont7)
	
	oPrn:Say(cCol+cTam,1615,Transform(TRB2->VAL_UNIT/*999999999.99*/,"@E 999,999,999.99"),oFont7)		      	//VALOR UNIT.
	oPrn:Say(cCol+cTam,1855,Transform(TRB2->VAL_TOT/*999999999.99*/,"@E 999,999,999.99"),oFont7)	        	//TOTAL S/ IPI
	
	oPrn:Say(cCol+cTam,2100,Transform(TRB2->ICMS/*999.99*/,"@E 999.99"),oFont7)	//% ICMS
	oPrn:Say(cCol+cTam,2210,Transform(TRB2->IPI/*999.99*/,"@E 999.99"),oFont7)	//% IPI

	If !Empty(cObs)
		cObs += ", "
	EndIf
	cObs  += Alltrim(TRB2->OBS)
	cCol  := cColu+50
	//Linhas a esquerda das colunas
	oPrn:Line(cIni,0155,cCol,0155)      //Qtd
	oPrn:Line(cIni,0385,cCol,0385)		//Un
	oPrn:Line(cIni,0440,cCol,0440)      //Descricao
	oPrn:Line(cIni,1190,cCol,1190)		//Vinicius NCM
	oPrn:Line(cIni,1375,cCol,1375)      //Dt. Necessidade
	oPrn:Line(cIni,1585,cCol,1585)		//Unit   (cIni,1605,cCol,1605)   
	oPrn:Line(cIni,1830,cCol,1830)		//total      1845
	oPrn:Line(cIni,2080,cCol,2080)		//Vinicius esquerda do ICMS
	oPrn:Line(cIni,2205,cCol,2205)      //IPI
  oPrn:Line(cCol,0080,cCol,2300)
     	                      	          
	TRB2->(dbSkip())
End

//VERIFICA SE O CLIN ATINGE 2400     
fVerPag(lRod)  

//TOTAL ITENS DO PEDIDO
cQuery3  := ""
cQuery3  += " SELECT "
cQuery3  += "   C8_NUM PEDIDO, "
cQuery3  += "   C8_TOTFRE  VALOR_FRETE, "
cQuery3  += "   C8_TPFRETE  TIPO_FRETE, "
cQuery3  += "   0  VALOR_SEGURO, "	          // zerado
cQuery3  += "   0  VALOR_DESPESA, "	          // zerado
cQuery3  += "   0  VALOR_DESC, "	            // zerado
cQuery3  += "   0  VALOR_IR, "	            	// zerado
cQuery3  += "   C8_VALIPI  VALOR_IPI, "
cQuery3  += "   C8_VALIDA DATA_MENOR, "
cQuery3  += "   (C8_PRECO ) VALOR_PRODUTO, "  //C1_VUNIT  ,  C1_PRECO
cQuery3  += "   (C8_TOTAL ) VALOR_TOTAL "    	//calculando o valor total dos produtos simplesmente multiplicando quantidade x o vaolr unitario
cQuery3  += " FROM "
cQuery3  += RetSqlName("SC8") + " I_ORC "           
cQuery3  += " WHERE I_ORC.C8_FILIAL = '"+xFilial("SC8")/*cFilAnt*/+"'"
cQuery3	 += " AND I_ORC.D_E_L_E_T_ <> '*'"
cQuery3  += " AND I_ORC.C8_NUM = '" + cValToChar(PRT108_1->C8_NUM) + "' "
cQuery3	 += " AND I_ORC.C8_FORNECE = '"+PRT108_1->C8_FORNECE+"'"
cQuery3	 += " AND I_ORC.C8_LOJA = '"+PRT108_1->C8_LOJA+"'"
cQuery3  += " ORDER BY 1 "
verTabela("TRB3")
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery3),'TRB3',.T.,.T.)

VAL_FRETE   := 0          
VAL_SEGURO  := 0                    	
VAL_DESPESA := 0
VAL_DESC    := 0
VAL_IR      := 0
VAL_ISS     := 0
VAL_PED     := 0         
VAL_IPI     := 0
VAL_TOT     := 0
VAL_DAT	  	:= "20491231"
cPedAux		:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLOOPING PARA PEGAR :ณ
//ณ                    ณ
//ณ- VALOR PRODUTO     ณ
//ณ- VALOR DO IPI      ณ
//ณ- VALOR TOTAL       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

While TRB3->(!Eof()) 
	If cPedAux <> TRB3->PEDIDO
		cPedAux := TRB3->PEDIDO
		VAL_FRETE   += TRB3->VALOR_FRETE
	EndIf
	VAL_SEGURO  += TRB3->VALOR_SEGURO
	VAL_DESPESA += TRB3->VALOR_DESPESA
	VAL_DESC    += TRB3->VALOR_DESC
	VAL_IR      += TRB3->VALOR_IR
	VAL_ISS     += 0
	VAL_PED     += TRB3->VALOR_TOTAL
	VAL_IPI     += TRB3->VALOR_IPI	
	
	If TRB3->DATA_MENOR < VAL_DAT .and. !Empty(TRB3->DATA_MENOR)    // Aqui busco a data menor na SC1 para colocar no cabe็alho da solicita็ใo
		VAL_DAT := TRB3->DATA_MENOR
	EndIf
	                                 
	TRB3->(dbSkip())
End

VAL_TOT  := VAL_PED+VAL_IPI+VAL_FRETE

TRB3->(DbCloseArea())

if  VAL_DAT = "20491231"
	VAL_DAT := "        "    //S๓ para aparecer em branco data caso nใo se tenha colocado datas no SC1
EndIf
oPrn:Say(0129,1740,"Prazo de resposta: " +  subs(VAL_DAT,7,2)+'/'+subs(VAL_DAT,5,2)+'/'+subs(VAL_DAT,1,4),oFont8)  //Vinicius 	
           
cCol += 20
oPrn:Say(cCol,0150,"Total Frete:",oFont8)
oPrn:Say(cCol,0450,Transform(VAL_FRETE,"@E 999,999.99"),oFont7)                                         

oPrn:Say(cCol,0850,"Total Desconto:",oFont8)
oPrn:Say(cCol,1150,Transform(VAL_DESC,"@E 999,999.99"),oFont7)                                         

oPrn:Say(cCol,1650,"Total Itens:",oFont8)
oPrn:Say(cCol,1950,Transform(VAL_PED,"@E 999,999,999.99"),oFont7)

cCol += 50
oPrn:Say(cCol,0150,"Total Seguro:",oFont8)
oPrn:Say(cCol,0450,Transform(VAL_SEGURO,"@E 999,999.99"),oFont7)                                         

oPrn:Say(cCol,0850,"Total IR:",oFont8)
oPrn:Say(cCol,1150,Transform(VAL_IR,"@E 999,999.99"),oFont7)                                         

oPrn:Say(cCol,1650,"Total IPI:",oFont8)
oPrn:Say(cCol,1950,Transform(VAL_IPI,"@E 999,999,999.99"),oFont7)
                                    
cCol += 50
oPrn:Say(cCol,0150,"Total Despesa:",oFont8)
oPrn:Say(cCol,0450,Transform(VAL_DESPESA,"@E 999,999.99"),oFont7)                                         

oPrn:Say(cCol,0850,"Total ISS:",oFont8)
oPrn:Say(cCol,1150,Transform(VAL_ISS,"@E 999,999.99"),oFont7)                                         

oPrn:Say(cCol,1650,"Total do Pedido:",oFont8)
oPrn:Say(cCol,1950,Transform(VAL_TOT,"@E 999,999,999.99"),oFont8)
          
cCol += 50
oPrn:Line(cCol,0080,cCol,2300)

cCol += 30
oPrn:Say(cCol,0090,"Observa็๕es:",oFont8)
    
//QUEBRA DE LINHA DA OBSERVACAO DO PEDIDO DE COMPRA
j := Len(cObs)                                    
i := 1

if j < 120
	cCol += 50
	oPrn:Say(cCol,0090,cObs,oFont3)
Else
	While j > 0
		cCol += 50	
		oPrn:Say(cCol,0090,Substr(cObs,i,119),oFont3)	
		i+=119
		j := j-119
	End
EndIf



//VERIFICA SE O CLIN ATINGE 2400
fVerPag(lRod)
             
If cCol < 2800
	cCol := 2800
EndIf

//LINHA DO COMPRADOR
//oPrn:Line(cCol,0190,cCol,700)
//LINHA DO COORDENADOR
//oPrn:Line(cCol,0900,cCol,1400)
//LINHA DA DIRETORIA
//oPrn:Line(cCol,1500,cCol,2100)

cCol += 20
	
//oPrn:Say(cCol,0270,"Assinatura do Comprador",oFont8)
//oPrn:Say(cCol,0980,"Assinatura do Coordenador",oFont8)
//oPrn:Say(cCol,1650,"Assinatura da Diretoria",oFont8)

oPrn:Say(0360,0090,"Solicitamos de V.Sas. cota็ใo de pre็os para os produtos discriminados, conforme os padr๕es abaixo estabelecidos.",oFont8)	                                                       
oPrn:Say(0410,0090,"Somente consideraremos propostas, at้ a data estabelecida nesta solicita็ใo de cota็ใo. ",oFont8)	
oPrn:Say(0460,0090,"Obrigat๓rio informar o NCM do produto.",oFont8)	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณAjustaSX1 บAutorณ Vinicius(fonte base Vitor)บData ณ 20/21/11บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunte da tela                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AC0013                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)
Local aArea := GetArea()
Local nMax  := 2
Local nI    

//limpo a memoria
Dbselectarea("SX1")
DbsetOrder(1)
For nI := 1 To nMax
  If dbSeek(PADR(cPerg,10)+Padl(cValToChar(nI),2,"0"))
	  Reclock("SX1",.F.)
    SX1->X1_CNT01 := ""
    SX1->(MsUnlock())
  Endif
Next
DbCloseArea("SX1")
//**********************************************************************************//                        
               
PutSx1(cPerg,"01","Nบ Solicitacao de: ","Nบ Solicitacao de: ","Nบ Solicitacao de: ",    "mv_ch1","C",9,0,0 ,"G","","SC8","","","mv_par01","","","","","","","","","","","","",""," "," "," ",{"Nบ Solicitacao de"},{"Nบ Solicitacao de"},{"Nบ Solicitacao de"})
PutSx1(cPerg,"02","Nบ Solicitacao ate: ","Nบ Solicitacao ate: ","Nบ Solicitacao ate: ", "mv_ch2","C",9,0,0 ,"G","","SC8","","","mv_par02","","","","","","","","","","","","",""," "," "," ",{"Nบ Solicitacao ate"},{"Nบ Solicitacao ate"},{"Nบ Solicitacao ate"})

RestArea(aArea)
Return

//ฺฤฤฤฤฤฤฤฤฤฟ
//ณCabecalhoณ
//ภฤฤฤฤฤฤฤฤฤู
Static Function Cabec(lRod)   

	//IMPRESSAO DO DESENHO(LOGO)               
	DO CASE
   		Case xFilial("SC7") == "01"//DAISA MATRIZ
        	cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SC7") == "02"//FUNDICAO
        	cLogo  := '\system\logo_fundicao.jpg'
   		Case xFilial("SC7") == "03"//DAIBRAS
        	cLogo  := '\system\logo_daibras.jpg'
		Case xFilial("SC7") == "04"//DAISA INDUSTRIAL
        	cLogo  := '\system\logo_daisa.jpg'
		Case xFilial("SC7") == "05"//DAISA COMERCIO
        	cLogo  := '\system\logo_daisa.jpg'           	
		Case xFilial("SC7") == "99"//EMPRESA TESTE
        	cLogo  := '\system\logo_daisa.jpg'
	ENDCASE	
    
  oPrn:SayBitmap( 0100, 0090,alltrim(cLogo),0300,0180)
                             
  DbSelectArea("SM0")   
	oPrn:Say(0080,0410,SUBSTR(SM0->M0_NOMECOM,1,45),oFont9)  //Vinicius
	oPrn:Say(0130,0410,SUBSTR(SM0->M0_NOMECOM,45,45),oFont9) //Vinicius
	oPrn:Say(0180,0410,Alltrim(SM0->M0_ENDENT) + ' - BAIRRO: ' + Alltrim(SM0->M0_BAIRENT) + ' - CIDADE: ' + Alltrim(SM0->M0_CIDENT) + ' - CEP: ' + Transform(SM0->M0_CEPENT,"@r 99999-999"),oFont3) 
	oPrn:Say(0230,0410,'ESTADO: ' + Alltrim(SM0->M0_ESTENT) + ' - TELEFONE: ' + SM0->M0_TEL + ' - FAX: ' + SM0->M0_FAX,oFont3) 
	oPrn:Say(0280,0410,'CNPJ - ' + Transform(SM0->M0_CGC,"@r 99.999.999/9999-99") + ' - INSCR. ESTADUAL: ' + Transform(SM0->M0_INSC,"@r 999.999.999.999"),oFont3) 
	                
	oPrn:Say(0093,1740,"Solicita็ใo de Cota็ใo N.",oFont8)   //Vinicius Troquei oFont9
	oPrn:Say(0080,2100,cValToChar(PRT108_1->C8_NUM),oFont9)
	                             
	nPag += 1
	oPrn:Say(0280,2100,"Pแgina: " + AllTrim(Str(nPag)),oFont8) //NUMERO PAGINA          
	
	//LINHA HORIZONTAL SUPERIOR
	oPrn:Line(0325,0080,0325,2300)
Return

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncao para analise de paginasณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function fVerPag(lRod)  
  If ( cCol >= 2900 )  
	oPrn :EndPage()
	cCol  := 0420 
	cColu := 0430
	cColf := 0555
	oPrn:StartPage()  
	
	oPrn:Line(0050,0080,0050,2300)
	oPrn:Line(0050,0080,3260,0080)
	oPrn:Line(3260,0080,3260,2300)
	oPrn:Line(0050,2300,3260,2300)  

	Cabec(lRod)
  EndIf
Return

Static Function VerTabela(tab)
	If SELECT(tab) > 0
		dbSelectArea(tab)
		dbCloseArea(tab)
	Endif
Return                                                                                
