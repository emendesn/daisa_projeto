#Include "Protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DAIINFPES ºAutor  ³Mauro Sano          º Data ³  23/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Informa peso e demais infos do cliente                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                    

User Function DAIINFPES()
 
Local oPesoBr  
Local cPesoBr	:= 0
Local oPesoLq  
Local cPesoLq	:= 0

Local oVolume1 
Local nVolume1	:= 0  
Local oEspeci1	
Local cEspeci1	:= Space(TamSX3("C5_ESPECI1")[1])

Local oVolume2 
Local nVolume2	:= 0  
Local oEspeci2	
Local cEspeci2	:= Space(TamSX3("C5_ESPECI2")[1])

Local oVolume3 
Local nVolume3	:= 0  
Local oEspeci3	
Local cEspeci3	:= Space(TamSX3("C5_ESPECI3")[1])

Local oVolume4 
Local nVolume4	:= 0  
Local oEspeci4	
Local cEspeci4	:= Space(TamSX3("C5_ESPECI4")[1]) 
Local oMenNota
Local cMenNota	:= space(1000)//Space(TamSX3("C5_MENNOTA")[1]) 

Private oDlg            

If Empty(SC5->C5_NOTA)

	cPesoLq 	:= SC5->C5_PESOL
	cPesoBr 	:= SC5->C5_PBRUTO
	nVolume1 := SC5->C5_VOLUME1
	cEspeci1	:= SC5->C5_ESPECI1
	nVolume2	:= SC5->C5_VOLUME2
	cEspeci2 := SC5->C5_ESPECI2
	nVolume3	:= SC5->C5_VOLUME3
	cEspeci3	:= SC5->C5_ESPECI3
	nVolume4	:= SC5->C5_VOLUME4
	cEspeci4 := SC5->C5_ESPECI4
	cMenNota := SC5->C5_OBSNFE+Space(900)
	
	DEFINE MSDIALOG oDlg FROM  15,6 TO 309,537 TITLE "Informe dados do pedido. Pedido: " + SC5->C5_NUM  PIXEL   
	
	@ 010,008 SAY "Peso Bruto:"				SIZE 050,07 OF oDlg PIXEL  
	@ 009,040 MSGET oPesoBr Var cPesoBr		SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_PBRUTO')         
	@ 010,130 SAY "Peso Líquido"			SIZE 050,07 OF oDlg PIXEL  
	@ 009,170 MSGET oPesoLq Var cPesoLq		SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_PESOL')  
	
	@ 030,008 SAY "Volume 1"				SIZE 050,07 OF oDlg PIXEL  
	@ 029,040 MSGET oVolume1 Var nVolume1	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_VOLUME1')
	@ 030,130 SAY "Especie 1"				SIZE 050,07 OF oDlg PIXEL  
	@ 029,170 MSGET oEspeci1 Var cEspeci1	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_ESPECI1') 

	@ 050,008 SAY "Volume 2"				SIZE 050,07 OF oDlg PIXEL  
	@ 049,040 MSGET oVolume2 Var nVolume2	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_VOLUME2')
	@ 050,130 SAY "Especie 2"				SIZE 050,07 OF oDlg PIXEL  
	@ 049,170 MSGET oEspeci2 Var cEspeci2	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_ESPECI2') 

	@ 070,008 SAY "Volume 3"				SIZE 050,07 OF oDlg PIXEL  
	@ 069,040 MSGET oVolume3 Var nVolume3	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_VOLUME3')
	@ 070,130 SAY "Especie 3"				SIZE 050,07 OF oDlg PIXEL  
	@ 069,170 MSGET oEspeci3 Var cEspeci3	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_ESPECI3') 

	@ 090,008 SAY "Volume 4"				SIZE 050,07 OF oDlg PIXEL  
	@ 089,040 MSGET oVolume4 Var nVolume4	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_VOLUME4')
	@ 090,130 SAY "Especie 4"				SIZE 050,07 OF oDlg PIXEL  
	@ 089,170 MSGET oEspeci4 Var cEspeci4	SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_ESPECI4') 

	@ 110,008 SAY "Mensagem p/nota"				SIZE 050,07 OF oDlg PIXEL  
	@ 109,040 MSGET oMenNota Var cMenNota		SIZE 060,10 OF oDlg PIXEL WHEN .T. PICTURE PesqPict('SC5','C5_OBSNFE') 
	
	
	DEFINE 	SBUTTON 	FROM		132, 199 				;// Coordenadas de posicionamento
			TYPE    	1 									;// Tipo do botao - Edicao
			ENABLE OF 	oDlg  								;// Janela a qual pertence
  		   	ACTION 		u_DaiGrvPes(cPesoBr,cPesoLq,nVolume1,cEspeci1,nVolume2,cEspeci2,nVolume3,cEspeci3,nVolume4,cEspeci4,cMenNota)	 // Acao a ser executada

	DEFINE 	SBUTTON FROM	132, 227 	;// Coordenadas de posicionamento
			TYPE    		2 			;// Tipo do botao - Cancelamento
			ENABLE OF 		oDlg  		;// Janela a qual pertence
  		   	ACTION 			oDlg:End()	 // Acao a ser executada

	ACTIVATE DIALOG oDlg CENTERED
Else
	Alert("Pedido já faturado!!")
EndIf

Return()                                                                                                                   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DaiGrvPes ºAutor  ³Microsiga           º Data ³  02/23/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/   

User Function DaiGrvPes(cPesoBr,cPesoLq,nVolume1,cEspeci1,nVolume2,cEspeci2,nVolume3,cEspeci3,nVolume4,cEspeci4,cMenNota)

RecLock("SC5",.F.)

	SC5->C5_PESOL	:= cPesoLq
	SC5->C5_PBRUTO	:= cPesoBr
	SC5->C5_VOLUME1	:= nVolume1
	SC5->C5_ESPECI1	:= cEspeci1
	SC5->C5_VOLUME2	:= nVolume2
	SC5->C5_ESPECI2	:= cEspeci2
	SC5->C5_VOLUME3	:= nVolume3
	SC5->C5_ESPECI3	:= cEspeci3
	SC5->C5_VOLUME4	:= nVolume4
	SC5->C5_ESPECI4	:= cEspeci4  
	SC5->C5_OBSNFE 	:= cMenNota  
	                                                                                  
SC5->(MsUnlock())                                                                                                    
oDlg:End()

Return

