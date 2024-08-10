program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {TaskManager};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTaskManager, TaskManager);
  Application.Run;
end.
