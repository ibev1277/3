unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Data.Win.ADODB,
  System.Generics.Collections, System.DateUtils;

type
  TTaskManager = class(TForm)
    EditTask: TEdit;
    ButtonAdd: TButton;
    ListViewTasks: TListView;
    ButtonRemove: TButton;
    DateTimePicker: TDateTimePicker;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonRemoveClick(Sender: TObject);
    procedure DateTimePickerChange(Sender: TObject);
    procedure ListViewTasksClick(Sender: TObject);
  private
    procedure UpdateTaskStatus(Item: TListItem; Completed: Boolean);
    procedure LoadTasks;
  public
    { Public declarations }
  end;

var
  TaskManager: TTaskManager;

implementation

{$R *.dfm}

procedure TTaskManager.FormCreate(Sender: TObject);
var
  Col: TListColumn;
begin
  // Настройка ListView
  ListViewTasks.ViewStyle := vsReport;
  ListViewTasks.Checkboxes := True;

  Col := ListViewTasks.Columns.Add;
  Col.Caption := 'Задача';
  Col.Width := 200;

  Col := ListViewTasks.Columns.Add;
  Col.Caption := 'Статус';
  Col.Width := 100;

  // Обновление списка задач для текущей даты
  DateTimePickerChange(nil);
end;

procedure TTaskManager.ButtonAddClick(Sender: TObject);
var
  FormattedDate: string;
begin
  if EditTask.Text <> '' then
  begin
    FormattedDate := FormatDateTime('yyyy-mm-dd', DateTimePicker.Date);

    ADOQuery1.SQL.Text :=
      'INSERT INTO Tasks (TaskDate, TaskDescription, Status) ' +
      'VALUES (:TaskDate, :TaskDescription, :Status)';
    ADOQuery1.Parameters.ParamByName('TaskDate').Value := FormattedDate;
    ADOQuery1.Parameters.ParamByName('TaskDescription').Value := EditTask.Text;
    ADOQuery1.Parameters.ParamByName('Status').Value := 'Активно';
    ADOQuery1.ExecSQL;

    EditTask.Clear;
    EditTask.SetFocus;

    // Обновление списка задач для выбранной даты
    LoadTasks;
  end;
end;

procedure TTaskManager.ButtonRemoveClick(Sender: TObject);
var
  i: Integer;
  FormattedDate: string;
begin
  FormattedDate := FormatDateTime('yyyy-mm-dd', DateTimePicker.Date);

  for i := ListViewTasks.Items.Count - 1 downto 0 do
  begin
    if ListViewTasks.Items[i].Checked then
    begin
      ADOQuery1.SQL.Text :=
        'DELETE FROM Tasks WHERE TaskDescription = :TaskDescription AND TaskDate = :TaskDate';
      ADOQuery1.Parameters.ParamByName('TaskDescription').Value := ListViewTasks.Items[i].Caption;
      ADOQuery1.Parameters.ParamByName('TaskDate').Value := FormattedDate;
      ADOQuery1.ExecSQL;

      ListViewTasks.Items.Delete(i);
    end;
  end;
end;

procedure TTaskManager.DateTimePickerChange(Sender: TObject);
begin
  LoadTasks;
end;

procedure TTaskManager.ListViewTasksClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListViewTasks.Items.Count - 1 do
  begin
    UpdateTaskStatus(ListViewTasks.Items[i], ListViewTasks.Items[i].Checked);
  end;
end;

procedure TTaskManager.UpdateTaskStatus(Item: TListItem; Completed: Boolean);
var
  Status: string;
  FormattedDate: string;
begin
  FormattedDate := FormatDateTime('yyyy-mm-dd', DateTimePicker.Date);

  if Completed then
    Status := 'Completed'
  else
    Status := 'Pending';

  ADOQuery1.SQL.Text :=
    'UPDATE Tasks SET Status = :Status WHERE TaskDescription = :TaskDescription AND TaskDate = :TaskDate';
  ADOQuery1.Parameters.ParamByName('Status').Value := Status;
  ADOQuery1.Parameters.ParamByName('TaskDescription').Value := Item.Caption;
  ADOQuery1.Parameters.ParamByName('TaskDate').Value := FormattedDate;
  ADOQuery1.ExecSQL;

  Item.SubItems[0] := Status;
end;

procedure TTaskManager.LoadTasks;
var
  TaskDate: TDate;
  FormattedDate: string;
  ListItem: TListItem;
begin
  ListViewTasks.Items.Clear;
  TaskDate := DateTimePicker.Date;
  FormattedDate := FormatDateTime('yyyy-mm-dd', TaskDate);

  ADOQuery1.SQL.Text :=
    'SELECT TaskDescription, Status ' +
    'FROM Tasks WHERE TaskDate = :TaskDate';
  ADOQuery1.Parameters.ParamByName('TaskDate').Value := FormattedDate;
  ADOQuery1.Open;

  while not ADOQuery1.Eof do
  begin
    ListItem := ListViewTasks.Items.Add;
    ListItem.Caption := ADOQuery1.FieldByName('TaskDescription').AsString;
    ListItem.SubItems.Add(ADOQuery1.FieldByName('Status').AsString);
    ADOQuery1.Next;
  end;
  ADOQuery1.Close;
end;

end.
