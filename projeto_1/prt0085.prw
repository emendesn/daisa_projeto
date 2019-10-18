#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPRT0085    บAutor  ณMarcos Santos      บ Data ณ  02-09-11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de transferencia entre almoxarifados             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบEmpresa   ณ Daisa                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PRT0085()  

Local cPerg         := "MV_PRT0085"
Local cQuery        := nil
Local cDIni         := nil
Local cDFim         := nil

Local cInd
Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Relat๓rio de Transfer๊ncias"
Local cPict         := ""
Local titulo        := "Relat๓rio de Transfer๊ncias"
Local nLin          := 80
Local Cabec1        := "COD.DAISA       COD.PROTHEUS    LOTE            ORIGEM          DESTINO         QTDE     USUARIO      HORA        DATA"
Local Cabec2        := Space(82)
Local imprime       := .T.
Local aOrd          := {}

Private cString     := ""
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "M"
Private nomeprog    := "PRT0085" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "PRT0085" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cFilRel     := nil
Private cPerda      := nil   

//grupo de perguntas
SX1_0085(cPerg)

If !Pergunte(cPerg,.T.)
  Return
Endif
                        
//carrego o parametro dos TMs de perda
cPerda := SuperGetMV("MV_TMPERDA",.F.,"1")

//executo a query com os filtros do grupo de pergunta
CQUERY := " SELECT SB1.B1_CODANT,SB1.B1_COD, SD3.D3_LOTECTL,SBE.BE_DESCRIC, "
CQUERY += " SD3.D3_QUANT,SD3.D3_USUARIO,SD3.D3_HORA,SD3.D3_EMISSAO,SD3.D3_NUMSEQ,SD3.D3_LOCAL "
CQUERY += " FROM "+ RETSQLNAME("SD3")+" SD3 "
CQUERY += "  JOIN "+ RETSQLNAME("SB1")+" SB1 "
//CQUERY += "    ON SD3.D3_FILIAL = SB1.B1_FILIAL "
CQUERY += "    ON SD3.D3_COD = SB1.B1_COD " 
CQUERY += "    AND SB1.D_E_L_E_T_ <> '*'"
CQUERY += "  JOIN "+ RETSQLNAME("SBE")+" SBE "
//CQUERY += "    ON SD3.D3_FILIAL = SBE.BE_FILIAL "
CQUERY += "    ON SD3.D3_LOCAL = SBE.BE_LOCAL "
CQUERY += "    AND SBE.D_E_L_E_T_ <> '*'"
CQUERY += " WHERE SD3.D_E_L_E_T_ <> '*' "
CQUERY += " AND SD3.D3_FILIAL = '"+CFILANT+"'"
CQUERY += " AND SD3.D3_CF LIKE 'RE%' "
CQUERY += " AND SD3.D3_TM NOT IN ("+CPERDA+")"
CQUERY += " AND SBE.BE_DESCRIC <> '' "    //TEMPORARIO

IF !EMPTY(MV_PAR01) .AND. !EMPTY(MV_PAR02)
  CQUERY += " AND SB1.B1_COD BETWEEN '"+ALLTRIM(MV_PAR01)+"' AND '"+ALLTRIM(MV_PAR02)+"'
  CFILREL:= " AND SB1.B1_COD BETWEEN '"+ALLTRIM(MV_PAR01)+"' AND '"+ALLTRIM(MV_PAR02)+"'
ENDIF

IF !EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)
  CQUERY += " AND SD3.D3_LOCAL BETWEEN '"+ALLTRIM(MV_PAR03)+"' AND '"+ALLTRIM(MV_PAR04)+"'
  
  IF EMPTY(CFILREL)
    CFILREL:= " AND SD3.D3_LOCAL BETWEEN '"+ALLTRIM(MV_PAR03)+"' AND '"+ALLTRIM(MV_PAR04)+"'  
  ELSE         
    CFILREL+= " AND SD3.D3_LOCAL BETWEEN '"+ALLTRIM(MV_PAR03)+"' AND '"+ALLTRIM(MV_PAR04)+"'  
  ENDIF  
ENDIF

IF !EMPTY(MV_PAR05) .AND. !EMPTY(MV_PAR06)
  //TRATO AS DATAS
  CDINI  := DTOC(MV_PAR05)
  CDFIM  := DTOC(MV_PAR06)
  CDINI  := SUBSTR(CDINI,7,4)+SUBSTR(CDINI,4,2)+SUBSTR(CDINI,1,2) 
  CDFIM  := SUBSTR(CDFIM,7,4)+SUBSTR(CDFIM,4,2)+SUBSTR(CDFIM,1,2)      
  
  IF LEN(CDINI) = 6 
    CDINI := "20" + CDINI
  ENDIF

  IF LEN(CDFIM) = 6 
    CDFIM := "20" + CDFIM
  ENDIF
  
  CQUERY += " AND SD3.D3_EMISSAO BETWEEN '"+CDINI+"' AND '"+CDFIM+"'                      

  IF EMPTY(CFILREL)
    CFILREL:= " AND SD3.D3_EMISSAO BETWEEN '"+CDINI+"' AND '"+CDFIM+"'                      
  ELSE         
    CFILREL+= " AND SD3.D3_EMISSAO BETWEEN '"+CDINI+"' AND '"+CDFIM+"'                      
  ENDIF  
ENDIF

IF !EMPTY(MV_PAR07) .AND. !EMPTY(MV_PAR08)
  CQUERY += " AND SB1.B1_GRUPO BETWEEN '"+ALLTRIM(MV_PAR07)+"' AND '"+ALLTRIM(MV_PAR08)+"'
  
  IF EMPTY(CFILREL)
    CFILREL:= " AND SB1.B1_GRUPO BETWEEN '"+ALLTRIM(MV_PAR07)+"' AND '"+ALLTRIM(MV_PAR08)+"'                        
  ELSE         
    CFILREL+= " AND SB1.B1_GRUPO BETWEEN '"+ALLTRIM(MV_PAR07)+"' AND '"+ALLTRIM(MV_PAR08)+"'                        
  ENDIF  
ENDIF

IF !EMPTY(MV_PAR09) 
  CQUERY += " AND UPPER(SD3.D3_USUARIO) LIKE '%"+UPPER(ALLTRIM(MV_PAR09))+"%'"                                    

  IF EMPTY(CFILREL)
    CFILREL:= " AND UPPER(SD3.D3_USUARIO) LIKE '%"+UPPER(ALLTRIM(MV_PAR09))+"%'"                                    
  ELSE         
    CFILREL+= " AND UPPER(SD3.D3_USUARIO) LIKE '%"+UPPER(ALLTRIM(MV_PAR09))+"%'"                                    
  ENDIF  
ENDIF       

IF !EMPTY(MV_PAR11) .AND. !EMPTY(MV_PAR12)
  CQUERY += " AND SD3.D3_LOTECTL BETWEEN '"+ALLTRIM(MV_PAR11)+"' AND '"+ALLTRIM(MV_PAR12)+"'
  
  IF EMPTY(CFILREL)
    CFILREL:= " AND SD3.D3_LOTECTL BETWEEN '"+ALLTRIM(MV_PAR11)+"' AND '"+ALLTRIM(MV_PAR12)+"'                        
  ELSE         
    CFILREL+= " AND SD3.D3_LOTECTL BETWEEN '"+ALLTRIM(MV_PAR11)+"' AND '"+ALLTRIM(MV_PAR12)+"'                        
  ENDIF  
ENDIF

DO CASE
	CASE MV_PAR10 = 1      //CODIGO DAISA
		CQUERY += " ORDER BY SB1.B1_CODANT"
	CASE MV_PAR10 = 2      //DATA
		CQUERY += " ORDER BY SD3.D3_EMISSAO"
	OTHERWISE              //ALMOXARIFADO
		CQUERY += " ORDER BY SD3.D3_LOCAL"	
ENDCASE

memowrite("c:\query.sql",cQuery)
//TcSqlExec("SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")                  

VerTabela("TMPRT85")
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TMPRT85",.F.,.T.)

//Monta a interface padrao com o usuario...  
wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

Static Function VerTabela(tab)
	If SELECT(tab) > 0
		dbSelectArea(tab)
		dbCloseArea(tab)
	Endif
Return

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local cQuer

TMPRT85->(DbGotop())
While !TMPRT85->(EOF())
   //Verifica o cancelamento pelo usuario...                            
   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //Impressao do cabecalho do relatorio. . . 
   If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
    
   // Coloque aqui a logica da impressao do seu programa...
   @nLin,00 PSAY IIF(empty(TMPRT85->B1_CODANT),'0',Substr(AllTrim(TMPRT85->B1_CODANT),1,11))
   @nLin,16 PSAY Substr(AllTrim(TMPRT85->B1_COD),1,15)
   @nLin,32 PSAY IIF(empty(TMPRT85->D3_LOTECTL),'0',Substr(AllTrim(TMPRT85->D3_LOTECTL),1,10))
   @nLin,48 PSAY Substr(AllTrim(TMPRT85->BE_DESCRIC),1,7)                                                             
   
   //local destino
   CQUER := " SELECT SBE.BE_DESCRIC "
   CQUER += " FROM "+ RETSQLNAME("SD3")+" SD3 "
   CQUER += "  JOIN "+ RETSQLNAME("SBE")+" SBE "
   //CQUER += "    ON SD3.D3_FILIAL = SBE.BE_FILIAL "
   CQUER += "    ON SD3.D3_LOCAL = SBE.BE_LOCAL "
   CQUER += "    AND SBE.D_E_L_E_T_ <> '*'"
   CQUER += " WHERE SD3.D3_FILIAL = '"+CFILANT+"'"
   CQUER += " AND SD3.D_E_L_E_T_ <> '*' "
   CQUER += " AND SD3.D3_CF LIKE 'DE%' "
   CQUER += " AND SD3.D3_TM NOT IN ("+CPERDA+")"
   CQUER += " AND SD3.D3_NUMSEQ = '"+ALLTRIM(TMPRT85->D3_NUMSEQ)+"'"

   VERTABELA("TMPRT851")
   dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuer),"TMPRT851",.F.,.T.)                                                             
   
   If !empty(TMPRT851->BE_DESCRIC)
     @nLin,64 PSAY Substr(AllTrim(TMPRT851->BE_DESCRIC),1,8)                                                                 
   Else
     @nLin,64 PSAY " "                                                                    
   Endif  
     
   TMPRT851->(DBCloseArea())                        
   //**************************************************************/
   
   @nLin,78 PSAY TMPRT85->D3_QUANT PICTURE "@E 9,999.99"
   @nLin,89 PSAY Substr(AllTrim(TMPRT85->D3_USUARIO),1,9)                                                                     
   @nLin,102 PSAY IIF(empty(TMPRT85->D3_HORA),'00:00:00',AllTrim(TMPRT85->D3_HORA))
   @nLin,114 PSAY Substr(TMPRT85->D3_EMISSAO,7,2)+'/'+Substr(TMPRT85->D3_EMISSAO,5,2)+'/'+Substr(TMPRT85->D3_EMISSAO,1,4)    

   nLin := nLin + 1 

   TMPRT85->(dbSkip()) 
EndDo

//fecho a temporaria
TMPRT85->(DBCloseArea())
                    
//informa็๕es totalizadoras
nLin := nLin + 1 
@nLin,39 PSAY "TOTAL DE TRANSFERENCIAS DIA"                                                                 
nLin := nLin + 1                       
@nLin,0 PSAY "COD.DAISA       COD.PROTHEUS    LOTE            LOCAL            QTDE       PERDA           DATA"
nLin := nLin + 2                       
 
//executo a query com os filtros do grupo de pergunta
CQUERY := " SELECT SB1.B1_CODANT,SB1.B1_COD,SD3.D3_LOTECTL,SBE.BE_DESCRIC,SUM(SD3.D3_QUANT) TOTAL,SD3.D3_EMISSAO,SD3.D3_LOCAL "
CQUERY += " FROM "+ RETSQLNAME("SD3")+" SD3 "
CQUERY += "  JOIN "+ RETSQLNAME("SB1")+" SB1 "
//CQUERY += "    ON SD3.D3_FILIAL = SB1.B1_FILIAL "
CQUERY += "    ON SD3.D3_COD = SB1.B1_COD "
CQUERY += "    AND SB1.D_E_L_E_T_ <> '*'"
CQUERY += "  JOIN "+ RETSQLNAME("SBE")+" SBE "
//CQUERY += "    ON SD3.D3_FILIAL = SBE.BE_FILIAL "
CQUERY += "    ON SD3.D3_LOCAL = SBE.BE_LOCAL "
CQUERY += "    AND SBE.D_E_L_E_T_ <> '*'"
CQUERY += " WHERE SD3.D_E_L_E_T_ <> '*' "
CQUERY += " AND SD3.D3_CF LIKE 'RE%' "
CQUERY += " AND SD3.D3_FILIAL = '"+CFILANT+"'"
CQUERY += " AND SD3.D3_TM NOT IN ("+CPERDA+")"
CQUERY += " AND SBE.BE_DESCRIC <> '' "    //TEMPORARIO     

If !empty(cFilRel)                                              
  cQuery += cFilRel
Endif

CQUERY += " GROUP BY SB1.B1_CODANT,SB1.B1_COD,SD3.D3_LOTECTL,SBE.BE_DESCRIC,SD3.D3_EMISSAO,SD3.D3_LOCAL"
CQUERY += " ORDER BY SD3.D3_EMISSAO,SD3.D3_LOCAL"
VerTabela("TMPRT85")
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TMPRT85",.F.,.T.)

TMPRT85->(DbGotop())
While !TMPRT85->(EOF())
    
   // Coloque aqui a logica da impressao do seu programa...  
   @nLin,00 PSAY IIF(empty(TMPRT85->B1_CODANT),'0',Substr(AllTrim(TMPRT85->B1_CODANT),1,11))
   @nLin,16 PSAY Substr(AllTrim(TMPRT85->B1_COD),1,15)
   @nLin,32 PSAY iif(empty(TMPRT85->D3_LOTECTL),'0',Substr(AllTrim(TMPRT85->D3_LOTECTL),1,10))
   @nLin,48 PSAY Substr(AllTrim(TMPRT85->BE_DESCRIC),1,7)                                                             
   @nLin,64 PSAY TMPRT85->TOTAL PICTURE "@E 9999.99"

   CQUER := " SELECT SD3.D3_QUANT "
   CQUER += " FROM "+ RETSQLNAME("SD3")+" SD3 "
   CQUER += " WHERE SD3.D3_FILIAL = '"+CFILANT+"'"
   CQUER += " AND SD3.D3_CF LIKE 'RE%' "
   CQUER += " AND SD3.D_E_L_E_T_ <> '*'"
   CQUER += " AND SD3.D3_TM IN ("+CPERDA+")"
   CQUER += " AND SD3.D3_LOTECTL = '"+ALLTRIM(TMPRT85->D3_LOTECTL)+"'"
   CQUER += " AND SD3.D3_LOCAL = '"+ALLTRIM(TMPRT85->D3_LOCAL)+"'"
   VerTabela("TMPRT851")
   dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuer),"TMPRT851",.F.,.T.)                                                             
   
   If empty(cValToChar(TMPRT851->D3_QUANT))
     @nLin,74 PSAY 0 PICTURE "@E 9999.99"
   Else
     @nLin,74 PSAY TMPRT851->D3_QUANT PICTURE "@E 9999.99"
   Endif
   TMPRT851->(DBCloseArea())                        
 
   @nLin,91 PSAY Substr(TMPRT85->D3_EMISSAO,7,2)+'/'+Substr(TMPRT85->D3_EMISSAO,5,2)+'/'+Substr(TMPRT85->D3_EMISSAO,1,4)    

   nLin := nLin + 1 

   TMPRT85->(dbSkip()) 
EndDo

//fecho a temporaria
TMPRT85->(DBCloseArea())

//Finaliza a execucao do relatorio...
SET DEVICE TO SCREEN

//Se impressao em disco, chama o gerenciador de impressao...
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()
Return

//perguntas
Static Function SX1_0085(cPerg)        
Local aArea := GetArea()
Local nMax  := 10
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
    
//fa็o as perguntas           
PutSx1(cPerg,"01","Produto de: "," "," ",           "mv_ch1","C",15,0,0 ,"G","","SB1","","","mv_par01","","","","","","","","","","","","",""," "," "," ",{"Produto de"},{"Produto de"},{"Produto de"})
PutSx1(cPerg,"02","Produto ate: "," "," ",          "mv_ch2","C",15,0,0 ,"G","","SB1","","","mv_par02","","","","","","","","","","","","",""," "," "," ",{"Produto ate"},{"Produto ate"},{"Produto ate"})
PutSx1(cPerg,"03","Local de: "," "," ",             "mv_ch3","C",2,0,0 ,"G","","SBE","","","mv_par03","","","","","","","","","","","","",""," "," "," ",{"Local de"},{"Local de"},{"Local de"})
PutSx1(cPerg,"04","Local ate: "," "," ",            "mv_ch4","C",2,0,0 ,"G","","SBE","","","mv_par04","","","","","","","","","","","","",""," "," "," ",{"Local ate"},{"Local ate"},{"Local ate"})
PutSx1(cPerg,"05","Data de: "," "," ",              "mv_ch5","D",8,0,0 ,"G","","","","",   "mv_par05","","","","","","","","","","","","",""," "," "," ",{"Periodo Inicial"},{"Periodo Inicial"},{"Periodo Inicial"})
PutSx1(cPerg,"06","Data ate:"," "," ",              "mv_ch6","D",8,0,0 ,"G","","","","",   "mv_par06","","","","","","","","","","","","",""," "," "," ",{"Periodo Final"},{"Periodo Final"},{"Periodo Final"})
PutSx1(cPerg,"07","Grupo de Produto de: "," "," ",  "mv_ch7","C",4,0,0 ,"G","","SBM","","","mv_par07","","","","","","","","","","","","",""," "," "," ",{"Grupo de Produto de"},{"Grupo de Produto de"},{"Grupo de Produto de"})
PutSx1(cPerg,"08","Grupo de Produto ate: "," "," ", "mv_ch8","C",4,0,0 ,"G","","SBM","","","mv_par08","","","","","","","","","","","","",""," "," "," ",{"Grupo de Produto ate"},{"Grupo de Produto ate"},{"Grupo de Produto ate"})
PutSx1(cPerg,"09","Usuario: "," "," ",              "mv_ch9","C",15,0,0,"G","","","","",   "mv_par09","","","","","","","","","","","","",""," "," "," ",{"Usuario"},{"Usuario"},{"Usuario"})
PutSx1(cPerg,"10","Ordenar por: "," "," ",          "mv_ch10","N",1,0,2 ,"C","","","","",  "mv_par10","Produto Daisa","Produto Daisa","Produto Daisa","","Data","Data","Data","Origem","Origem","Origem","","","","","","",{"Ordenar por"},{"Ordenar por"},{"Ordenar por"})     
PutSx1(cPerg,"11","Lote de: "," "," ",              "mv_ch11","C",15,0,0,"G","","","","",  "mv_par11","","","","","","","","","","","","",""," "," "," ",{"Lote de"},{"Lote de"},{"Lote de"})
PutSx1(cPerg,"12","Lote Ate: "," "," ",             "mv_ch12","C",15,0,0,"G","","","","",  "mv_par12","","","","","","","","","","","","",""," "," "," ",{"Lote Ate"},{"Lote Ate"},{"Lote Ate"})

RestArea(aArea)
Return 
