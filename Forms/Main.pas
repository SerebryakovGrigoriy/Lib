{ ����� "��������" }
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Spring.Container,
  CustomInterfaces;


type
  TMainForm = class(TForm, IMainFormInterface)
    BtnTree: TButton;
    procedure BtnTreeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTreeForm: ITreeFormInterface;
  public
    { Public declarations }
    function GetForm: TForm;
  protected
   FRefCount: Integer;
   function _AddRef: Integer; stdcall;  // ���������� ��������� ������ (���������� �������� �������� FRefCount)
   function _Release: Integer; stdcall; // ���������� ��������� ������ (���������� �������� �������� FRefCount)
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// ���������� ��������� ������ (���������� �������� �������� FRefCount)
function TMainForm._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

// ���������� ��������� ������ (���������� �������� �������� FRefCount)
function TMainForm._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result=0 then
    Self.Free;
end;


// ���������� ����������� ������ "������"
procedure TMainForm.BtnTreeClick(Sender: TObject);
begin
 if (Assigned(FTreeForm)) then
 begin
    FTreeForm.GetForm.ShowModal;
 end;
end;

// ������ ������� � ���������� ���������� ���������� ITreeFormInterface
procedure TMainForm.FormActivate(Sender: TObject);
begin
 try
    // ���� � ���������� ���������� ���������� ���������� ITreeFormInterface, �� �������� ��������� ������� � ���������� FSecondaryForm
    FTreeForm:= Globalcontainer.Resolve<ITreeFormInterface>;
    // ��������� ����������� ������ "������"
    BtnTree.Visible:=true;
  except
    // ������ ����������� ������ "������" � ������ ����  ���������� ���������� ITreeFormInterface �� ������� � ����������
    BtnTree.Visible:=false;
  end;
end;

// ��� �������� ����� ����������� �������
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.FreeOnRelease;
end;

// ���������� ������ �����
function TMainForm.GetForm: TForm;
begin
  Result:= Self;
end;

end.
