object ChoiseForm: TChoiseForm
  Left = 479
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Choise'
  ClientHeight = 306
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 24
    Width = 35
    Height = 13
    Caption = 'Choise:'
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 56
    Width = 649
    Height = 41
    Caption = '1'
    TabOrder = 0
    WordWrap = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 104
    Width = 649
    Height = 41
    Caption = '2'
    TabOrder = 1
    OnClick = RadioButton2Click
  end
  object RadioButton3: TRadioButton
    Left = 8
    Top = 152
    Width = 649
    Height = 41
    Caption = '3'
    TabOrder = 2
    OnClick = RadioButton3Click
  end
  object Button1: TButton
    Left = 296
    Top = 264
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object RadioButton4: TRadioButton
    Left = 8
    Top = 200
    Width = 649
    Height = 41
    Caption = '4'
    TabOrder = 4
    Visible = False
    OnClick = RadioButton4Click
  end
end
