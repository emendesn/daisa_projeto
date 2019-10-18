#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"
#Include "TbiConn.Ch"
//MATA120
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVERAPROVACAOบAutor ณRafael P. Goncalvesบ Data ณ  06/01/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao chamada via schedule diariamente e verifica os      บฑฑ
ฑฑบ          ณ pedidos de compras a serem aprovados e dispara email		  บฑฑ
ฑฑบ          ณ para seus aprovadores                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
 


// ENVIA E-MAIL PARA O APROVAODR DIZENDO QUE SERA APROVADO / REPROVADO;
// * ษ NECESSARIO PARA FUNCIONAMENTO DESTE ENVIO QUE O .HTML ESTAVA INTALADO NO SERVIDOR COM O  
// SEGUINTE CAMINHO "\workflow\WFAPROVACAO.html";
// * O E-MAIL DO APROVADOR TEM QUE ESTAR CADASTRADO NO CADASTRO DE USUARIOS; 
//
User Function VerAprovacao()

	Local clQry 		:= ""
	Local nlPosAprov	:= 0	
	Local clEmailApr	:= ""
	Local clNomeUser	:= ""
	Local nlPosAlc		:= 0
	Local alAlcadas		:= {}
	Local nlI			:= 0
	Local nlX			:= 0
	Local alAprovAlc	:= {}
	Local alEmps		:= {"01","02","03"}
	Local llEnvia		:= .T.
	Private cEmpAnt		:= ""
	Private cEmpFil		:= ""
	Private apEmpUsers	:= {}
	Private apUsers   	:= {}
	
	If Select("SX2") == 0
	
		RpcSetType(3)
		RpcSetEnv("01","01",,,"COM",GetEnvServer(),{"SA1"}) 
	
	EndIf
	apUsers := AllUsers()
	For nlX := 1 To Len(alEmps)
		
		alAlcadas	:= {}
		alAprovAlc	:= {}
		
		MudaEmpFil(alEmps[nlX],"01","SC7")
		
		conout(".....ROTINA DE APROVACAO DE PEDIDO DE COMPRAS.....")	
		clQry := "SELECT C7_FILIAL, C7_NUM, CR_USER, CR_APROV, CR_NIVEL, SUM(CR_TOTAL) AS TOTPED FROM "+RetSqlName("SC7")+" SC7"
		clQry += " JOIN "+RetSqlName("SCR")+" SCR"
		clQry += " ON ( CR_FILIAL = C7_FILIAL AND CR_NUM = C7_NUM AND CR_DATALIB = ' ' )"
 		clQry += " WHERE SC7.D_E_L_E_T_ <> '*' AND SCR.D_E_L_E_T_ <> '*' AND C7_CONAPRO = 'B' AND C7_QUJE < C7_QUANT"
		clQry += " GROUP BY C7_FILIAL, C7_NUM, CR_USER, CR_APROV, CR_NIVEL"
		clQry += " HAVING C7_FILIAL+C7_NUM+CR_NIVEL IN ( "
		clQry += " 	SELECT C7_FILIAL+C7_NUM+MIN(CR_NIVEL) FROM "+RetSqlName("SC7")+" SC7"
		clQry += " 	JOIN "+RetSqlName("SCR")+" SCR"
		clQry += " 	ON ( CR_FILIAL = C7_FILIAL AND CR_NUM = C7_NUM AND CR_DATALIB = ' ')"
		clQry += " 	WHERE SC7.D_E_L_E_T_ <> '*' AND SCR.D_E_L_E_T_ <> '*' AND C7_CONAPRO = 'B' AND C7_QUJE < C7_QUANT"
		clQry += "	GROUP BY C7_FILIAL, C7_NUM )"
		clQry += " ORDER BY C7_FILIAL, C7_NUM, CR_USER, CR_APROV, CR_NIVEL"
		
		If Select("APROV") > 0
			APROV->(DbCloseArea())
		EndIf
	    
	  	TcQuery clQry New Alias "APROV"
	
		While APROV->(!Eof())
			nlPosAlc := aScan(alAprovAlc,{|aX| aX[1] == APROV->CR_USER .AND. aX[2] == APROV->CR_APROV })		
			If nlPosAlc == 0									
				aAdd(alAprovAlc,{APROV->CR_USER,APROV->CR_APROV,{{APROV->C7_FILIAL,APROV->C7_NUM,APROV->TOTPED}}})
			Else
				aAdd(alAprovAlc[nlPosAlc,3],{APROV->C7_FILIAL,APROV->C7_NUM,APROV->TOTPED})
			EndIf
			APROV->(DbSkip( ))
		EndDo
		
		// Manda email por aprovador
		For nlI := 1 To Len(alAprovAlc)
			//Verifica se aprovador esta autorizado na empresa corrente
			nlPosAprov 	:= aScan(apUsers,{|aX| aX[1,1] == alAprovAlc[nlI,1]})
			If nlPosAprov > 0
				If apUsers[nlPosAprov,2,6,1] == "@@@@"
					llEnvia := .T.
				Else
				 	apEmpUsers 	:= apUsers[nlPosAprov,2,6]
				 	If Len(apEmpUsers) > 0
				 		llEnvia := (aScan(apEmpUsers,{|aX| SubStr(aX,1,2) == cEmpAnt}) > 0)
				 	Else
				 		llEnvia := .F.
				 	EndIf
				EndIf
			Else
				llEnvia := .T.
		  	EndIf                                                         
			
			//clEmailApr	:= USRRETMAIL(SAL->AL_USER)		  	
		  	//If Empty(clEmailApr)
	  			clEmailApr	:= "leonardo.carbonaro@daisa.com.br"//"rafael.pgoncalves@totvs.com.br"
		 	//EndIf
		 	If llEnvia 
		 		SendAprovacao(alAprovAlc[nlI],clEmailApr)
		 	EndIf
				
		Next nlI 
		APROV->(DbCloseArea())
	Next nlX
Return (Nil)

Static Function SendAprovacao(alAprovAlc,clEmailApr)
	
	Local nlI			:= 0
	Local olP           := Nil
	Local olHtml		:= Nil   
	Local clCodProcesso	:= ""
	Local clHtmlModelo	:= ""
	Local clAssunto		:= ""  
    Local clNomeEmp		:= RetDadosEmp(cEmpAnt+"01","EMP")
    Local clFilAux		:= ""
    Local clNomeFil		:= ""
	Local llExistItem 	:= .F.
	Local nlCont		:= 1
	Local nlPosAprov	:= 0

	//Codigo do processo
	clCodProcesso	:= "ENVIO"
	
	//Caminho do template para gerar o relatorio
	clHtmlModelo	:= "E:\Totvs\Protheus10\Protheus_Data\workflow\wfaprovacao.html"
	
	//Assunto da mensagem
	clAssunto	:= "Aprovacao Pedido de Compras da Empresa: "+cEmpAnt+" - "+clNomeEmp
	
	//Inicializa o processo
	olP := TWFProcess():new(clCodProcesso, clAssunto)
	
	//Cria uma nova tarefa
	olP:newTask("Aprovacao Pedido de Compras", clHtmlModelo)
	
	//Utilizar template html
	oHtml := olP:oHtml
	clDataAux := DtoS(dDataBase)
	
	oHtml:valByName("DATA"	,Substr(clDataAux,7,2)+"/"+Substr(clDataAux,5,2)+"/"+Substr(clDataAux,1,4))
	oHtml:valByName("HORA"	,Time())
	oHtml:valByName("CODAPROV"	,alAprovAlc[2]								)
	oHtml:valByName("USERAPROV"	,alAprovAlc[1]+" - "+UsrRetName(alAprovAlc[1]))
    //Dados do Pedido de Compra
	oHtml:valByName("EMPRESA"	,cEmpAnt+" - "+clNomeEmp)

	SAK->(DbSetOrder(1))
	If SAK->(DbSeek(xFilial("SAK")+alAprovAlc[2]))
		For nlI := 1 To Len(alAprovAlc[3])
			
			If alAprovAlc[3,nlI,3] >= SAK->AK_LIMMIN .AND. alAprovAlc[3,nlI,3] <= SAK->AK_LIMMAX
				//If aScan(apEmpUsers,{|aX| aX == cEmpAnt+cFilAnt}) > 0

					llExistItem := .T.
					If clFilAux <> alAprovAlc[3,nlI,1]
						clFilAux	:= alAprovAlc[3,nlI,1]
			        	clNomeFil 	:= RetDadosEmp(cEmpAnt+clFilAux,"FIL")
			        EndIf 
					aAdd(	oHtml:valByName("T1.0") , StrZero(nlCont,4)		)
					aAdd(	oHtml:valByName("T1.1") , clFilAux +" - "+ clNomeFil	)
					aAdd(	oHtml:valByName("T1.2") , alAprovAlc[3,nlI,2]	)
					aAdd(	oHtml:valByName("T1.3") , Transform(alAprovAlc[3,nlI,3],PesqPict("SCR","CR_TOTAL"))	)
					nlCont++
				//EndIf
			EndIf
		Next nlI
	EndIf
	//Informa assunto
	olP:cSubject := clAssunto
	
	//Endereco eletronico de envio
	olP:cTo := clEmailApr
	
	If llExistItem
		//Gera o processo
		olP:start()
		olP:finish()
	EndIf
	
Return (Nil)        

Static Function RetDadosEmp(clEmpFil,clOrigem)
	
	Local clRet := ""

	DbSelectArea("SM0")
	SM0->(DbGoTop())
	If SM0->(DbSeek(clEmpFil, .F. ))
		clRet := Iif(clOrigem=="EMP",SM0->M0_NOMECOM,SM0->M0_FILIAL )
	EndIf

Return (Alltrim(clRet))

//Muda de empresa e filial corrente
Static Function MudaEmpFil(clEmp,clFil,clAlias)

	Local nlRegSM0 := 0
	
	If Select("SX2") == 0
	
		RpcSetType(3)
		RpcSetEnv(clEmp,clFil,,,"COM",GetEnvServer(),{"SA1"}) 
	
	ElseIf cEmpAnt+cFilAnt <> clEmp+clFil

		//Sleep(100000) //Para 1minuto
		
		nlRegSM0 := SM0->(RECNO()) 
		
		DbSelectArea("SM0")
		SM0->(DbGoTop())
		If SM0->(DbSeek(clEmp+clFil, .F. ) )

	    	nlRegSM0 := SM0->(Recno())
		           
	   		DbCloseAll()	                
			RpcClearEnv()
			OpenSM0() 
			SM0->(DbGoTo(nlRegSM0))
			RpcSetType(3)
			RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,"COM",GetEnvServer(),{"SX3","SC7","SCR","SAL"})
		
		EndIf
	EndIf
	
	DbSelectArea( clAlias )
	
Return (Nil)
