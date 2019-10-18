#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PRT0093    ºAutor  ³Felipe Basso      º Data ³  09-09-11    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Etiqueta no apontamento da montagem                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºEmpresa   ³ Daisa                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          

User Function PRT0093()

	Local aArea		:= {}
	Local cPerg		:= "MV_PRT0093"
	Local cQuery    := nil
	Local aLinha    := {}   //array que vai armazenar as linhas
	Local cConteudo := nil  //variavel que vai ser alimentada linha a linha/registro a registro.
	Local vQtd     	:= 1
	Local vI       	:= 1
	Local vTotal    := 0
	Local vCont     := 0
	Local cNum,cItem,cSeq,cProd
	Local lPerg		:= .T.
	
	//-- Grupo de Perguntas -------------------------------------------------------------
	SX1_0093(cPerg)

	//While lPerg
		If Pergunte(cPerg,.T.)
			lPerg := .T.
		Else
			lPerg := .F.
		EndIf
		If lPerg
			aArea := GetArea()
			If (!empty(MV_PAR01) .AND. !Empty(MV_PAR02)) .OR. (Empty(MV_PAR01) .AND. Empty(MV_PAR02))
				MsgStop("Preencha o Número da OP ou o Código do produto.!!")
				Return
			ElseIf Empty(MV_PAR03) .OR. MV_PAR03 == 0
				MsgStop("Preencha a Quantidade por Embalagem.!!")
				Return
			ElseIf !Empty(MV_PAR02) .AND. (Empty(MV_PAR04) .OR. MV_PAR04 == 0)
				MsgStop("Preencha a Quantidade de Etiqueta.!!")
				Return
			Endif
			
			If !Empty(MV_PAR01)
				//atribuo os filtros nas variaveis
				cNum   := AllTrim(SC2->C2_NUM)		 
				cItem  := AllTrim(SC2->C2_ITEM)		 
				cSeq   := AllTrim(SC2->C2_SEQUEN)		 
				cProd  := AllTrim(SC2->C2_PRODUTO)
				
			  	//vejo os dados da OP digitada 
				VerTabela("TAB01")
		
			  	cQuery := " SELECT C2.C2_QUANT,B1.B1_QE, B1.B1_XCODCAT, B1.B1_COD, B1.B1_DESC,B1.B1_CODBAR,C2.C2_NUM"
				cQuery +=	" FROM " + RetSQLName("SC2") + " C2"
			  	cQuery +=	" JOIN " + RetSQLName("SB1") + " B1 ON B1.B1_COD = C2.C2_PRODUTO AND B1.D_E_L_E_T_ <> '*' AND B1_FILIAL = '" + xFilial("SB1") + "'"
				cQuery +=	" WHERE C2.D_E_L_E_T_ <> '*' AND C2_FILIAL = '" + xFilial("SC2") + "'"
			    cQuery +=	" AND C2.C2_NUM = '" + cValToChar(cNum) + "'"
			    cQuery +=	" AND C2.C2_ITEM = '" + cValToChar(cItem) + "'"
			    cQuery +=	" AND C2.C2_SEQUEN = '" + cValToChar(cSeq) + "'"
			    cQuery +=	" AND C2.C2_PRODUTO = '" + cValToChar(cProd) + "'"
			
			   	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cquery),"TAB01",.F.,.T.)
			
				TAB01->B1_QE := MV_PAR03
				  //faço algumas consistencias e ja gravo as variaveis de controle de impressao
			    If empty(TAB01->C2_NUM)
					Alert("Número de OP não encontrada!")
					Return
				ElseIf TAB01->C2_QUANT = 0     
					Alert("Quantidade Produzida está Zerada!")
					Return
				//Elseif TAB01->B1_QE = 0
				  //	Alert("Quantidade por Embalagem está Zerada!")
			  		//Return
				Else
					vQtd := TAB01->B1_QE
					
					If TAB01->B1_QE > TAB01->C2_QUANT
						vTotal := 1
					Else
						vTotal := INT(TAB01->C2_QUANT / TAB01->B1_QE)
		
						If TAB01->C2_QUANT % TAB01->B1_QE > 0   
							vTotal++
						Endif
					Endif
				Endif
				
			    //monto o arquivo, ao mesmo tempo faço os calculos necessários
				vCont 		:= TAB01->C2_QUANT
				cLote 		:= TAB01->C2_NUM
				cDesc 		:= TAB01->B1_DESC
				cCodDaisa 	:= TAB01->B1_XCODCAT 
				cCodProd    := TAB01->B1_COD
				cCodBar		:= TAB01->B1_CODBAR
			Else							
				cLote 		:= " "
				cDesc     	:= SB1->B1_DESC
				cCodDaisa	:= SB1->B1_XCODCAT
				cCodProd    := SB1->B1_COD
				cCodBar		:= SB1->B1_CODBAR
				vQtd		:= MV_PAR03
				vTotal		:= MV_PAR04
				vCont		:= vQtd*vTotal				
			EndIf
			
			_cPorta :="LPT1"
			
			// MSCBPRINTER("ZEBRA",_cPorta, , ,.f., , , ,4000,"Faturamento",.T.,"\IMPTER\ZEBRA")
			MSCBPRINTER("ZEBRA",_cPorta, , ,.f., , , ,4000,"Faturamento",.T.)			
			
			For vI := 1 To vTotal

				MSCBINFOETI("PRODUTO","30X50")
				
				MSCBBEGIN(vTotal,6)//inicio da montagem da imagem da etiqueta
				
				MSCBSAY(10, 2,"LOTE: " + AllTrim(cLote),                "N","C","010,010")
				MSCBSAY(11, 2,Iif(empty(cDesc)," ",AllTrim(cCodDaisa)),"N","C","010,010")
				MSCBSAY(12, 2,AllTrim(cCodProd),                        "N","C","010,010")

				MSCBSAYBAR(14,26,cCodBar,"N","MB07",05,.F.,.F.,.F.,,4,2,.t.)
				
				MSCBEND()
			
				MSCBCLOSEPRINTER()			
							
			
/*				cConteudo := ""
				cConteudo += "LOTE: " + AllTrim(cLote)                                                                         +"¬"
				cConteudo += iif(empty(cDesc)," ",AllTrim(cCodDaisa))                                                    +"¬" 
				cConteudo += AllTrim(cCodProd)                                                                         +"¬"
				cConteudo += AllTrim(cCodBar)+" "+AllTrim(cLote)                                                      +"¬"
				cConteudo += "Data: " + Substr(DTOS(dDataBase),7,2)+"/"+Substr(DTOS(dDataBase),5,2)+"/"+Substr(DTOS(dDataBase),1,4)  +"¬" */
				     
				If vCont > vQtd 
					cConteudo += "CONTÊM " + ALLTRIM(STR(vQtd))+ " UN"
				Else                  
					cConteudo += "CONTÊM " + ALLTRIM(STR(vCont))+ " UN"
				Endif
				      
				AADD(aLinha,cConteudo)
				vCont := vCont - vQtd
	    	Next vI
			  
		    //apago se tiver sido criado
//		    FERASE("C:\Arquivos de programas\PGI0833\arquivo.txt")
		    
		    //gravo o arquivo
//		    Grv_Arq_TXT("C:\Arquivos de programas\PGI0833\arquivo.txt",aLinha) 
		
				//chamo o programa delphi
//		   	WinExec("C:\Arquivos de programas\PGI0833\PGI0833.exe")
			
			RestArea(aArea)
		
		Endif
	//EndDo
Return
          
Static Function Grv_Arq_TXT(cCaminho,linha)
  Local nLin
  Local nHdl := fCreate(cCaminho) // cria o arquivo

	If ferror() # 0
		msgalert ("ERRO AO CRIAR O ARQUIVO, ERRO: " + str(ferror()))
	Else
		for nLin := 1 to len(Linha)
			fwrite(nHdl,Linha[nLin] + chr(13) + chr(10))
		next
		
		If ferror() # 0
			msgalert ("ERRO GRAVANDO ARQUIVO, ERRO: " + str(ferror()))
		Else
			fClose(nHdl)        // grava o arquivo Texto
		Endif
	Endif
Return

Static Function VerTabela(Tab)
	If SELECT(Tab) > 0
  		dbSelectArea(Tab)
  		dbCloseArea(Tab)
	Endif
Return

Static Function SX1_0093(cPerg)
	Local aArea := GetArea()
  Local nMax  := 7
  Local nI    

  //limpo a memoria
  /*Dbselectarea("SX1")
  DbsetOrder(1)
  For nI := 1 To nMax
    If dbSeek(PADR(cPerg,10)+Padl(cValToChar(nI),2,"0"))
  	  Reclock("SX1",.F.)
      SX1->X1_CNT01 := ""
      SX1->(MsUnlock())
    Endif
  Next
  SX1->(DbCloseArea())
    */
	PutSx1(cPerg,"01","Número de OP.:"	,	" "," ", "mv_ch1","C",14,0,0 ,"G","","SC2","","", "mv_par01","","","","","","","","","","","","",""," "," "," ",{"Número de OP."},{"Número de OP."},	{"Número de OP."})
//	PutSx1(cPerg,"02","Produto:"		,	" "," ", "mv_ch2","C",14,0,0 ,"G","","SB1","","", "mv_par02","","","","","","","","","","","","",""," "," "," ",{"Produtos:"},{"Produtos:"},	{"Produtos:"})
	PutSx1(cPerg,"03","Qtd. por Emb.:"	,	" "," ", "mv_ch3","N",14,0,0 ,"G","",""      ,"","", "mv_par03","","","","","","","","","","","","",""," "," "," ",{"Qtd. por Emb.:"},{"Qtd. por Emb.:"},	{"Qtd. por Emb.:"})
	PutSx1(cPerg,"04","Qtd. Etiqueta.:"	,	" "," ", "mv_ch4","N",14,0,0 ,"G","",""      ,"","", "mv_par04","","","","","","","","","","","","",""," "," "," ",{"Qtd. por Emb.:"},{"Qtd. por Emb.:"},	{"Qtd. por Emb.:"})
	
	RestArea(aArea)
Return
