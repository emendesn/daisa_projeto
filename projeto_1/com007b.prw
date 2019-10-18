#include 'PROTHEUS.ch'

/*
*=========================================================================*
| Programa  : COM007B()  | Autor : Antonio c Rosa  | Data :  14/12/2011   |
|=========================================================================|
| Desc.     : FUNCAO PARA CALCULO DE IMPOSTOS VARIAVEIS.                  |
|             Esta funcao tem por objetivo calcular os valores dos impos- |
|             tos variaveis. (como: II, PIS, COFINS.)                     |
|=========================================================================*
| Uso       � MATA103 (Nota fiscal de entrada).                          ���
*=========================================================================*
*/

User Function ImpII()
Local	_xRet 		:= 0,;
		nI 			:= 0,;
		_cCalculo 	:= ParamIXB[1],;
		_nItem 		:= ParamIXB[2],;
		_aInfo 		:= ParamIXB[3],; //Cod Imp. / Campo para gravar
		aImpRef,;
		aImpVal

Local	_nPosQuant := aScan(aHeader,{|x| AllTrim(x[2]) == "D1_QUANT"}),;
		_nPosPUnit := aScan(aHeader,{|x| AllTrim(x[2]) == "D1_VUNIT"}),;
		_nPosTotal := aScan(aHeader,{|x| AllTrim(x[2]) == 'D1_TOTAL'})

local _nBaseIcm:=_nBaseIPI:=0
		Do	Case

			//���������������������������������
			//�Deve retornar a base do imposto�
			//���������������������������������
			Case	( _cCalculo == "B" )
					_xRet += MafisRet(_nItem,"IT_VALMERC") // Pega o valor total do item
					_xRet += MafisRet(_nItem,"IT_FRETE") // Pega o valor do frete do item
					_xRet += MafisRet(_nItem,"IT_SEGURO") // Pega o valor do seguro
					//�����������������������������������������������Ŀ
					//�Verifica se existe algum imposto que incide na �
					//�base de calculo, e inclui o valor deste na base�
					//�������������������������������������������������
					SFC->(DbSetOrder(2))
					If	(SFC->(MsSeek(xFilial("SFC")+MaFisRet(_nItem,"IT_TES")+_aInfo[1]))) .And. !Empty(SFC->FC_INCIMP)
						aImpRef := MaFisRet(_nItem,"IT_DESCIV")
						aImpVal := MaFisRet(_nItem,"IT_VALIMP")
						For nI:=1 to Len(aImpRef)
							If	( !Empty(aImpRef[nI]) )
								If	( AllTrim(aImpRef[nI][1]) $ SFC->FC_INCIMP )
									_xRet += aImpVal[nI]
								EndIf
							EndIf
						Next nI
					EndIf

			//�������������������������������������������������������������������������Ŀ
			//�Deve retornar a aliquota do imposto (esta deve ser pega do campo FB_ALIQ)�
			//���������������������������������������������������������������������������
			Case	( _cCalculo == "A" )

					If	Vazio(SB1->B1_POSIPI) .or. SYD->( !DBSeek( xFilial("SYD") + SB1->B1_POSIPI ))
						Return(0)
					EndIf
					_xRet := SYD->YD_PER_II

			//��������������������������������Ŀ
			//�Deve retornar o valor do imposto�
			//����������������������������������
			Case	( _cCalculo == "V" )
					_xRet := Round( MafisRet(_nItem,"IT_BASEIV"+_aInfo[2]) * (MafisRet(_nItem,"IT_ALIQIV"+_aInfo[2]) / 100) , 2 )

		End	Case

		If	( Alltrim(FUNNAME()) == "MATA103" )
			aCols[_nItem][_nPosTotal] := NoRound(aCols[n][_nPosQuant] * aCols[n][_nPosPUnit],2)
			A103Total(aCols[_nItem][_nPosTotal])
		EndIf
			_nBaseIPI:=(MafisRet(_nItem,"IT_VALMERC")+MafisRet(_nItem,"IT_FRETE")+MafisRet(_nItem,"IT_SEGURO")+_xRet)
			MaFisLoad("IT_BASEIPI",_nBaseIPI,_nItem)
			MaFisLoad("IT_VALIPI",(_nBaseIPI)*(MafisRet(_nItem,"IT_ALIQIPI")/100),_nItem)			
			                 
			_nValPis 	:= Round( MafisRet(_nItem,"IT_BASEIV2") * (MafisRet(_nItem,"IT_ALIQIV2") / 100) , 2 )
			_nValCofins := Round( MafisRet(_nItem,"IT_BASEIV3") * (MafisRet(_nItem,"IT_ALIQIV3") / 100) , 2 )
			
		    _nBaseIcm:=(MafisRet(_nItem,"IT_VALMERC")+IIf(SF4->F4_DESPICM!="2",MafisRet(_nItem,"IT_DESPESA"),0)+MafisRet(_nItem,"IT_FRETE")+MafisRet(_nItem,"IT_SEGURO")+MafisRet(_nItem,"IT_VALIPI")+_nValPis+_nValCofins +_xRet)+((MafisRet(_nItem,"IT_VALMERC")+MafisRet(_nItem,"IT_FRETE")+MafisRet(_nItem,"IT_SEGURO")+MafisRet(_nItem,"IT_VALIPI")+_nValPis+_nValCofins+_xRet)/(1-MafisRet(_nItem,"IT_ALIQICM")/100)*(MafisRet(_nItem,"IT_ALIQICM")/100))
			MaFisLoad("IT_BASEICM",_nBaseIcm,_nItem)
			MaFisLoad("IT_VALICM",(_nBaseIcm)*(MafisRet(_nItem,"IT_ALIQICM")/100),_nItem)
		


Return(_xRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ImpCofins�Autor �Luis Henrique Robusto� Data �  30/03/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � FUNCAO PARA CALCULO DE IMPOSTOS VARIAVEIS.                 ���
���          � Esta funcao tem por objetivo calcular o imposto COFINS.    ���
�������������������������������������������������������������������������͹��
���Uso       � MATA103 (Nota fiscal de entrada).                          ���
�������������������������������������������������������������������������͹��
���DATA      � ANALISTA �  MOTIVO                                         ���
�������������������������������������������������������������������������͹��
���          �          �                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ImpCofins()
Local	_xRet 		:= 0,;
		_nPerII		:= 0,;
		_nIcmsPad	:= IF( SB1->B1_PICM == 0 ,GetMV("MV_ICMPAD"), SB1->B1_PICM ),;
		_nPercPis	:= GetNewPar("MV_TPISIM",1.65),;
		_nPercCof	:= GetNewPar("MV_TCOFIM",7.6),;
		_cCalculo 	:= ParamIXB[1],;
		_nItem 		:= ParamIXB[2],;
		_aInfo 		:= ParamIXB[3]

Local	_nPosQuant := aScan(aHeader,{|x| AllTrim(x[2]) == "D1_QUANT"}),;
		_nPosPUnit := aScan(aHeader,{|x| AllTrim(x[2]) == "D1_VUNIT"}),;
		_nPosTotal := aScan(aHeader,{|x| AllTrim(x[2]) == 'D1_TOTAL'})

		Do	Case

			//���������������������������������
			//�Deve retornar a base do imposto�
			//���������������������������������
			Case	( _cCalculo == "B" )
					_xRet += MafisRet(_nItem,"IT_VALMERC") // Pega o valor total do item
					_xRet += MafisRet(_nItem,"IT_FRETE") // Pega o valor do frete do item
					_xRet += MafisRet(_nItem,"IT_SEGURO") // Pega o valor do seguro

					If	!Vazio(SB1->B1_POSIPI) .and. SYD->( DbSeek( xFilial("SYD") + SB1->B1_POSIPI ))
						_nPerII   := SYD->YD_PER_II
						_nPercPis := SYD->YD_PER_PIS
						_nPercCof := SYD->YD_PER_COF
					EndIf

					_xRet := _xRet * (   ( 1 + (_nIcmsPad/100 * ( _nPerII/100 + (SB1->B1_IPI/100 * (1+_nPerII/100) ))))  / ( (1 - (_nPercCof+_nPercPis) / 100) * (1-_nIcmsPad/100) ) )

			//�������������������������������������������������������������������������Ŀ
			//�Deve retornar a aliquota do imposto (esta deve ser pega do campo FB_ALIQ)�
			//���������������������������������������������������������������������������
			Case	( _cCalculo == "A" )

					If	!Vazio(SB1->B1_POSIPI) .and. SYD->( DbSeek( xFilial("SYD") + SB1->B1_POSIPI ))
						_nPerII := SYD->YD_PER_II
						_nPercPis := SYD->YD_PER_PIS
						_nPercCof := SYD->YD_PER_COF
					EndIf

					_xRet := _nPercCof

			//��������������������������������Ŀ
			//�Deve retornar o valor do imposto�
			//����������������������������������
			Case	( _cCalculo == "V" )
					_xRet := Round( MafisRet(_nItem,"IT_BASEIV"+_aInfo[2]) * (MafisRet(_nItem,"IT_ALIQIV"+_aInfo[2]) / 100) , 2 )

		End	Case

		If	( Alltrim(FUNNAME()) == "MATA103" )
			aCols[_nItem][_nPosTotal] := NoRound(aCols[n][_nPosQuant] * aCols[n][_nPosPUnit],2)
			A103Total(aCols[_nItem][_nPosTotal])
		Endif
		
Return(_xRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ImpPis() �Autor �Luis Henrique Robusto� Data �  30/03/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � FUNCAO PARA CALCULO DE IMPOSTOS VARIAVEIS.                 ���
���          � Esta funcao tem por objetivo calcular o imposto PIS.       ���
�������������������������������������������������������������������������͹��
���Uso       � MATA103 (Nota fiscal de entrada).                          ���
�������������������������������������������������������������������������͹��
���DATA      � ANALISTA �  MOTIVO                                         ���
�������������������������������������������������������������������������͹��
���          �          �                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ImpPis()
Local	_xRet 		:= 0,;
		_nPerII		:= 0,;
		_nIcmsPad	:= IF( SB1->B1_PICM == 0 ,GetMV("MV_ICMPAD"), SB1->B1_PICM ),;
		_nPercPis	:= GetNewPar("MV_TPISIM",1.65),;
		_nPercCof	:= GetNewPar("MV_TCOFIM",7.6),;
		_cCalculo 	:= ParamIXB[1],;
		_nItem 		:= ParamIXB[2],;
		_aInfo 		:= ParamIXB[3]

Local	_nPosQuant := aScan(aHeader,{|x| AllTrim(x[2]) == "D1_QUANT"}),;
		_nPosPUnit := aScan(aHeader,{|x| AllTrim(x[2]) == "D1_VUNIT"}),;
		_nPosTotal := aScan(aHeader,{|x| AllTrim(x[2]) == 'D1_TOTAL'})

		Do	Case

			//���������������������������������
			//�Deve retornar a base do imposto�
			//���������������������������������
			Case	( _cCalculo == "B" )
					_xRet += MafisRet(_nItem,"IT_VALMERC") // Pega o valor total do item
					_xRet += MafisRet(_nItem,"IT_FRETE") // Pega o valor do frete do item
					_xRet += MafisRet(_nItem,"IT_SEGURO") // Pega o valor do seguro

					If	!Vazio(SB1->B1_POSIPI) .and. SYD->( DbSeek( xFilial("SYD") + SB1->B1_POSIPI ))
						_nPerII := SYD->YD_PER_II
						_nPercPis := SYD->YD_PER_PIS
						_nPercCof := SYD->YD_PER_COF
					EndIf

					_xRet := _xRet * (   ( 1 + (_nIcmsPad/100 * ( _nPerII/100 + (SB1->B1_IPI/100 * (1+_nPerII/100) ))))  / ( (1 - (_nPercCof+_nPercPis) / 100) * (1-_nIcmsPad/100) ) )

			//�������������������������������������������������������������������������Ŀ
			//�Deve retornar a aliquota do imposto (esta deve ser pega do campo FB_ALIQ)�
			//���������������������������������������������������������������������������
			Case	( _cCalculo == "A" )

					If	!Vazio(SB1->B1_POSIPI) .and. SYD->( DbSeek( xFilial("SYD") + SB1->B1_POSIPI ))
						_nPerII := SYD->YD_PER_II
						_nPercPis := SYD->YD_PER_PIS
						_nPercCof := SYD->YD_PER_COF
					EndIf

					_xRet := _nPercPis

			//��������������������������������Ŀ
			//�Deve retornar o valor do imposto�
			//����������������������������������
			Case	( _cCalculo == "V" )
					_xRet := Round( MafisRet(_nItem,"IT_BASEIV"+_aInfo[2]) * (MafisRet(_nItem,"IT_ALIQIV"+_aInfo[2]) / 100) , 2 )

		End	Case

		If	( Alltrim(FUNNAME()) == "MATA103" )
			aCols[_nItem][_nPosTotal] := NoRound(aCols[n][_nPosQuant] * aCols[n][_nPosPUnit],2)
			A103Total(aCols[_nItem][_nPosTotal])
		EndIf

Return(_xRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CALPISCOF �Autor �Luis Henrique Robusto� Data �  18/04/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao para verificar o valor de impostos: PIS ou COFINS   ���
���          � OBS: Informar todos os parametros                          ���
�������������������������������������������������������������������������͹��
���Uso       � COM002R (Pedidos de Compras)                               ���
�������������������������������������������������������������������������͹��
���DATA      � ANALISTA � MOTIVO                                          ���
�������������������������������������������������������������������������͹��
���          �          �                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CALPISCOF(_cTipo,_xRet,_nPerIPI,_nPerII) // _cTipo=PIS,COFINS //_xRet(com Frete,Seguro)
Local	_nIcmsPad	:= IF( SB1->B1_PICM == 0 ,GetMV("MV_ICMPAD"), SB1->B1_PICM ),;
		_nPercPis	:= GetNewPar("MV_TPISIM",1.65),;
		_nPercCof	:= GetNewPar("MV_TCOFIM",7.6),;
		_nAliqImp	:= IIF(_cTipo=="PIS",_nPercPis,_nPercCof)

		If	!Vazio(SB1->B1_POSIPI) .and. SYD->( DbSeek( xFilial("SYD") + SB1->B1_POSIPI ))
			_nPercPis := SYD->YD_PER_PIS
			_nPercCof := SYD->YD_PER_COF
		EndIf

		//������������������������������������Ŀ
		//�Verifica o valor de Base de Calculo.�
		//��������������������������������������
		_xRet := _xRet * ( ( 1 + (_nIcmsPad/100 * ( _nPerII/100 + (_nPerIPI/100 * (1+_nPerII/100) ))))  / ( (1 - (_nPercCof+_nPercPis) / 100) * (1-_nIcmsPad/100) ) )

		//���������������������������Ŀ
		//�Calcula o valor do imposto.�
		//�����������������������������
		_xRet := Round( _xRet * _nAliqImp / 100 , 2 )

Return _xRet                                         
