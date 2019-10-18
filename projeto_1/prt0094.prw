#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "FONT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PRT0094   ºAutor  ³Marcos Santos       º Data ³  12-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Certificado de Qualidade                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PRT0094()

Local   cPerg   := "MV_PRT0094"
Local   cQuery
Local   nNum    := 0

PRIVATE nLinha  := 0
PRIVATE oPrn    := NIL
PRIVATE nPag    := 1
PRIVATE cNota   := NIL
PRIVATE cSerie  := NIL

	//DEFININDO AS FONTES
	DEFINE FONT oFont8   NAME "Arial" SIZE 0,08 OF oPrn
	DEFINE FONT oFont8N  NAME "Arial" SIZE 0,08 OF oPrn BOLD
	DEFINE FONT oFont7   NAME "Arial" SIZE 0,07 OF oPrn
	DEFINE FONT oFont7N  NAME "Arial" SIZE 0,07 OF oPrn BOLD
	DEFINE FONT oFont10  NAME "Arial" SIZE 0,10 OF oPrn
	DEFINE FONT oFont10N NAME "Arial" SIZE 0,10 OF oPrn BOLD
	DEFINE FONT oFont12  NAME "Arial" SIZE 0,12 OF oPrn
	DEFINE FONT oFont12N NAME "Arial" SIZE 0,12 OF oPrn BOLD
	DEFINE FONT oFont14  NAME "Arial" SIZE 0,14 OF oPrn
	DEFINE FONT oFont14N NAME "Arial" SIZE 0,14 OF oPrn BOLD
	DEFINE FONT oFont20N NAME "Arial" SIZE 0,20 OF oPrn BOLD
	
	//grupo de perguntas
	AjustaSX1(cPerg)
	
	If Pergunte(cPerg,.T.)
		
		cNota  := AllTrim(SF2->F2_DOC)
		cSerie := AllTrim(SF2->F2_SERIE)
		
		oPrn := TMSPrinter():New("PRT0094 - Certificado de Qualidade - Impressão")
		
		If empty(MV_PAR02)
			MsgInfo("Favor informar a nota fiscal")
			AjustaSX1(cPerg)
		Else  	 //vejo se a nota já tem certificado
			cQuery := "SELECT SF2.F2_NUMCERT,SF2.F2_CERTQUI "
			cQuery += "  FROM " + RetSqlName("SF2") + " SF2 "
			cQuery += " WHERE SF2.F2_DOC = '" + CNOTA + "' AND "
			cQuery += "       SF2.F2_SERIE = '" + CSERIE + "' AND "
			cQuery += "       SF2.F2_FILIAL = '" + CFILANT + "' AND "
			cQuery += "       SF2.D_E_L_E_T_ = ''
			
			If Select("TMP_1") > 0
				TMP_1->(DbCloseArea())
			EndIf
			
			//VALIDA QUERY
			cQuery := ChangeQuery(cQuery)
			MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_1',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
			
			If TMP_1->F2_NUMCERT = 0 .Or. Empty(cValTochar(TMP_1->F2_NUMCERT))  //não tem numero preciso gerar
				If empty(MV_PAR01) //vejo se informou a analise quimica
					MsgInfo("Favor informar o número da Análise Química")
					AjustaSX1(cPerg)
				Else
					cQuery := "SELECT ISNULL(MAX(SF2.F2_NUMCERT),0)+1 NUM "
					cQuery += "  FROM " + RetSqlName("SF2")+" SF2 "
					cQuery += " WHERE F2_FILIAL = '"+CFILANT+"' AND "
					cQuery += "       D_E_L_E_T_ = ''
					
					If Select("TMP_2") > 0
						TMPT94_2->(DbCloseArea())
					EndIf
					
					//VALIDA QUERY
					cQuery := ChangeQuery(cQuery)
					MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_2',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
					
					nNum := TMP_2->NUM
					TMP_2->(DbCloseArea())
					
					//atualizo os dados
					cQuery := "UPDATE " + RetSqlName("SF2")
					cQuery += "   SET F2_NUMCERT = '" + CVALTOCHAR(NNUM) + "', "
					cQuery += "       F2_CERTQUI = '" + AllTrim(MV_PAR01) + "' "
					cQuery += " WHERE F2_DOC = '" + CNOTA + "' AND "
					cQuery += "       F2_SERIE = '" + CSERIE + "' AND "
					cQuery += "       F2_FILIAL = '" + CFILANT +"' AND "
					cQuery += "       D_E_L_E_T_ = ''"
					
					//VALIDA QUERY
					cQuery := ChangeQuery(cQuery)
					MsAguarde({|| TcSqlExec(cQuery) },"Aguarde...") //"Atualizando os Dados..."
					
					//chamo a rotina
					Relatorio(cValToChar(nNum),AllTrim(MV_PAR01))
				Endif
			Else   //já gerou
				If empty(MV_PAR01) //vejo se informou a analise quimica
					Relatorio(cValToChar(TMP_1->F2_NUMCERT),AllTrim(TMP_1->F2_CERTQUI))
				ElseIf MsgYesNo("Já foi gerado o Certificado nº "+AllTrim(cValToChar(TMP_1->F2_NUMCERT))+" para esta nota, deseja atualizar o nº da analise?","Certificado já Gerado")
					//atualizo os dados
					cQuery := "UPDATE " + RetSqlName("SF2")
					cQuery += "   SET F2_CERTQUI = '" + ALLTRIM(MV_PAR01) + "'"
					cQuery += " WHERE F2_DOC = '" + CNOTA + "' AND "
					cQuery += "       F2_SERIE = '" + CSERIE + "' AND "
					cQuery += "       F2_FILIAL = '" + CFILANT + "' AND "
					cQuery += "       D_E_L_E_T_ = ''"
					
					//VALIDA QUERY
					cQuery := ChangeQuery(cQuery)
					MsAguarde({|| TcSqlExec(cQuery) },"Aguarde...") //"Atualizando os Dados..."
					
					Relatorio(cValToChar(TMP_1->F2_NUMCERT),AllTrim(MV_PAR01))
				Else
					AjustaSX1(cPerg)
				Endif
			Endif
		Endif
	
	    // Fecha a tabela temporaria	
		If Select("TMP_1") > 0
			TMP_1->(DbCloseArea())
		EndIf
		
		oPrn:SetPortrait()
		oPrn:Setup()
		oPrn:Preview()
		oPrn:End()
		
		Ms_Flush()
		
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RELATORIO ºAutor  ³Marcos Santos       º Data ³  12-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Certificado de Qualidade                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC PROCEDURE Relatorio(numero,analise)

Local cQuery
Local nI      := 0
Local nLinTop := 0

	//cabeçalho
	Cabec(numero)
	
	//rodo os itens
	cQuery := "SELECT SD2.D2_QUANT,SB1.B1_DESC "
	cQuery += "  FROM " + RetSqlName("SD2")+" SD2 "
	cQuery += "  JOIN " + RetSqlName("SB1")+" SB1 "
	cQuery += "    ON SB1.B1_FILIAL = '" + xFilial("SB1")+"' AND "
	cQuery += "       SD2.D2_COD = SB1.B1_COD AND "
	cQuery += "       SB1.D_E_L_E_T_ = ''"
	cQuery += " WHERE SD2.D2_FILIAL = '" + CFILANT + "' AND "
	cQuery += "       SD2.D2_DOC = '" + CNOTA + "' AND "
	cQuery += "       SD2.D2_SERIE = '" + CSERIE + "' AND "
	cQuery += "       SD2.D_E_L_E_T_ = ''"
	cQuery += " ORDER BY SD2.D2_ITEM "
	
	If Select("TMP_6") > 0
		TMP_6->(DbCloseArea())
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_6',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	While TMP_6->( .NOT. EOF())
		nLinha += 20
		oPrn:Say(nLinha,0100,AllTrim(TMP_6->B1_DESC),oFont10)
		oPrn:Say(nLinha,1800,Transform(TMP_6->D2_QUANT,"@E 999,999.99"),oFont10)
		
		oPrn:BOX(nLinha-20,0080,nLinha+40,1400)        //box
		
		nLinha += 40
		oPrn:Line(nLinha,0080,nLinha,2300)
		
		If nLinha >= 2900 //devo quebrar de pagina
			FinalRel()
			Roda()
			oPrn:EndPage()
			Cabec(numero)
		EndIf
		
		TMP_6->(dbSkip())
	EndDo
	TMP_6->(dbCloseArea())
	//****************************************************************//
	
	//vejo se preciso pular de página
	If nLinha >= 1950
		FinalRel()
		Roda()
		oPrn:EndPage()
		Cabec(numero)
	EndIf
	
	nLinha := 1950
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 20
	oPrn:Say(nLinha,0900,"Resultado dos Ensaios:",oFont12N)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	nLinTop := nLinha
	
	nLinha += 30
	oPrn:Say(nLinha,0100,"Ensaio",oFont12N)
	oPrn:Say(nLinha,0800,"Resultado",oFont12N)
	oPrn:Say(nLinha,1700,"Observação",oFont12N)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 30
	oPrn:Say(nLinha,0100,"Matéria Prima:",oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,0700)
	
	nLinha += 50
	oPrn:Say(nLinha,0100,"Conforme NBR 15701",oFont12)
	oPrn:Say(nLinha,0800,"Aprovado",oFont12)
	oPrn:Say(nLinha,1400,"Certificado de analise Química nº: " + AllTrim(analise),oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 50
	oPrn:Say(nLinha,0100,"Inspeção Visual:",oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 50
	oPrn:Say(nLinha,0100,"Acabamento",oFont12)
	oPrn:Say(nLinha,0800,"Aprovado",oFont12)
	oPrn:Say(nLinha,1400,"-------------------------------------------------------",oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 50
	oPrn:Say(nLinha,0100,"Dimensional",oFont12)
	oPrn:Say(nLinha,0800,"Aprovado",oFont12)
	oPrn:Say(nLinha,1400,"-------------------------------------------------------",oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 30
	oPrn:Say(nLinha,0500,"Engenharia",oFont12)
	oPrn:Say(nLinha,1700,"Depto. Técnico",oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	//fecho os boxs
	oPrn:Line(nLinTop,0700,nLinha-80,0700) //primeira linha vertical
	oPrn:Line(nLinTop,1300,2900,1300)     //segunda linha vertical
	
	FinalRel()
	Roda()
		
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Cabec     ºAutor  ³Marcos Santos       º Data ³  12-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao Cabecario do relatorio.                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Procedure Cabec(numero)

Local cQuery
Local cLogo
Local cPedido := ""

	//inicio de pagina
	oPrn:StartPage()
	
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
	oPrn:SayBitmap(nLinha, 0080,alltrim(cLogo),0400,0200)
	
	
	oPrn:Say(nLinha,0500,AllTrim(SM0->M0_NOMECOM),oFont20N)
	nLinha += 80
	oPrn:Say(nLinha,0500,"CONEXÕES E ELETRODUTOS",oFont14N)
	
	nLinha += 50
	oPrn:Say(nLinha,0500,"ESCRITÓRIO DE VENDAS: ",oFont7N)
	oPrn:Say(nLinha,0870,"RUA ALEXANDRE DUMAS, 2220 - 10º ANDAR CHÁC. STO. ANTONIO - SÃO PAULO - SP - CEP: 04717-004 - TEL: 11 - 5094-9988",oFont7)
	
	nLinha += 30
	oPrn:Say(nLinha,0500,"FÁBRICA: ",oFont7N)
	oPrn:Say(nLinha,0650,"AV. HÉLIO OSSAMU DAIKUARA,1800 - ALTURA DO KM 278 DA ROD. RÉGIS BITTENCOURT - EMBU - SP - CEP 06807-000 TEL: 11-4704-5522",oFont7)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	oPrn:Say(nLinha,0800,"CERTIFICADO DE QUALIDADE",oFont14N)
	
	oPrn:Say(nLinha,2050,AllTrim(cValToChar(numero))+"/"+Substr(DTOC(dDataBase),7,4),oFont12)
	
	oPrn:BOX(nLinha,1950,nLinha+60,2300)        //box numero do certificado
	
	nLinha += 60
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	//vejo se a tabela esta aberta
	cQuery := "SELECT SA1.A1_NOME,SA1.A1_ENDCOB,SA1.A1_MUNC,SA1.A1_ESTC,SA1.A1_CEPC, "
	cQuery += "       SA1.A1_END,SA1.A1_MUN,SA1.A1_EST,SA1.A1_CEP "
	cQuery += "  FROM " + RetSqlName("SF2") + " SF2 "
	cQuery += "  JOIN " + RetSqlName("SA1") + " SA1 "
	cQuery += "    ON SF2.F2_CLIENTE = SA1.A1_COD AND "
	cQuery += "       SA1.A1_LOJA = SF2.F2_LOJA AND "
	cQuery += "       SA1.D_E_L_E_T_ = '' "
	cQuery += " WHERE SF2.F2_DOC = '" + CNOTA + "' AND "
	cQuery += "       SF2.F2_SERIE = '" + CSERIE + "' AND "
	cQuery += "       SF2.F2_FILIAL = '" + CFILANT + "' AND "
	cQuery += "       SF2.D_E_L_E_T_ = ''"
	
	If Select("TMP_3") > 0
		TMP_3->(DbCloseArea())
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_3',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	nLinha += 20
	oPrn:Say(nLinha,0100,"Cliente: ",oFont12)
	oPrn:Say(nLinha,0400,AllTrim(TMP_3->A1_NOME),oFont12)
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 20
	oPrn:Say(nLinha,0100,"Endereço: ",oFont12)
	oPrn:Say(nLinha,0400,IIF(empty(TMP_3->A1_ENDCOB),AllTrim(TMP_3->A1_END),AllTrim(TMP_3->A1_ENDCOB)),oFont12)
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 20
	oPrn:Say(nLinha,0100,"Cidade: ",oFont12)
	oPrn:Say(nLinha,0400,IIF(empty(TMP_3->A1_MUNC),AllTrim(TMP_3->A1_MUN),AllTrim(TMP_3->A1_MUNC)),oFont12)
	
	oPrn:Say(nLinha,1500,"UF: ",oFont12)
	oPrn:Say(nLinha,1600,IIF(empty(TMP_3->A1_ESTC),TMP_3->A1_EST,TMP_3->A1_ESTC),oFont12)
	
	oPrn:Say(nLinha,1900,"CEP: ",oFont12)
	oPrn:Say(nLinha,2050,IIF(empty(TMP_3->A1_CEPC),Transform(TMP_3->A1_CEP,"@r 99999-999"),Transform(TMP_3->A1_CEPC,"@r 99999-999")),oFont12)

	TMP_3->(DbCloseArea())

	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	oPrn:Say(nLinha,0900,"Descrição do Fornecimento",oFont12N)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	//Numero das Notas Fiscais
	cQuery := "SELECT DISTINCT SD2.D2_PEDIDO,SC6.C6_PEDCLI "
	cQuery += " FROM "
	cQuery += RetSqlName("SD2")+" SD2 "
	cQuery += " LEFT OUTER JOIN "
	cQuery += RetSqlName("SC6")+" SC6 "
	cQuery += " ON SD2.D2_FILIAL = SC6.C6_FILIAL AND"
	cQuery += "    SD2.D2_DOC = SC6.C6_NOTA AND"
	cQuery += "    SD2.D2_SERIE = SC6.C6_SERIE AND"
	cQuery += "    SC6.D_E_L_E_T_ = ''"
	cQuery += " WHERE SD2.D2_FILIAL = '" + xFilial("SD2") + "' AND"
	cQuery += "       SD2.D_E_L_E_T_ = '' AND"
	cQuery += "       SD2.D2_DOC = '" + CNOTA +"' AND"
	cQuery += "       SD2.D2_SERIE = '" + CSERIE + "'
	
	If Select("TMP_4") > 0
		TMP_4->(DbCloseArea())
	EndIf
	
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMP_4",.F.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	//Agrupando os Pedidos de Venda
	TMP_4->( DBGoTop () )
	While TMP_4->( .Not. Eof() )
		cPedido += Iif( Empty( cPedido ), "", "/" )
		cPedido += TMP_4->D2_PEDIDO
		TMP_4->( DBSkip() )
	EndDo
	
	nLinha += 20
	oPrn:Say(nLinha,0100,"Pedido:",oFont12)
	oPrn:Say(nLinha,0400, TransForm( cPedido, PesqPict("SC5","C5_NUM", TamSx3("C5_NUM")[1] ) ),oFont12)
	
	TMP_4->(DbCloseArea())
	
	
	//dados da nota
	cQuery := " SELECT SC5.C5_NUM,SC6.C6_CF "
	cQuery += " FROM " + RetSqlName("SC5") + " SC5 "
	cQuery += "  LEFT OUTER JOIN " + RetSqlName("SC6")+" SC6 "
	cQuery += "               ON SC6.C6_FILIAL = '" + xFilial("SC6") + "' AND "
	cQuery += "                  SC5.C5_NUM = SC6.C6_NUM AND "
	cQuery += "                  SC6.D_E_L_E_T_ = ''"
	cQuery += "  WHERE SC5.C5_NOTA = '" + CNOTA + "' AND "
	cQuery += "        SC5.C5_SERIE = '" + CSERIE + "' AND "
	cQuery += "        SC5.C5_FILIAL = '" + CFILANT + "' AND "
	cQuery += "        SC5.D_E_L_E_T_ = ''"
	
	If Select("TMP_5") > 0
		TMP_5->(DbCloseArea())
	EndIf
	
	//VALIDA QUERY
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMP_5',.T.,.T.) },"Aguarde...") //"Selecionando Registros..."
	
	oPrn:Say(nLinha,0900,"Nota Fiscal:",oFont12)
	oPrn:Say(nLinha,1200,cNota+"-"+cSerie,oFont12)
	oPrn:Say(nLinha,1600,Transform(TMP_5->C6_CF,"@r 9.999"),oFont12)
	
	oPrn:Say(nLinha,1900,"Data:",oFont12)
	oPrn:Say(nLinha,2050,DTOC(dDataBase),oFont12)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
	
	TMP_5->(dbCloseArea())
	//**********************************************************//
	
	nLinha += 20
	oPrn:Say(nLinha,0600,"Material",oFont12N)
	oPrn:Say(nLinha,1800,"Quantidade",oFont12N)
	oPrn:BOX(nLinha-20,0080,nLinha+50,1400)        //box
	
	nLinha += 50
	oPrn:Line(nLinha,0080,nLinha,2300)
		
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FinalRel  ºAutor  ³Marcos Santos       º Data ³  12-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Finaliza o relatorio.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Procedure FinalRel()
  oPrn:Line(0290,0080,2900,0080)       //primeira linha vertical
  oPrn:Line(0290,2300,2900,2300)       //segunda linha vertical                                                            
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Roda      ºAutor  ³Marcos Santos       º Data ³  12-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Radape da pagina.                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Procedure Roda()
	nLinha := 2900
	oPrn:Line(nLinha,0080,nLinha,2300) //ultima linha
	nLinha += 20
	oPrn:Say(nLinha,1300,DTOC(dDataBase),oFont8)
	oPrn:Say(nLinha,1500,Time(),oFont8)
	oPrn:Say(nLinha,1800,"Página: "+cValToChar(nPag),oFont8)
	nPag += 1
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Marcos Santos       º Data ³  12-09-11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica o grupo de perguntas, e cria se for necessario.   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Procedure AjustaSX1(cPerg)

Local aArea := GetArea()
Local nPos

	//limpo a memoria
	DbSelectArea("SX1")
	SX1->( DbSetOrder(1) )
	FOR nPos := 1 TO 2
		If SX1->( DBSeek( PadR( cPerg, 10) + PadL( cValToChar( nPos ), 2, "0" ) ) )
			Reclock("SX1",.F.)
			SX1->X1_CNT01 := ""
			SX1->(MsUnlock())
		Endif
	NEXT

	PutSx1(cPerg,"01","Certificado de Análise Química nº: "," "," ","mv_ch1","C",10,0,0,"G","","","","",   "mv_par01","","","","","","","","","","","","",""," "," "," ",{"Certificado de Análise Química nº"},{"Certificado de Análise Química nº"},{"Certificado de Análise Química nº"})
	PutSx1(cPerg,"02","Nota: "," "," ",                             "mv_ch2","C",9,0,0 ,"G","","SF2","","","mv_par02","","","","","","","","","","","","",""," "," "," ",{"Nota"},{"Nota"},{"Nota"})
	
	RestArea(aArea)
	  	
Return

