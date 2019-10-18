#Include "Protheus.ch"


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �SelEmpFil � Autor � Mauro Sano            � Data � 06/05/92 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Abre tela com empresas/filiais.                             ���
�������������������������������������������������������������������������Ĵ��
��� Uso      �Plugin                                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SelEmpFil()
LOCAL cCapital
LOCAL nX
LOCAL cCad  := "Selecione Empresa/Fiial"
LOCAL cAlias:= Alias()
LOCAL oOk := LoadBitmap( GetResources(), "LBOK" )
LOCAL oNo := LoadBitmap( GetResources(), "LBNO" )
LOCAL oQual
LOCAL cVar := "  "
LOCAL nOpca
LOCAL oDlg
Local lRunDblClick := .T.
Local aArea := SM0->(GetArea())

dbSelectArea("SM0")
SM0->(DbGoTop())

//����������������������������������������������������������������������Ŀ
//� Monta a tabela de tipos de T�tulos                                   �
//������������������������������������������������������������������������
While !SM0->(Eof())    
	If SM0->M0_CODIGO <> '99' 
		Aadd(aTipos,{Iif(SM0->M0_CODIGO+SM0->M0_CODFIL==cEmpAnt+cFilAnt,.T.,.F.),SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_FILIAL, SM0->M0_NOME})
	EndIf
	SM0->(dbSkip())
End              

aTipoBack := aClone(aTipos)
nOpca := 0

DEFINE MSDIALOG oDlg TITLE cCad From 9,0 To 35,50 OF oMainWnd

@0.5,  0.3 TO 13.6, 20.0 LABEL cCad OF oDlg
@2.3,3 Say OemToAnsi("  ")
@ 1.0,.7 LISTBOX oQual VAR cVar Fields HEADER "", "Nome Filial"  SIZE 150,170 ON DBLCLICK (aTipoBack:=FA060Troca(oQual:nAt,aTipoBack),oQual:Refresh())// NOSCROLL  
oQual:SetArray(aTipoBack)
oQual:bLine := { || {if(aTipoBack[oQual:nAt,1],oOk,oNo),aTipoBack[oQual:nAt,5]}}
oQual:bHeaderClick := {|oObj,nCol| If(lRunDblClick .And. nCol==1, aEval(aTipoBack, {|e| e[1] := !e[1]}),Nil), lRunDblClick := !lRunDblClick, oQual:Refresh()}

DEFINE SBUTTON FROM 10  ,166  TYPE 1 ACTION (nOpca := 1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 22.5,166  TYPE 2 ACTION oDlg:End() ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED

IF nOpca == 1
	aTipos := Aclone(aTipoBack)
EndIF
//��������������������������������������������������������������Ŀ
//� Monta a string de tipos para filtrar o arquivo               �
//����������������������������������������������������������������
cTipos :=""  

For nX := 1 To Len(aTipos)
	If aTipos[nX,1]
		cTipos += SubStr(aTipos[nX,2],1,3)+"/"		
	End
Next nX

DeleteObject(oOk)
DeleteObject(oNo)

RestArea(aArea)

Return (.T.)