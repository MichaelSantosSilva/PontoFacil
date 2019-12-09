object FrmConsultaHorasExtras: TFrmConsultaHorasExtras
  Left = 192
  Top = 117
  Width = 441
  Height = 467
  Caption = 'Consulta de Horas Extras'
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
  object Label4: TLabel
    Left = 96
    Top = 407
    Width = 40
    Height = 13
    Caption = 'Totais:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbFiltros: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 81
    Caption = '  Filtros    '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblNome: TLabel
      Left = 57
      Top = 24
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'lblNome'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object lblFuncao: TLabel
      Left = 57
      Top = 48
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'lblNome'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object Label1: TLabel
      Left = 7
      Top = 48
      Width = 47
      Height = 13
      Caption = 'Fun'#231#227'o:'
    end
    object Label2: TLabel
      Left = 7
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 247
      Top = 24
      Width = 67
      Height = 13
      Caption = 'Refer'#234'ncia:'
    end
    object btnPesquisar: TSpeedButton
      Left = 328
      Top = 39
      Width = 73
      Height = 22
      Cursor = crHandPoint
      Caption = '&Listar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
      OnClick = btnPesquisarClick
    end
    object mskReferencia: TMaskEdit
      Left = 248
      Top = 40
      Width = 72
      Height = 22
      EditMask = '!99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
    end
  end
  object dbgHorasExtras: TDBGrid
    Left = 8
    Top = 96
    Width = 409
    Height = 297
    DataSource = dsHorasExtras
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
  end
  object mskTotalExtra: TMaskEdit
    Left = 146
    Top = 398
    Width = 111
    Height = 22
    EditMask = '!990:00;1; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = '   :  '
  end
  object mskTotalAtraso: TMaskEdit
    Left = 271
    Top = 398
    Width = 111
    Height = 22
    EditMask = '!990:00;1; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Text = '   :  '
  end
  object dsHorasExtras: TDataSource
    DataSet = cdsHorasExtras
    Left = 280
    Top = 320
  end
  object cdsHorasExtras: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Data'
        DataType = ftDate
      end
      item
        Name = 'HorasExtras'
        DataType = ftFloat
      end
      item
        Name = 'Atrasos'
        DataType = ftFloat
      end
      item
        Name = 'HorasExtraExibi'#231#227'o'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AtrasosExibicao'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'Data'
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsHorasExtrasCalcFields
    Left = 320
    Top = 320
    Data = {
      610000009619E0BD010000001800000003000000000003000000610004446174
      6104000600000000000B486F7261734578747261730800040000000000074174
      7261736F73080004000000000001000D44454641554C545F4F52444552020082
      0000000000}
    object cdsHorasExtrasData: TDateField
      DisplayWidth = 20
      FieldName = 'Data'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsHorasExtrasHorasExtras: TFloatField
      FieldName = 'HorasExtras'
      Visible = False
    end
    object cdsHorasExtrasAtrasos: TFloatField
      FieldName = 'Atrasos'
      Visible = False
    end
    object cdsHorasExtrasHorasExtraExibicao: TStringField
      DisplayLabel = 'Horas Extras'
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'HorasExtraExibi'#231#227'o'
    end
    object cdsHorasExtrasAtrasosExibicao: TStringField
      DisplayLabel = 'Atrasos'
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'AtrasosExibicao'
    end
    object cdsHorasExtrasHorasExtrasAgg: TAggregateField
      FieldName = 'HorasExtrasAgg'
      Expression = 'sum(HorasExtras)'
    end
    object cdsHorasExtrasAtrasosAgg: TAggregateField
      FieldName = 'AtrasosAgg'
      Expression = 'sum(Atrasos)'
    end
  end
end
