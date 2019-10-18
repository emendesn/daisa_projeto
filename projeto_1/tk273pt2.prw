User Function TK273PT2()

Local aArea := GetArea()

Reclock("SA1",.F.)
SA1->A1_MSBLQL := '1'
MsUnlock()

SA1->A1_MSBLQL := '1'

RestArea(aArea)

Return 