object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Adicionar'
  ClientHeight = 230
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 186
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 59
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object Label2: TLabel
      Left = 32
      Top = 109
      Width = 23
      Height = 13
      Caption = 'CPF:'
    end
    object edtNome: TEdit
      Left = 80
      Top = 56
      Width = 193
      Height = 21
      TabOrder = 0
    end
    object edtCPF: TEdit
      Left = 80
      Top = 106
      Width = 193
      Height = 21
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 186
    Width = 318
    Height = 44
    Align = alBottom
    TabOrder = 1
    object Adicionar: TButton
      Left = 232
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 0
      OnClick = AdicionarClick
    end
  end
end
