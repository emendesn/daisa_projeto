#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"                         
#INCLUDE "COLORS.CH"       
#INCLUDE "FONT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPRT0090    บAutor  ณMarcos Santos      บ Data ณ  08-09-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Packing List                                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PRT0090(cNum,cFil)  
	Private cNumPed	:= cNum
	Private cFilPed	:= cFil
	Private aMeses   := {"JANEIRO", "FEVEREIRO", "MARวO", "ABRIL", "MAIO", "JUNHO",;
	           					 "JULHO", "AGOSTO", "SETEMBRO",	"OUTUBRO", "NOVEMBRO", "DEZEMBRO"}

 	Private nLinBx1  := 0
 	Private nlinBx2  := 0
	PRIVATE nLinha 	 := 0
	PRIVATE nVol   	 := 0
	PRIVATE oPrn
	Private oBrushPr := TBrush():New(,RGB(0  ,0  ,0))
	Private oBrushCZ := TBrush():New(,RGB(200,200,200))  
              
	oPrn := TMSPrinter():New("PRT0090 - Packing List")
	
	//DEFININDO AS FONTS
	DEFINE FONT oFont8   NAME "Arial" SIZE 0,08 OF oPrn
	DEFINE FONT oFont8N  NAME "Arial" SIZE 0,08 OF oPrn BOLD
	DEFINE FONT oFont10  NAME "Arial" SIZE 0,10 OF oPrn       
	DEFINE FONT oFont10E NAME "Arial Narrow" SIZE 0,10 OF oPrn   //exclusiva desse projeto
	DEFINE FONT oFont10N NAME "Arial" SIZE 0,10 OF oPrn BOLD
	DEFINE FONT oFont12  NAME "Arial" SIZE 0,12 OF oPrn 
	DEFINE FONT oFont12N NAME "Arial" SIZE 0,12 OF oPrn BOLD
	DEFINE FONT oFont14  NAME "Arial" SIZE 0,14 OF oPrn 
	DEFINE FONT oFont14N NAME "Arial" SIZE 0,14 OF oPrn BOLD
	DEFINE FONT oFont20  NAME "Arial" SIZE 0,20 OF oPrn BOLD

	//Monto o relatorio 
	
	oPrn:SetPortrait()
	oPrn:Setup()  
	
	Relatorio(oPrn, cNumPed,cFilPed)      
  
	oPrn:Preview()  
	oPrn:End()

	Ms_Flush()
Return                          

STATIC FUNCTION Relatorio(oPrn, cNumPed,cFilPed)
	Local 	cQuery  := nil 
	Local 	cNota   := nil
	Local 	nItem   := 0
	Local 	llOk := .T.
	Private nPagina := 0

	//cabe็alho
	Cabec(oPrn, cNumPed,cFilPed)

	//corpo
	nLinha += 70
	oPrn:Line(nLinha-10,0080,nLinha-10,2300)  
	nLinha += 10  	                         
           
	cQuery := "SELECT SC9.C9_ITEM, SZD.ZD_VOLUME, SB1.B1_DESCOMP , SZD.ZD_QTDVOL, C9_EXPFLAG, C9_NFISCAL";
		      	+ " FROM " + RetSqlName("SZD") + " SZD";
				+ " JOIN " + RetSqlName("SC9") + " SC9 ON SZD.ZD_FILIAL = SC9.C9_FILIAL AND SZD.ZD_PEDIDO = SC9.C9_PEDIDO";
				+										" AND SZD.ZD_ITEMPV = SC9.C9_ITEM AND SC9.D_E_L_E_T_ <> '*' "
	If Empty(SC9->C9_NFISCAL)
		cQuery += " AND C9_EXPFLAG = '"+SC9->C9_EXPFLAG+"'"
	Else
		cQuery += " AND C9_NFISCAL = '"+SC9->C9_NFISCAL+"'"
		cQuery += " AND C9_SERIENF = '"+SC9->C9_SERIENF+"'"
	EndIf
			
	cQuery += " JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_COD = SC9.C9_PRODUTO AND SB1.D_E_L_E_T_ <> '*'";
			    + " WHERE SZD.ZD_FILIAL = '" 	+ cFilPed + "'";
				+ " AND SZD.ZD_PEDIDO = '"		+ cNumPed + "'";
				+ " AND SZD.D_E_L_E_T_ <> '*'";
				+ " ORDER BY SZD.ZD_VOLUME"
  			
	VerTabela("TMPTR90")
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPTR90",.T.,.T.)
	
	TMPTR90->(DbGotop())

	While TMPTR90->(!Eof())
		/*If !Empty(TMPTR90->C9_NFISCAL)
			If TMPTR90->C9_NFISCAL == SC9->C9_NFISCAL
				llOk := .T.
			Else
				llOk := .F.
			EndIf
		Else
			If TMPTR90->C9_EXPFLAG == SC9->C9_EXPFLAG
				llOk := .T.
			Else
				llOk := .F.
			EndIf
		EndIf*/
		If llOk
	  		oPrn:Say(nLinha,0210,cValToChar(TMPTR90->ZD_VOLUME),oFont12)
	  		oPrn:Say(nLinha,0380,AllTrim(TMPTR90->B1_DESCOMP)/*,1,43)*/,oFont10E)
	  		oPrn:Say(nLinha,1420,cValToChar(Transform(TMPTR90->ZD_QTDVOL,"@E 9,999,999")),oFont12)

	 		TMPTR90->(dbSkip())
	 		
	   		oPrn:Line(nLinha+50,0080,nLinha+50,2300)
			If nLinha >= 2900
	   			FinalRel()
	   			oPrn:EndPage()
	    		Cabec(oPrn,cNumPed,cFilPed)
	    		nPagina += 1
	  		EndIf
			nLinha += 70
		Else
			TMPTR90->(dbSkip())		
		EndIf
	EndDo
	//TMPTR90->(dbCloseArea()) 
	//************************************************************************//     

	//insiro as 2 ultimas linhas
	//oPrn:Line(nLinha+50,0080,nLinha+50,2300)     
	//oPrn:Line(nLinha+120,0080,nLinha+120,2300)     
  //oPrn:Say(nLinha+130,0110,"Nome do Funcionแrio:",oFont12)                                                                   
  //oPrn:Say(nLinha+130,1900,"Data: "+DTOC(dDataBase),oFont12)                                          

	FinalRel() 

	//fim de pagina
	oPrn:EndPage()
	TMPTR90->(dbCloseArea()) 
Return         
                          
//fun็ใo cabe็alho
Static Function Cabec(oPrn,cNumPed,cFilPed)
	Local cQuery := nil
	Local cLogo

	//inicio de pagina
	oPrn:StartPage()

	//linha,posicao,angulo,fim
	nLinha := 50
	oPrn:Line(nLinha,0080,nLinha,2300)    //primeira linha horizontal

	//linha,posicao,alt,larg     box logotipo
	oPrn:BOX(nLinha,0080,0330,0500)

	//logotipo
	DO CASE
  		Case cFilPed = "01"//DAISA MATRIZ
   			cLogo  := '\system\logo_daisa.jpg'
  		Case cFilPed = "02"//FUNDICAO
   			cLogo  := '\system\logo_fundicao.jpg'
  		Case cFilPed = "03"//DAIBRAS
   			cLogo  := '\system\logo_daibras.jpg'
  		Case cFilPed = "04"//DAISA INDUSTRIAL
   			cLogo  := '\system\logo_daisa.jpg'
   		Case cFilPed = "05"//DAISA COMERCIO
   			cLogo  := '\system\logo_daisa.jpg'           	
  		Case cFilPed = "99"//EMPRESA TESTE
   			cLogo  := '\system\logo_daisa.jpg'
	ENDCASE	

	nLinha := 55    
	oPrn:SayBitmap(nLinha, 0120,alltrim(cLogo),0300,0250)	
	//**************************************************************//
	nLinha := 50
 	oPrn:FillRect({ nLinha ,500,nLinha+70, 1750 },oBrushPr) 
  	oPrn:Say(nLinha+12,1055 ,"Formulแrio" ,oFont14N,,CLR_WHITE)

	nLinha := 120
	oPrn:Line(nLinha,0500,nLinha,1750)    

	nLinha := 190
	oPrn:Say(nLinha,1040,"Packing List",oFont14N)                                          

	nLinha := 330
	oPrn:Line(nLinha,0500,nLinha,1750) 

  //QUADRO NO CANTO DIREITO DA TELA 
  nLinha := 50
  oPrn:BOX(nLinha,1750,0330,2300)  
  oPrn:Say(nLinha+10,1760,"C๓d.:",oFont12N)
  oPrn:Say(nLinha+15,1900,"FL-EXP-002-00",oFont10)

  nLinha := 120
  oPrn:Line(nLinha,1750,nLinha,2300)
  oPrn:Say(nLinha+10,1760,"Emissใo: ",oFont12N)
  oPrn:Say(nLinha+15,1965,aMeses[val(substr(DTOS(dDataBase),5,2))]+"/"+substr(DTOS(dDataBase),1,4),oFont10E)

  nLinha := 190
  oPrn:Line(nLinha,1750,nLinha,2300)    
  oPrn:Say(nLinha+10,1760,"Pแgina: ",oFont12N)  
  oPrn:Say(nLinha+15,1930,alltrim(str(nPagina+1)),oFont10) 

  nLinha := 260
  oPrn:Line(nLinha,1750,nLinha,2300)
  oPrn:Say(nLinha+10,1760,"Status:",oFont12N)    
  oPrn:Say(nLinha+15,1930,"Aprovado.",oFont10) 
  //--------------------------------

	nLinha += 70
	oPrn:Line(nLinha,0080,nLinha,2300) 
	nLinha += 20
	oPrn:Say(nLinha,950,"PACKING LIST",oFont20) 
	
	nLinha += 80  
  	oPrn:Say(nLinha,820,"Relat๓rio de verifica็ใo de itens do pedido.",oFont12)    
    
	nLinha += 70  
	nLinBx1 := nLinha
	oPrn:Line(nLinha,0080,nLinha,2300)       

	nLinha += 70	
	oPrn:Line(nLinha,0080,nLinha,2300) 
	oPrn:Line(nLinha,0680,nLinha+70,0680)  // linha vertical    
	oPrn:Say(nLinha+10,0080,Space(5)+"DAISA",oFont14N)    
	
	//busco os dados do cliente do pedido
	cQuery := "SELECT SC5.C5_NOTA, SC5.C5_SERIE, SA1.A1_NOME";
			+ " FROM " + RetSqlName("SC5") + " SC5";
			+ " JOIN " + RetSqlName("SA1") + " SA1 ON A1_FILIAL = '"+xFilial("SA1")+"' AND SC5.C5_CLIENTE = SA1.A1_COD AND SC5.C5_LOJACLI = SA1.A1_LOJA AND SA1.D_E_L_E_T_ <> '*'";
			+ " WHERE SC5.C5_FILIAL = '"	+ cFilPed + "'";
			+ " AND SC5.C5_NUM = '" 		+ cNumPed + "'";
			+ " AND SC5.D_E_L_E_T_ <> '*'"

	VerTabela("TMPTR90_1")

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPTR90_1",.T.,.T.)

	nLinha += 70
	oPrn:Line(nLinha,0080,nLinha,2300)
  	oPrn:FillRect({nLinha-2 ,372,nLinha+68, 2298},oBrushCZ) 
	oPrn:Say(nLinha+10,0110,"Cliente:",oFont12)                                          
	oPrn:Say(nLinha+10,0380,TMPTR90_1->A1_NOME,oFont12)
	oPrn:Say(nLinha+10,1710,"Pedido: " + cValToChar(cNumPed),oFont12)                    

	cNota := TMPTR90_1->C5_NOTA + TMPTR90_1->C5_SERIE 

	TMPTR90_1->(dbCloseArea()) 

	nLinha += 70           
	nlinBx2 := nLinha
	oPrn:Line(nLinha,0080,nLinha,2300)
	//************************************************************************//
	
  	nLinha += 70
	oPrn:Line(nLinha,0080,nLinha,2300)   
	oPrn:FillRect({ nLinha-2 ,368,nLinha+128, 1398},oBrushCZ)      //pinta o fundo da c้lula   
	oPrn:FillRect({ nLinha-2 ,1698,nLinha+128,2298},oBrushCZ)
	
	nLinha += 10
	oPrn:Say(nLinha,1470,"Total de",oFont12)   

	nLinha += 40
	oPrn:Say(nLinha+20,0090,"NF.:",oFont12N)                                          
	oPrn:Say(nLinha+20,0380,/*cNota*/SC9->C9_NFISCAL+"-"+SC9->C9_SERIENF,oFont12N) 
	nLinha += 10	                                          

  //qtde volume total
	cQuery := "SELECT MAX(SZD.ZD_VOLUME) MAIOR";
			+ " FROM " + RetSqlName("SZD") + " SZD";
			+ " JOIN " + RetSqlName("SC9") + " SC9 ON SZD.ZD_FILIAL = SC9.C9_FILIAL AND SZD.ZD_PEDIDO = SC9.C9_PEDIDO";
			+										" AND SZD.ZD_ITEMPV = SC9.C9_ITEM AND SC9.D_E_L_E_T_ <> '*' "
	If Empty(SC9->C9_NFISCAL)
		cQuery += " AND C9_EXPFLAG = '"+SC9->C9_EXPFLAG+"'"
	Else
		cQuery += " AND C9_NFISCAL = '"+SC9->C9_NFISCAL+"'"
		cQuery += " AND C9_SERIENF = '"+SC9->C9_SERIENF+"'"
	EndIf
	cQuery 	+= " WHERE SZD.ZD_FILIAL = '" 	+ cFilPed + "'";
			+  " AND SZD.ZD_PEDIDO = '"		+ cNumPed + "'";
			+  " AND SZD.D_E_L_E_T_ <> '*'"

  VerTabela("TMPTR90_2")  
  
  dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),'TMPTR90_2',.T.,.T.)

  nVol := TMPTR90_2->MAIOR
  
  TMPTR90_2->(dbCloseArea()) 
  
	oPrn:Say(nLinha,1470,"Volumes:   " +Space(20)+cValToChar(nVol),oFont12)                                          

	nLinha += 70                                         
	oPrn:Line(nLinha,0080,nLinha,2300)  
	oPrn:Say(nLinha+10,0090,"Sacos:",oFont12N)                                          
	oPrn:Say(nLinha+10,0380,"Produto:",oFont12N)
	oPrn:Say(nLinha+10,1440,"Quantidade:",oFont12N)                                          
	oPrn:Say(nLinha+10,1710,"Verificado:",oFont12N)                                          
Return

Static Function VerTabela(tab)
	If SELECT(tab) > 0
		dbSelectArea(tab)
		dbCloseArea(tab)
	Endif
Return

//finaliza o relatorio
Static Function FinalRel()    
	Local nSalto := Iif(TMPTR90->(!EoF()),nLinha+50,nLinha-20)
  	oPrn:BOX(nLinBx1,0080,nSalto,0370)  //coluna 1
  	oPrn:BOX(nlinBx2,0370,nSalto,1400)      //coluna 2
  	oPrn:BOX(nlinBx2,1400,nSalto,1700)      //coluna 3    
  	oPrn:BOX(nLinBx1,1700,nSalto,2300)  //coluna 4   
  	oPrn:Line(0050,0080,nLinha-20,0080)        //primeira linha vertical
  	oPrn:Line(0050,2300,nLinha-20,2300)        //segunda linha vertical                                                              
Return