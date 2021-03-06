' VBA For Quantitative Finance                                
' Simulating Stock Prices
' Author: Shaofei Li                                           

‘Simulating the lognormal distribution
‘Note that I take delta = 1!
Sub RandomNumberSimulation()
Application.ScreenUpdating = False
Range(“starttime”) = Time
N = Range(“runs”).Value
mean = Range(“mean”)
sigma = Range(“sigma”)
ReDim Frequency(0 To 1000) As Integer
For Index = 1 To N
start:
    Static rand1, rand2, S1, S2, X1, X2
    rand1 = 2 * Rnd - 1
    rand2 = 2 * Rnd - 1
    S1 = rand1 ∧ 2 + rand2 ∧ 2
    If S1 > 1 Then GoTo start
    S2 = Sqr(-2 * Log(S1) / S1)
    X1 = rand1 * S2
    X2 = rand2 * S2
    
    Return1 = Exp(mean + sigma * X1)
    Return2 = Exp(mean + sigma * X2)
    
    Frequency(Int(Return1 / 0.01)) = _
    Frequency(Int(Return1 / 0.01)) + 1
    Frequency(Int(Return2 / 0.01)) = _
    Frequency(Int(Return2 / 0.01)) + 1
Next Index

For Index = 0 To 400
    Range(“simuloutput”).Cells(Index + 1, 1) = _
    Frequency(Index) / N
Next Index

Range(“stoptime”) = Time
Range(“elapsed”) = Range(“stoptime”) -
Range(“starttime”)
Range(“elapsed”).NumberFormat = “hh:mm:ss”

End Sub
