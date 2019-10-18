#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"                         
#INCLUDE "COLORS.CH"       
#INCLUDE "FONT.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PRT0092    ºAutor  ³Marcos Santos      º Data ³  09-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Espelho do Pedido                                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PRT0092(cNum,cFil)  
Private cNumPed := cNum
Private cFilCor := cFil

PRIVATE nLinha  := 0
PRIVATE nVol    := 0
PRIVATE oPrn    := TMSPrinter():New("PRT0092 - Espelho do Pedido de Venda")
PRIVATE nPag    := 1
PRIVATE cRazao  := NIL

//DEFININDO AS FONTES
DEFINE FONT oFont8   NAME "Arial" SIZE 0,08 OF oPrn
DEFINE FONT oFont8N  NAME "Arial" SIZE 0,08 OF oPrn BOLD
DEFINE FONT oFont10  NAME "Arial" SIZE 0,10 OF oPrn
DEFINE FONT oFont10N NAME "Arial" SIZE 0,10 OF oPrn BOLD
DEFINE FONT oFont12  NAME "Arial" SIZE 0,12 OF oPrn 
DEFINE FONT oFont12N NAME "Arial" SIZE 0,12 OF oPrn BOLD
DEFINE FONT oFont14  NAME "Arial" SIZE 0,14 OF oPrn 
DEFINE FONT oFont14N NAME "Arial" SIZE 0,14 OF oPrn BOLD
DEFINE FONT oFont20N NAME "Arial" SIZE 0,20 OF oPrn BOLD



DbSelectArea("SM0")
DbSetOrder(1)
DbSeek(SM0->M0_CODIGO)
cRazao := AllTrim(SM0->M0_NOMECOM)


oPrn:SetPortrait()
oPrn:Setup()  

//Monto o relatorio
Relatorio()      

oPrn:Preview()  
oPrn:End()

Ms_Flush()
Return                          


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Relatorio ºAutor  ³Marcos Santos       º Data ³  09-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Layout do relatorio a ser impresso.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION Relatorio()
Local cQuery
Local cEmissao  := "" 
Local cPROD     := ""
Local nI      	:= 0
Local cVarAux 	:= nil 
Local aRet    	:= AllUsers()

//cabeçalho
Cabec()                            

//corpo do cabeçalho
cQuery := "SELECT SC5.C5_NUM, SC5.C5_EMISSAO, SC5.C5_MENNOTA, SC5.C5_OBSERVP, SA1.A1_COD, SA1.A1_NOME, SA1.A1_END, SA1.A1_CGC,"
cQuery += " SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_EST, SA1.A1_CEP, SA1.A1_DDD, SA1.A1_TEL, SA1.A1_FAX, SA1.A1_EMAIL,"
cQuery += " SA3.A3_COD, SA3.A3_NOME, SA3.A3_DDDTEL, SA3.A3_TEL, SA1.A1_ENDENT, SA1.A1_BAIRROE, SA1.A1_MUNE,"
cQuery += " SA1.A1_ESTE, SA1.A1_CEPE, SA4.A4_NOME, SA4.A4_END, SA4.A4_BAIRRO, SA4.A4_MUN, SA4.A4_CEP, SA4.A4_EST,"
cQuery += " SE4.E4_CODIGO,SE4.E4_DESCRI"
cQuery += "  FROM " + RetSQLName("SC5") + " SC5"
cQuery += "       JOIN " + RetSQLName("SA1") + 	" SA1 "
cQuery += "            ON SC5.C5_CLIENTE = SA1.A1_COD AND "
cQuery += "               SC5.C5_LOJACLI = SA1.A1_LOJA AND "
cQuery += "               SA1.A1_FILIAL = '" + xFilial("SA1") + "' AND "
cQuery += "               SA1.D_E_L_E_T_ = ''"
cQuery += "       LEFT OUTER JOIN " + RetSQLName("SA3") + " SA3 "
cQuery += "                    ON SC5.C5_VEND1 = SA3.A3_COD AND "
cQuery += "                       SA3.A3_FILIAL = '" + xFilial("SA3") + "' AND "
cQuery += "                       SA3.D_E_L_E_T_ = ''"
cQuery += "       LEFT OUTER JOIN " + RetSQLName("SA4") + " SA4 "
cQuery += "                    ON SC5.C5_TRANSP = SA4.A4_COD AND "
cQuery += "                       SA4.A4_FILIAL = '" + xFilial("SA4") + "' AND "
cQuery += "                       SA4.D_E_L_E_T_ = ''"
cQuery += "       LEFT OUTER JOIN " + RetSQLName("SE4") + " SE4 "
cQuery += "                    ON SC5.C5_CONDPAG = SE4.E4_CODIGO AND "
cQuery += "                       SE4.E4_FILIAL = '" + xFilial("SE4") + "' AND "
cQuery += "                       SE4.D_E_L_E_T_ = ''"
cQuery += " WHERE SC5.C5_FILIAL = '" + CFILCOR + "' AND "
cQuery += "       SC5.D_E_L_E_T_ = '' AND "
cQuery += "       SC5.C5_NUM = '" + CNUMPED + "'"

VerTabela("TMPPTR92")

TcQuery cQuery New Alias "TMPPTR92"  

cEmissao := TMPPTR92->C5_EMISSAO

nLinha += 20
oPrn:Say(nLinha,0080,"Pedido DAISA: ",oFont14N)                                          
oPrn:Say(nLinha,0400,Space(5)+cValToChar(TMPPTR92->C5_NUM),oFont14)                                          

//data de entrega e numero do pedido do cliente
CQUERY := " SELECT SC6.C6_PEDCLI,MAX(SC6.C6_ENTREG) C6_ENTREG"
CQUERY += " FROM "+RETSQLNAME("SC6")+" SC6 "
CQUERY += " WHERE SC6.C6_FILIAL = '"+CFILCOR+"'"
CQUERY += " AND SC6.D_E_L_E_T_ <> '*' "
CQUERY += " AND SC6.C6_NUM = '"+CNUMPED+"'"
CQUERY += " GROUP BY SC6.C6_PEDCLI "  

VerTabela("TMPT92_1")

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPT92_1',.T.,.T.)
       
oPrn:Say(nLinha,0850,"Pedido do Cliente: ",oFont14N)                                          
oPrn:Say(nLinha,1350,cValToChar(TMPT92_1->C6_PEDCLI),oFont14)                                          
oPrn:Say(nLinha,1600,"Data da Entrega: ",oFont14N)                                          
oPrn:Say(nLinha,2000,Substr(TMPT92_1->C6_ENTREG,7,2)+'/'+Substr(TMPT92_1->C6_ENTREG,5,2)+'/'+Substr(TMPT92_1->C6_ENTREG,1,4),oFont14)                                          
TMPT92_1->(dbCloseArea()) 
//************************************************************//

nLinha += 130
oPrn:Say(nLinha,0080,"Data do Pedido: ",oFont10N)                                          

cVarAux := DiaSemana(STOD(TMPPTR92->C5_EMISSAO))
If cVarAux <> "Sabado" .Or. cVarAux <> "Domingo" 
  cVarAux += "-feira, "
Else  
  cVarAux += ", "
Endif

oPrn:Say(nLinha,0400,cVarAux+Substr(TMPPTR92->C5_EMISSAO,7,2)+' de '+MesExtenso(STOD(TMPPTR92->C5_EMISSAO))+' de '+Substr(TMPPTR92->C5_EMISSAO,1,4),oFont10)                                          
oPrn:Say(nLinha,1450,"E-Mail: ",oFont10N)                                          
oPrn:Say(nLinha,1650,AllTrim(TMPPTR92->A1_EMAIL),oFont10)                                          

nLinha += 40
oPrn:Say(nLinha,0080,"Cliente: ",oFont10N)                                          
oPrn:Say(nLinha,0300,Substr(AllTrim(TMPPTR92->A1_COD)+" - "+AllTrim(TMPPTR92->A1_NOME),1,55),oFont10)                                          
oPrn:Say(nLinha,1450,"CPF/CNPJ: ",oFont10N)                                          
        
If Len(Alltrim(TMPPTR92->A1_CGC)) == 14
  oPrn:Say(nLinha,1650,Transform(TMPPTR92->A1_CGC,"@r 99.999.999/9999-99"),oFont10)                                          
Else
  oPrn:Say(nLinha,1650,Transform(TMPPTR92->A1_CGC,"@r 999.999.999-99"),oFont10)                                          
EndIf

nLinha += 40
oPrn:Say(nLinha,0080,"Endereço: ",oFont10N)                                          
oPrn:Say(nLinha,0300,Substr(AllTrim(TMPPTR92->A1_END),1,80),oFont10)                                          
oPrn:Say(nLinha,1450,"Bairro: ",oFont10N)                                          
oPrn:Say(nLinha,1650,AllTrim(TMPPTR92->A1_BAIRRO),oFont10)                                          

nLinha += 40
oPrn:Say(nLinha,0080,"Cidade: ",oFont10N)                                          
oPrn:Say(nLinha,0300,AllTrim(TMPPTR92->A1_MUN),oFont10)                                          
oPrn:Say(nLinha,0800,"Estado: ",oFont10N)                                          
oPrn:Say(nLinha,1000,AllTrim(TMPPTR92->A1_EST),oFont10)                                          

nLinha += 40
oPrn:Say(nLinha,0080,"CEP: ",oFont10N)                                          
oPrn:Say(nLinha,0300,Transform(TMPPTR92->A1_CEP,"@r 99999-999"),oFont10)                                          

oPrn:Say(nLinha,0800,"Fone: ",oFont10N)                                          

If empty(TMPPTR92->A1_DDD)
  oPrn:Say(nLinha,1000,Transform(TMPPTR92->A1_TEL,"@r 9999-9999"),oFont10)                                          
Else
  oPrn:Say(nLinha,1000,"("+TMPPTR92->A1_DDD+") "+Transform(TMPPTR92->A1_TEL,"@r 9999-9999"),oFont10)                                          
Endif

oPrn:Say(nLinha,1450,"Fax: ",oFont10N)                                          
oPrn:Say(nLinha,1650,AllTrim(TMPPTR92->A1_FAX),oFont10)                                          
 
nLinha += 80
oPrn:Say(nLinha,0080,"Representante: ",oFont10N)                                          
//oPrn:Say(nLinha, 0300, Substr(AllTrim(TMPPTR92->A3_COD) + " - " + AllTrim(TMPPTR92->A3_NOME), 1, 60), oFont10)
oPrn:Say(nLinha, 0340, Substr(AllTrim(TMPPTR92->A3_COD) + " - " + AllTrim(TMPPTR92->A3_NOME), 1, 60), oFont10)
oPrn:Say(nLinha,1650,"Fone: ",oFont10N)                                          

If empty(TMPPTR92->A3_DDDTEL)
  oPrn:Say(nLinha,1850,Transform(TMPPTR92->A3_TEL,"@r 9999-9999"),oFont10)                                          
Else
  oPrn:Say(nLinha,1850,"("+TMPPTR92->A3_DDDTEL+") "+Transform(TMPPTR92->A3_TEL,"@r 9999-9999"),oFont10)                                          
Endif

nLinha += 40
oPrn:Say(nLinha,0080,"Emitido por: ",oFont10N)                                          

oPrn:Say(nLinha,0300,Upper( AllTrim( cUserName ) ),oFont10)                                          


nLinha += 80
oPrn:Say(nLinha,0080,"Observações: ",oFont10N)                                          
            
//nLinha += 40
//Replace(Space(200)," ","W") MSMM(TMPPTR92->C5_OBSERVP)
cMsg := Posicione("SC5",1,CFILCOR+TMPPTR92->C5_NUM,"C5_OBSERVP")//"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
lPrimVez 	:= .T.
nIniPos		:= 1
//nTotCar		:= 86
nColObs 	:= 0340
nEnter := At(CHR(13),cMsg)
While nEnter > 0
	
	nTotCar := nEnter+1
	cMsgAux := SubStr(cMsg,1,nTotCar)
	/*
	If lPrimVez		
		lPrimVez := .F.
	Else
		nColObs := 0080
	EndIf*/

	nIniPos := nTotCar+1
	cMsg := SubStr(cMsg,nIniPos,Len(cMsg)-nTotCar)
	//nTotCar	:= 100
	If !(cMsgAux == Chr(13)+Chr(10))
		oPrn:Say(nLinha,nColObs,AllTrim(UPPER(cMsgAux)),oFont10)
		nLinha += 40
	EndIf
	nEnter := At(CHR(13),cMsg)
EndDo

oPrn:Say(nLinha,nColObs,AllTrim(UPPER(cMsg)),oFont10)

//impressão do packlist
nLinha  += 80
nLinAux := nLinha
oPrn:Line(nLinha,0080,nLinha,2300) 

nLinha += 30
oPrn:Say(nLinha,1630,"Total de",oFont12)                                          

nLinha += 30
oPrn:Say(nLinha,0170,"NF.:",oFont12)
/*
//dados da NF
CQUERY := " SELECT SC5.C5_NOTA,SC5.C5_SERIE "
CQUERY += " FROM "+RETSQLNAME("SC5")+" SC5 "
//CQUERY += "   JOIN "+RETSQLNAME("SA1")+" SA1 "
//CQUERY += "     ON (SC5.C5_CLIENTE = SA1.A1_COD "
CQUERY += " WHERE SC5.C5_FILIAL = '"+CFILCOR+"'"
CQUERY += " AND SC5.C5_NUM = '"+CNUMPED+"'"
CQUERY += " AND SC5.D_E_L_E_T_ <> '*' "

VerTabela("TMPT92_1")

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPT92_1',.T.,.T.)

cVarAux := TMPT92_1->C5_NOTA + TMPT92_1->C5_SERIE
TMPT92_1->(dbCloseArea()) */
oPrn:Say(nLinha,0380,/*cVarAux*/SC9->C9_NFISCAL+"-"+SC9->C9_SERIENF,oFont12)
//************************************************//

//qtde volume total
CQUERY := " SELECT MAX(SZD.ZD_VOLUME) MAIOR "
CQUERY += " FROM "+RETSQLNAME("SZD")+" SZD "
CQUERY += " JOIN " + RetSqlName("SC9") + " SC9 ON SZD.ZD_FILIAL = SC9.C9_FILIAL AND SZD.ZD_PEDIDO = SC9.C9_PEDIDO"
CQUERY += " AND SZD.ZD_ITEMPV = SC9.C9_ITEM AND SC9.D_E_L_E_T_ <> '*' "
If Empty(SC9->C9_NFISCAL)
	cQuery += " AND C9_EXPFLAG = '"+SC9->C9_EXPFLAG+"'"
Else
	cQuery += " AND C9_NFISCAL = '"+SC9->C9_NFISCAL+"'"
	cQuery += " AND C9_SERIENF = '"+SC9->C9_SERIENF+"'"
EndIf
CQUERY += " WHERE SZD.ZD_FILIAL = '"+CFILCOR+"'"
CQUERY += " AND SZD.ZD_PEDIDO = '"+CNUMPED+"'"
CQUERY += " AND SZD.D_E_L_E_T_ <> '*'"

VerTabela("TMPT92_1")

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPT92_1',.T.,.T.)   

nVol := TMPT92_1->MAIOR
TMPT92_1->(dbCloseArea()) 

oPrn:Say(nLinha,1630,"volumes:" +Space(23)+cValToChar(nVol),oFont12)                                          

nLinha += 40
oPrn:Line(nLinha,0080,nLinha,2300) 

nLinha += 10
oPrn:Say(nLinha,0110,"Sacos:",oFont12N)                                          
//oPrn:Say(nLinha,0220,"Produto:",oFont12N)
oPrn:Say(nLinha,0900,"Produto:",oFont12N)
oPrn:Say(nLinha,1600,"Quantidade:",oFont12N)
oPrn:Say(nLinha,1900,"Verificado:",oFont12N)                                          

nLinha += 50
oPrn:Line(nLinha,0080,nLinha,2300)    
                         
//rodo os itens
CQUERY := "SELECT SZD.ZD_VOLUME, SB1.B1_COD, SB1.B1_XCODCAT, SZD.ZD_QTDVOL, C9_EXPFLAG, C9_NFISCAL";
			+ " FROM " + RETSQLNAME("SZD") + " SZD";
			+ " JOIN " + RetSqlName("SC9") + " SC9 ON SZD.ZD_FILIAL = SC9.C9_FILIAL AND SZD.ZD_PEDIDO = SC9.C9_PEDIDO";
			+										" AND SZD.ZD_ITEMPV = SC9.C9_ITEM AND SC9.D_E_L_E_T_ <> '*' "
If Empty(SC9->C9_NFISCAL)
	cQuery += " AND C9_EXPFLAG = '"+SC9->C9_EXPFLAG+"'"
Else
	cQuery += " AND C9_NFISCAL = '"+SC9->C9_NFISCAL+"'"
	cQuery += " AND C9_SERIENF = '"+SC9->C9_SERIENF+"'"
EndIf
cQuery += " JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' AND SB1.B1_COD = SC9.C9_PRODUTO AND SB1.D_E_L_E_T_ <> '*'";
			+ " WHERE SZD.ZD_FILIAL = '" + CFILCOR + "'";
			+ " AND SZD.ZD_PEDIDO = '"	 + CNUMPED + "'";
			+ " AND SZD.D_E_L_E_T_ <> '*'";
			+ " ORDER BY SZD.ZD_VOLUME"
	
VerTabela("TMPT92_1")

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPT92_1',.T.,.T.)

TMPT92_1->(DbGotop())

//nLinha += 20
nLinha += 10

While TMPT92_1->(!eof())
//cEmissao
cPROD := IIF(cEmissao >= "20130211",TMPT92_1->B1_COD,IIF(Empty(TMPT92_1->B1_XCODCAT),TMPT92_1->B1_COD,TMPT92_1->B1_XCODCAT))
	oPrn:Say(nLinha + 10, 0150, cValToChar(TMPT92_1->ZD_VOLUME),				oFont12)                                          
   //	oPrn:Say(nLinha + 10, 0190, AllTrim(TMPT92_1->B1_COD), 	oFont12) 
  	oPrn:Say(nLinha + 10, 0380, AllTrim(cPROD), 	oFont12)
  	oPrn:Say(nLinha + 10, 1780, cValToChar(TMPT92_1->ZD_QTDVOL),				oFont12,,,,1)     //B1_XCODANT

	nLinha += 70

	oPrn:Line(nLinha,0080,nLinha,2300)     

	If nLinha >= 2860 //devo quebrar de pagina
  		FinalRel()
  		Roda()
	  	oPrn:EndPage()
    	Cabec()
  	EndIf
	TMPT92_1->(dbSkip())
End

TMPT92_1->(dbCloseArea()) 
//************************************************************************//     

//insiro as 2 ultimas linhas
nLinha += 70
oPrn:Line(nLinha,0080,nLinha,2300)     
nLinha += 70
oPrn:Line(nLinha,0080,nLinha,2300)  

//informações da transportadora
If nLinha >= 2500 //devo quebrar de pagina
  FinalRel()
  Roda()
  oPrn:EndPage()
  Cabec()
Else
	//finalizo o relatório                         
	FinalRel()
EndIf
 
nLinha := 2500
oPrn:Say(nLinha,0080,"Transportadora: ",oFont10N)

oPrn:Say(nLinha,0350,AllTrim(TMPPTR92->A4_NOME),oFont10N)
              
nLinha += 40
oPrn:Say(nLinha,0080,"Endereço de Entrega: ",oFont10N)

If AllTrim(TMPPTR92->A4_NOME) == "PROPRIO"
	cVarAux := AllTrim(TMPPTR92->A1_ENDENT)  + " - CEP: "    + Transform(TMPPTR92->A1_CEPE,"@r 99999-999") + ;
                                           " - BAIRRO: " + AllTrim(TMPPTR92->A1_BAIRROE)               + ; 
                                           " - CIDADE: " + AllTrim(TMPPTR92->A1_MUNE)                  + ; 
                                           " - UF: "     + AllTrim(TMPPTR92->A1_ESTE)
 Else
	cVarAux := AllTrim(TMPPTR92->A4_END)  + " - CEP: "    + Transform(TMPPTR92->A4_CEP,"@r 99999-999") + ;
                                           " - BAIRRO: " + AllTrim(TMPPTR92->A4_BAIRRO)               + ; 
                                           " - CIDADE: " + AllTrim(TMPPTR92->A4_MUN)                  + ; 
                                           " - UF: "     + AllTrim(TMPPTR92->A4_EST) 
 EndIf
If len(cVarAux) <= 100
  oPrn:Say(nLinha,0450,cVarAux,oFont10)
Else
  oPrn:Say(nLinha,0450,Substr(cVarAux,1,100),oFont10)
  nLinha += 40
  oPrn:Say(nLinha,0080,Substr(cVarAux,101,100),oFont10)
Endif
      
nLinha += 50
oPrn:Say(nLinha,0080,"Qtd. Volumes:",oFont10N)
oPrn:Say(nLinha,0350," _____________________",oFont10N)
nLinha += 50
oPrn:Say(nLinha,0080,"Peso:",oFont10N)
oPrn:Say(nLinha,0350," _____________________",oFont10N)
nLinha += 50
oPrn:Say(nLinha,0080,"Embalado por:",oFont10N)
oPrn:Say(nLinha,0350," _____________________",oFont10N)
nLinha += 50
oPrn:Say(nLinha,0080,"Conferido por:",oFont10N)
oPrn:Say(nLinha,0350," _____________________",oFont10N)
nLinha += 50
oPrn:Say(nLinha,0080,"Data:",oFont10N)
oPrn:Say(nLinha,0350," _____/_____/__________",oFont10N)
dbCloseArea("TMPPTR92")
//**********************************************************************//

//rodape
Roda()           

//fim de pagina
oPrn:EndPage()
Return         
                          
//função cabeçalho
Static Function Cabec()
Local cLogo  := nil

//inicio de pagina
oPrn:StartPage()

//linha,posicao,angulo,fim
nLinha := 50  

//logotipo
DO CASE
  Case cFilAnt == "01"//DAISA MATRIZ
   	cLogo  := '\system\logo_daisa.jpg'
  Case cFilAnt == "02"//FUNDICAO
   	cLogo  := '\system\logo_fundicao.jpg'
  Case cFilAnt == "03"//DAIBRAS
   	cLogo  := '\system\logo_daibras.jpg'
  Case cFilAnt == "04"//DAISA INDUSTRIAL
   	cLogo  := '\system\logo_daisa.jpg'
  Case cFilAnt == "05"//DAISA COMERCIO
   	cLogo  := '\system\logo_daisa.jpg'           	
  Case cFilAnt == "99"//EMPRESA TESTE
   	cLogo  := '\system\logo_daisa.jpg'
ENDCASE	
              
nLinha += 30    
oPrn:SayBitmap(nLinha, 0080,alltrim(cLogo),0500,0200)
//**************************************************************//

nLinha += 70
oPrn:Say(nLinha,0800,cRazao,oFont20N)
            
nLinha += 190
oPrn:Line(nLinha,0080,nLinha,2300)    
nLinAux := nLinha
Return

//finaliza o relatorio
Static Function FinalRel()
  oPrn:BOX(nLinAux,0080,nLinha,0370)  //coluna 1
  oPrn:BOX(nLinAux,0370,nLinha,1560)  //coluna 2
  oPrn:BOX(nLinAux,0370,nLinha,1850)  //coluna 3
  oPrn:BOX(nLinAux,0370,nLinha,2300)  //coluna 4
Return

Static Function VerTabela(tab)
	If SELECT(tab) > 0
		dbSelectArea(tab)
		dbCloseArea(tab)
	Endif
Return
     
//rodape
Static Function Roda()
  nLinha := 2900
  oPrn:Line(nLinha,0080,nLinha,2300) //ultima linha    
  nLinha += 20
  oPrn:Say(nLinha,1300,DTOC(dDataBase),oFont8)  
  oPrn:Say(nLinha,1500,Time(),oFont8)  
  oPrn:Say(nLinha,1800,"Página: "+cValToChar(nPag),oFont8)    
  nPag += 1
Return