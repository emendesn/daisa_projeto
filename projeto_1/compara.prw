#include "Protheus.ch"
#include "TopConn.ch"
#include "RwMake.ch"

User Function ComparaSX(clSX,clArq1,clArq2)
	
	Local clDir 	:= "E:\Totvs\Protheus10_Prototipo2\Protheus_Data\system\Comparacao\"
	Local clArqLog	:= clDir+clArq1+"_X_"+clSX+cEmpAnt+"0.log"
	Local alMsgsLog	:= {}
	Local clMsg		:= ""
	Local clInd		:= ""
	Local llOk		:= .F.
	Local nlOrder	:= 1
	Local clCampo	:= ""
		
	If clSX == "SX3"
		nlOrder	:= 2
		clInd 	:= "X3_ARQUIVO+X3_CAMPO"
	ElseIf  clSX == "SX1"
		clInd 	:= "X1_GRUPO+X1_ORDEM"
	ElseIf clSX == "SXB"
		clInd 	:= "XB_ALIAS+XB_TIPO+XB_SEQ+XB_COLUNA"
	ElseIf clSX == "SX7"
		clInd 	:= "X7_CAMPO+X7_SEQUENC"
	EndIf	
	
	If Select("TRB1") > 0
		TRB1->(DbCloseArea())
	EndIf
		
	dbUseArea(.T.,"DBFCDXADS",clArq1 ,"TRB1",.F.,.F.)

	IndRegua("TRB1",clArq1,clInd,,,"Selecionando Registros...") //"Selecionando Registros..."

	nCont := 0
	TRB1->(DbGoTop())
	While TRB1->(!EoF()) //.AND. nCont <= 2
		//Verifica se nao existe o registro no outro arquivo
		DbSelectArea(clSX)
		DbSetOrder(nlOrder)
		//Verifica na SX da empresa corrente se possui o registro da tabela temporaria
		If !(DbSeek(&("TRB1->("+Iif(clSX == "SX3","X3_CAMPO",clInd)+")")))
			llOk := .T.
			//nCont++
			If clSX <> "SX3"
				If RecLock(clSX,.T.)
					For nlI := 1 To TRB1->(FCount())
						clCampo := FieldName(nlI)
						&(clSX+"->"+clCampo) := &("TRB1->"+clCampo)
					Next nlI
					&(clSX+"->(MsUnlock())")
				EndIf
			Else
				clMsg := "X3_CAMPO == '"+PadR(Alltrim(TRB1->X3_CAMPO),10)+"' .OR. "
				aAdd(alMsgsLog,clMsg)			
			EndIf
		EndIf
		TRB1->(DbSkip())
	EndDo
	
	If clSX == "SX3"
		If Len(alMsgsLog) > 0
	
			If GravaLog(clArqLog,alMsgsLog)
				MsgStop("Arquivo "+clArqLog+" gerado com sucesso!")
			Else
				MsgStop("Erro ao gerar o arquivo!")
			EndIf
		Else
			MsgStop("Arquivos SEM divergencia!")
		EndIf
	Else
	    If llOk
   		    MsgStop("Copia gerada com sucesso!")
	    Else
		    MsgStop("Arquivos SEM divergencia!")
	    EndIf
		
	EndIf
	
Return (Nil)

Static Function GravaLog(clArqLog,alMsgsLog)
  
	Local nlHandle 	:= 0	
    Local nlI		:= 0
    Local llRet		:= .T.
    
	nlHandle := FCreate(clArqLog,0)
	 
	If nlHandle <> -1
		For nlI := 1 To Len(alMsgsLog)
		
			FWrite(nlHandle,alMsgsLog[nlI]+CHR(13)+CHR(10))

		Next nlI
		FClose(nlHandle)
	Else
		llRet := .F.
	EndIf


Return (llRet)
