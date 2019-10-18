//BROWSE
User Function AC0036()
cRet := ""
  
cRet := GETADVFVAL("DA1","DA1_PRCVEN",XFILIAL("DA1")+M->UA_TABELA+M->UB_PRODUTO,1,"")
  
Return cRet