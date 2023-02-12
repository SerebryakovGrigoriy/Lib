{ ����� "������" }
unit Tree;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Spring.Container, CustomInterfaces;

type
  TFormTree = class(TForm, ITreeFormInterface)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
   FRefCount: Integer;
   function _AddRef: Integer; stdcall;  // ���������� ��������� ������ (���������� �������� �������� FRefCount)
   function _Release: Integer; stdcall; // ���������� ��������� ������ (���������� �������� �������� FRefCount)
  public
    { Public declarations }
  function GetForm: TForm;
  end;

var
  FormTree: TFormTree;

implementation

{$R *.dfm}

// ���������� ��������� ������ (���������� �������� �������� FRefCount)
function TFormTree._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

// ���������� ��������� ������ (���������� �������� �������� FRefCount)
function TFormTree._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result=0 then
    Self.Free;
end;

// ��� �������� ����� ����������� �������
procedure TFormTree.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Self.FreeOnRelease;
end;

// ���������� ������ �����
function TFormTree.GetForm: TForm;
begin
  Result:= Self;
end;

end.
