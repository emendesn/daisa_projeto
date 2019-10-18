//GATILHO
User Function AC0007()
cRet := ""
  
  if (SC5->C5_TIPO <> 'B') .AND. (SC5->C5_TIPO <> 'D')
    cRet := GETADVFVAL("SA1","A1_NOME",XFILIAL("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI,1,"")
  else
    cRet := GETADVFVAL("SA2","A2_NOME",XFILIAL("SA2")+SC5->C5_CLIENTE+SC5->C5_LOJACLI,1,"")
  endif                                            
  
Return cRet