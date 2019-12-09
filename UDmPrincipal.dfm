object DmPrincipal: TDmPrincipal
  OldCreateOrder = False
  Left = 192
  Top = 117
  Height = 179
  Width = 280
  object cdsPontoMensal: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Dia'
        Attributes = [faUnNamed]
        DataType = ftDate
      end
      item
        Name = 'Entrada'
        Attributes = [faUnNamed]
        DataType = ftTime
      end
      item
        Name = 'InicioAlmoco'
        Attributes = [faUnNamed]
        DataType = ftTime
      end
      item
        Name = 'FimAlmoco'
        Attributes = [faUnNamed]
        DataType = ftTime
      end
      item
        Name = 'Saida'
        Attributes = [faUnNamed]
        DataType = ftTime
      end>
    IndexDefs = <>
    IndexFieldNames = 'Dia'
    Params = <>
    StoreDefs = True
    Left = 64
    Top = 24
    Data = {
      6B0000009619E0BD0100000018000000050000000000030000006B0003446961
      040006001000000007456E747261646104000700100000000C496E6963696F41
      6C6D6F636F04000700100000000946696D416C6D6F636F040007001000000005
      536169646104000700100000000000}
    object cdsPontoMensalDia: TDateField
      FieldName = 'Dia'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsPontoMensalEntrada: TTimeField
      FieldName = 'Entrada'
    end
    object cdsPontoMensalInicioAlmoco: TTimeField
      FieldName = 'InicioAlmoco'
    end
    object cdsPontoMensalFimAlmoco: TTimeField
      FieldName = 'FimAlmoco'
    end
    object cdsPontoMensalSaida: TTimeField
      FieldName = 'Saida'
    end
  end
end
