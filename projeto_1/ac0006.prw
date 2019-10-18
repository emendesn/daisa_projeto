//BROWSE
User Function AC0006()

LOCAL cRet := ""
  
  if (M->C5_TIPO <> 'B') .AND. (M->C5_TIPO <> 'D')
    cRet := GETADVFVAL("SA1","A1_NOME",XFILIAL("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,"")
  else
    cRet := GETADVFVAL("SA2","A2_NOME",XFILIAL("SA2")+M->C5_CLIENTE+M->C5_LOJACLI,1,"")
  endif                                            
  
Return cRet
