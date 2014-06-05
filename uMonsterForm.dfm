object frmMonster: TfrmMonster
  Left = 443
  Top = 176
  Width = 702
  Height = 475
  Caption = 'frmMonster'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgMonster: TImage
    Left = 104
    Top = 24
    Width = 209
    Height = 209
    Stretch = True
    OnClick = imgMonsterClick
  end
  object lbl1: TLabel
    Left = 8
    Top = 272
    Width = 75
    Height = 13
    Caption = #1050#1072#1088#1090#1099' '#1080#1075#1088#1086#1082#1072':'
  end
  object imgPlaCard1: TImage
    Left = 8
    Top = 296
    Width = 105
    Height = 129
    Stretch = True
  end
  object imgPlaCard2: TImage
    Left = 120
    Top = 296
    Width = 105
    Height = 129
    Stretch = True
  end
  object imgPlaCard3: TImage
    Left = 232
    Top = 296
    Width = 105
    Height = 129
    Stretch = True
  end
  object btnNextMob: TButton
    Left = 16
    Top = 120
    Width = 75
    Height = 25
    Caption = #1057#1083#1077#1076'. '#1084#1086#1073
    TabOrder = 0
  end
  object btnPrevMob: TButton
    Left = 328
    Top = 120
    Width = 75
    Height = 25
    Caption = #1055#1088#1077#1076'. '#1084#1086#1073
    TabOrder = 1
  end
  object btnBattle: TButton
    Left = 104
    Top = 240
    Width = 75
    Height = 25
    Caption = #1041#1080#1090#1074#1072
    TabOrder = 2
    OnClick = btnBattleClick
  end
  object btnEvade: TButton
    Left = 232
    Top = 240
    Width = 75
    Height = 25
    Caption = #1059#1093#1086#1076
    TabOrder = 3
    OnClick = btnEvadeClick
  end
  object lst1: TListBox
    Left = 416
    Top = 16
    Width = 257
    Height = 409
    ItemHeight = 13
    TabOrder = 4
  end
end
