Attribute VB_Name = "Marc"
Sub Main()
'este m�dulo l� o arquivo inicia.txt, obtendo o caminho
'para encontrar o arquivo winword.exe

'caso nao encontre, pede ao usu�rio indicar o end. correto

    Dim retDir As String, path As String
    'Dim conf As New clsConfig
    '------------------------
    'conf.LoadPublicValues
    
     Open App.path & "\start.mds" For Input As #1
    Input #1, path
    Close #1

    'verifica a exist�ncia do winword.exe
    retDir = Dir(path)
    If retDir = "WINWORD.EXE" Then
        'executa o WORD97 com a macro q prepara ambiente de marca��o
        Shell path & " /l " & App.path & "\markup.prg", vbMaximizedFocus
    Else
        DepePath.Text1.Text = path
        DepePath.Show
    End If
    Set conf = Nothing
End Sub
