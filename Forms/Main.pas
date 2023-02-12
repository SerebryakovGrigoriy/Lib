{ ����� "��������" }
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Spring.Container,
  CustomInterfaces;


type
  TMainForm = class(TForm)
    BtnTree: TButton;
    procedure BtnTreeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FSecondaryForm: ITreeFormInterface;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// ���������� ����������� ������ "������"
procedure TMainForm.BtnTreeClick(Sender: TObject);
begin
 if (Assigned(FSecondaryForm)) then
 begin
    FSecondaryForm.GetTreeForm.ShowModal;
 end;
end;

// ������ ������� � ���������� ���������� ���������� ITreeFormInterface
procedure TMainForm.FormActivate(Sender: TObject);
begin
 try
    // ���� � ���������� ���������� ���������� ���������� ITreeFormInterface, �� �������� ��������� ������� � ���������� FSecondaryForm
    FSecondaryForm:= Globalcontainer.Resolve<ITreeFormInterface>;
    // ��������� ����������� ������ "������"
    BtnTree.Visible:=true;
  except
    // ������ ����������� ������ "������" � ������ ����  ���������� ���������� ITreeFormInterface �� ������� � ����������
    BtnTree.Visible:=false;
  end;
end;

end.
