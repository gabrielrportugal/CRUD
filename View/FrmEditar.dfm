object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Editar'
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 189
    Width = 318
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Editar: TButton
      Left = 232
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 0
      OnClick = EditarClick
    end
    object Deletar: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Deletar'
      TabOrder = 1
      OnClick = DeletarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 189
    Align = alClient
    TabOrder = 1
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
    object edtCPF: TEdit
      Left = 80
      Top = 106
      Width = 193
      Height = 21
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 80
      Top = 56
      Width = 193
      Height = 21
      TabOrder = 1
    end
  end
end
