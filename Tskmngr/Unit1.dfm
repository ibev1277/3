object TaskManager: TTaskManager
  Left = 0
  Top = 0
  Caption = 'TaskManager'
  ClientHeight = 590
  ClientWidth = 1095
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ListViewTasks: TListView
    Left = 224
    Top = 12
    Width = 465
    Height = 480
    Checkboxes = True
    Color = clCream
    Columns = <
      item
        Caption = #1047#1072#1076#1072#1095#1072
        Width = 200
      end
      item
        Caption = #1057#1090#1072#1090#1091#1089
        Width = 100
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object EditTask: TEdit
    Left = 240
    Top = 442
    Width = 265
    Height = 23
    TabOrder = 1
    Text = 'EditTask'
  end
  object ButtonAdd: TButton
    Left = 519
    Top = 441
    Width = 75
    Height = 25
    Caption = 'Add Task'
    TabOrder = 2
    OnClick = ButtonAddClick
  end
  object ButtonRemove: TButton
    Left = 600
    Top = 441
    Width = 75
    Height = 25
    Caption = 'Remove Task'
    TabOrder = 3
    OnClick = ButtonRemoveClick
  end
  object DateTimePicker: TDateTimePicker
    Left = 503
    Top = 12
    Width = 186
    Height = 23
    Date = 45511.000000000000000000
    Time = 0.548609687502903400
    TabOrder = 4
    OnClick = DateTimePickerChange
  end
  object RichEdit1: TRichEdit
    Left = 695
    Top = 8
    Width = 202
    Height = 480
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      '1. '#1047#1072#1087#1086#1083#1085#1080#1090#1077' '#1087#1086#1083#1077' '
      '"EditTask" '#1080' '#1085#1072#1078#1084#1080#1090#1077' '
      '"Add Task", '#1095#1090#1086#1073#1099' '
      #1076#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1076#1072#1095#1091'.'
      '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      '2. '#1044#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1080' '
      #1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '
      #1079#1072#1076#1072#1095' '#1085#1072' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '
      #1076#1072#1090#1091
      #1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1087#1086#1074#1090#1086#1088#1085#1086' '
      #1085#1072#1078#1072#1090#1100' '#1079#1085#1072#1095#1086#1082' '
      #1082#1072#1083#1077#1085#1076#1072#1088#1103' '#1087#1086#1089#1083#1077' '
      #1074#1099#1073#1086#1088#1072' '#1076#1072#1090#1099'.'
      '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      '3. '#1044#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1079#1072#1076#1072#1095#1080' '
      #1085#1072#1076#1086' '#1087#1086#1089#1090#1072#1074#1080#1090#1100' '#1075#1072#1083#1086#1095#1082#1091' '
      #1085#1072#1087#1088#1086#1090#1080#1074' '#1085#1091#1078#1085#1086#1081' '
      #1079#1072#1076#1072#1095#1080' '#1080' '#1085#1072#1078#1072#1090#1100' '
      '"Remove Task".')
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=TaskManager;Data Source=elvegpc\SQLEXPR' +
      'ESS'
    Provider = 'SQLOLEDB.1'
    Left = 1040
    Top = 16
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 1040
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 1032
    Top = 168
  end
end
