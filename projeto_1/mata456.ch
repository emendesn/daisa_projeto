#ifdef SPANISH
	#define STR0001 "bUscar"
	#define STR0002 "Orden"
	#define STR0003 "Automatica"
	#define STR0004 "Manual"
	#define STR0005 "Aprobacion de credito / stock"
	#define STR0006 "El objetivo de este programa es aprobar automaticamente los pedidos de "
	#define STR0007 "ventas con bloqueo de stock y de credito.                              "
	#define STR0008 "Consulta situacion clientes"
	#define STR0009 "Credito"
	#define STR0010 "Lim. de cred. venc."
	#define STR0011 "Rechazado "
	#define STR0012 " Stock  "
	#define STR0013 "Aprobacion de credito"
	#define STR0014 "Pedido"
	#define STR0015 "Cond.Pago"
	#define STR0016 "Bloqueo"
	#define STR0017 "Cliente"
	#define STR0018 "Riesgo"
	#define STR0019 "Limite de credito"
	#define STR0020 "Saldo titulos"
	#define STR0021 "Pedidos aprobados"
	#define STR0022 "Saldo Lim.Credito"
	#define STR0023 "Item Pedido Actual"
	#define STR0024 "Saldo de Pedidos"
	#define STR0025 "Atraso Actual"
	#define STR0026 "Titulos Protestados"
	#define STR0027 "Cheques Devueltos"
	#define STR0028 "Mayor Compra"
	#define STR0029 "Mayor Titulo"
	#define STR0030 "Promedio Atrasos"
	#define STR0031 "Vencto.Lim.Credito"
	#define STR0032 "dias"
	#define STR0033 "Fecha Limite Aprobacion"
	#define STR0034 "En"
	#define STR0035 "Rechaza"
	#define STR0036 "Consultar"
	#define STR0037 "Leyenda"
#else
	#ifdef ENGLISH
		#define STR0001 "Search   "
		#define STR0002 "Order"
		#define STR0003 "Automatic "
		#define STR0004 "Manual"
		#define STR0005 "Credit Release / Inventory    "
		#define STR0006 "  This routine has the purpose of releasing automatically the Sale Orders     "
		#define STR0007 "  with blocking of Inventory and Credit.                                      "
		#define STR0008 "Check Customer Situation "
		#define STR0009 "Credit "
		#define STR0010 "Expired Credit Limit"
		#define STR0011 "Rejected "
		#define STR0012 "Inventory"
		#define STR0013 "Credit Release      "
		#define STR0014 "Order "
		#define STR0015 "Payment Cond."
		#define STR0016 "Blockage"
		#define STR0017 "Customer"
		#define STR0018 "Risk"
		#define STR0019 "Credit Limit     "
		#define STR0020 "T.Note Balances "
		#define STR0021 "Released Orders  "
		#define STR0022 "Credit Limit Bal."
		#define STR0023 "Curr. Order Item "
		#define STR0024 "Order Balances  "
		#define STR0025 "Current Delay"
		#define STR0026 "Protested Bills    "
		#define STR0027 "Returned Checks   "
		#define STR0028 "Biggest Pur."
		#define STR0029 "Biggest T.Note "
		#define STR0030 "Delay Average"
		#define STR0031 "Credit Limit Expiry"
		#define STR0032 "days"
		#define STR0033 "Release Limit Date   "
		#define STR0034 "In"
		#define STR0035 "Reject "
		#define STR0036 "Query   "
		#define STR0037 "Title"
	#else
		Static STR0001 := "Pesquisar"
		Static STR0002 := "Ordem"
		Static STR0003 := "Autom�tica"
		Static STR0004 := "Manual"
		Static STR0005 := "Libera��o de Cr�dito / Estoque"
		Static STR0006 := "  Este programa  tem  como  objetivo  liberar  automaticamente os pedidos de  "
		Static STR0007 := "  venda com bloqueio de estoque e de credito                                  "
		Static STR0008 := "Consulta Posicao Clientes"
		Static STR0009 := "Cr�dito"
		Static STR0010 := "Lim. de Cr�d. Venc."
		Static STR0011 := "Rejeitado"
		Static STR0012 := " Estoque"
		Static STR0013 := "Libera��o de Credito"
		Static STR0014 := "Pedido"
		Static STR0015 := "Cond.Pagto."
		Static STR0016 := "Bloqueio"
		Static STR0017 := "Cliente"
		Static STR0018 := "Risco"
		Static STR0019 := "Limite de Cr�dito"
		Static STR0020 := "Saldo Duplicatas"
		Static STR0021 := "Pedidos Liberados"
		Static STR0022 := "Saldo Lim.Cr�dito"
		Static STR0023 := "Item Pedido Atual"
		Static STR0024 := "Saldo de Pedidos"
		Static STR0025 := "Atraso Atual"
		Static STR0026 := "Titulos Protestados"
		Static STR0027 := "Cheques Devolvidos"
		Static STR0028 := "Maior Compra"
		Static STR0029 := "Maior Duplicata"
		Static STR0030 := "M�dia Atrasos"
		Static STR0031 := "Vencto.Lim.Cr�dito"
		Static STR0032 := "dias"
		Static STR0033 := "Data Limite Libera��o"
		Static STR0034 := "Em"
		Static STR0035 := "Rejeita"
		Static STR0036 := "Consulta"
		Static STR0037 := "Legenda"
	#endif
#endif

#ifndef SPANISH
#ifndef ENGLISH
	STATIC uInit := __InitFun()

	Static Function __InitFun()
	uInit := Nil
	If Type('cPaisLoc') == 'C'

		If cPaisLoc == "PTG"
			STR0001 := "Pesquisar"
			STR0002 := "Ordem"
			STR0003 := "Autom�tica"
			STR0004 := "Manual"
			STR0005 := "Libera��o de Cr�dito / Estoque"
			STR0006 := "  este programa  tem  como  objectivo  disp�r  automaticamente os pedidos de  "
			STR0007 := "  venda com bloqueio de stock e de cr�dito                                  "
			STR0008 := "Consulta Sobre A Posi��o Dos Clientes"
			STR0009 := "Cr�dito"
			STR0010 := "Limite De Cr�dito Vencido"
			STR0011 := "Rejeitado"
			STR0012 := " Stock"
			STR0013 := "Autoriza��o  De Cr�dito"
			STR0014 := "Pedido"
			STR0015 := "Cond.pagto."
			STR0016 := "Bloqueio"
			STR0017 := "Cliente"
			STR0018 := "Risco"
			STR0019 := "Limite De Cr�dito"
			STR0020 := "Duplicado Do Saldo"
			STR0021 := "Pedidos Autorizados"
			STR0022 := "Saldo Do Limite De Cr�dito"
			STR0023 := "Item Pedido Actualmente"
			STR0024 := "Saldo De Pedidos"
			STR0025 := "Atraso Actual"
			STR0026 := "T�tulos Protestados"
			STR0027 := "Cheques Devolvidos"
			STR0028 := "Maior Compra"
			STR0029 := "Maior Duplicata"
			STR0030 := "M�dia De Atrasos"
			STR0031 := "Vencto.lim.cr�dito"
			STR0032 := "Dias"
			STR0033 := "Data Limite Autoriza��o "
			STR0034 := "Em"
			STR0035 := "Rejeita"
			STR0036 := "Consulta"
			STR0037 := "Legenda"
		EndIf
		EndIf
	Return Nil
#ENDIF
#ENDIF