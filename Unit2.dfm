object Form2: TForm2
  Left = 692
  Top = 410
  BorderStyle = bsDialog
  Caption = 'Choose location'
  ClientHeight = 180
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 144
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = btn1Click
  end
  object Edit1: TEdit
    Left = 128
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object cbb1: TComboBox
    Left = 128
    Top = 32
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'cbb1'
  end
end
