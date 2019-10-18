#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpDA0DA1 ºAutor  ³Reginaldo G.Ribeiro º Data ³  20/12/10      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função para importação de arquivo txt Tabela de preço	      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                   
User Function fImpTabPrc()

Local cPerg		:= "IMPTPRC"
Local cArqutxt	:= "" 
Local aCampos	:= {}
Local carqTMP	:= ""
Local cNum		:= ""
Local cSerie	:= ""
Local lAtu		:=.F. 
Local aDa0		:= {}
Local aDa1		:= {}
Local lpassou	:=.F.

dbSelectArea("SB1")
SB1->(dbSetOrder(1))

dbSelectArea("DA0")        
DA0->(dbSetOrder(1))

fCheckPerg(cPerg)    
If !Pergunte(cPerg)
	Return
EndIf

cArqutxt:= Alltrim(mv_par01)


//ARMAZENA O CONTEUDO DO ARQUIVO DE TEXTO NA TABELA TEMPORARIA
	
	dbUseArea(.t.,"DBFCDX","\IMPORTAR\"+MV_PAR01,"TMP")
	dbSelectArea("TMP")
	TMP->(dbGotop())
	While !TMP->(EOF())                                                                                 
		IF !lpassou
			aadd(aDa0,{AllTrim(TMP->Tabela_Preco),"TAB PRC","1","1"})
			lpassou:=.T.
		EndIf	
		aadd(aDa1,{AllTrim(TMP->Tabela_Preco),TMP->Preal,"1","4",999999.99,"000000000999999.99",1,AllTrim(TMP->CODIGO)})
	TMP->(dbSkip())   
	End  		 
		 
	For nx:=1 to Len(aDa0)	 
		 	If !(DA0->(dbSeek(xFilial("DA0")+AllTrim(STRZERO(val(aDa0[nx,1]),3)))))
			 	RecLock("DA0",.T.)
			   		DA0->DA0_CODTAB	:= AllTrim(STRZERO(val(aDa0[nx,1]),3))
			 		DA0->DA0_DESCRI	:= AllTrim(aDa0[nx,2])
				 	DA0->DA0_DATDE	:= date()
					DA0->DA0_HORADE	:= Time()
				 	DA0->DA0_HORATE	:= Time()
				 	DA0->DA0_TPHORA	:= "1"
				 	DA0->DA0_ATIVO	:= "1"
			 	MsUnLock()
		 	EndIf            
   	Next nx
   	
   	For ny:=1 to Len(aDa1)   		
		If SB1->(dbSeek(xFilial("SB1")+AllTrim(aDa1[nx,8])))	   	
		   	If  DA1->(dbSeek(xFilial("DA1")+StrZero(VAL(aDa1[nx,1]),3)+aDa1[nx,8]))
			 	RecLock("DA1",.T.)
				    DA1->DA1_ITEM	:=STRZERO(ny,4)
				   	DA1->DA1_CODTAB	:=StrZero(VAL(aDa1[ny,1]),3)
				   	DA1->DA1_CODPRO :=aDa1[ny,8]
				   	DA1->DA1_PRCVEN	:=aDa1[ny,2]
				   	DA1->DA1_ATIVO	:=aDa1[ny,3]
				   	DA1->DA1_TPOPER	:=aDa1[ny,4]
				   	DA1->DA1_QTDLOT	:=aDa1[ny,5]
				   	DA1->DA1_INDLOT	:=aDa1[ny,6]
				   	DA1->DA1_MOEDA	:=aDa1[ny,7]	
				   	DA1->DA1_DATVIG	:=Date()
				MsUnLock()   	
		 	lAtu:=.T.                 
  		 	EndIf
	     EndIf
    Next ny 
    
    If	lAtu
		MsgInfo("Importado com Sucesso", "Importação de Romanieo")
    Else
		MsgInfo("não ha Dado a ser Importado", "Importação de Romanieo")
	EndIf

dbSelectArea("TMP")
dbCloseArea()

Return 

Static function fCheckPerg(cPerg)

Local aHelp := {}             
	
dbSelectArea("SX1")
If !dbSeek(cPerg)
	//PutSx1(cGrupo,cOrdem,cPergunt               ,cPerSpa               ,cPerEng               ,cVar     ,cTipo ,nTamanho,nDecimal,nPresel,cGSC,cValid          ,cF3  ,   cGrpSxg,cPyme ,cVar01    ,cDef01 ,cDefSpa1,cDefEng1,cCnt01                              ,cDef02    ,cDefSpa2,cDefEng2,cDef03,cDefSpa3,cDefEng3,cDef04,cDefSpa4,cDefEng4,cDef05,cDefSpa5,cDefEng5,aHelpPor,aHelpEng,aHelpSpa,cHelp)
	aHelp := {"Preencha todos os campos necessarios para a confirmacao.","Atencao"}
	PutSx1(cPerg,"01","Arquivo: ",""                    ,""                           ,"mv_ch1","C"    ,20      ,0       ,0      ,"G","NaoVazio()"    ,"   ",""         ,""   ,"mv_par01","   "  ,""      ,""      ," "                              ,"   "    ,""     ,""      ,""     ,""      ,""      ,""    ,""      ,""     ,""    ,""      ,""      ,aHelp    ,""      ,""      ,"")		
EndIf                                                                                                                                                                                                                                                                                                                                                                                                

Return 