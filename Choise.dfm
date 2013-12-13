object ChoiseForm: TChoiseForm
  Left = 1182
  Top = 775
  Width = 679
  Height = 208
  Caption = 'Choise'
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
    Width = 201
    Height = 17
    Caption = '1'
    TabOrder = 0
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 216
    Top = 56
    Width = 209
    Height = 17
    Caption = '2'
    TabOrder = 1
    OnClick = RadioButton2Click
  end
  object RadioButton3: TRadioButton
    Left = 432
    Top = 56
    Width = 217
    Height = 17
    Caption = '3'
    TabOrder = 2
    OnClick = RadioButton3Click
  end
  object Button1: TButton
    Left = 288
    Top = 112
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
end
