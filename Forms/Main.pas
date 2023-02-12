{ Форма "Основная" }
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
   function _AddRef: Integer; stdcall;  // управление подсчетом ссылок (увеличение значения счетчика FRefCount)
   function _Release: Integer; stdcall; // управление подсчетом ссылок (уменьшение значения счетчика FRefCount)
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// Управление подсчетом ссылок (увеличение значения счетчика FRefCount)
function TMainForm._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

// Управление подсчетом ссылок (уменьшение значения счетчика FRefCount)
function TMainForm._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result=0 then
    Self.Free;
end;


// Реализация обработчика кнопки "Дерево"
procedure TMainForm.BtnTreeClick(Sender: TObject);
begin
 if (Assigned(FTreeForm)) then
 begin
    FTreeForm.GetForm.ShowModal;
 end;
end;

// Анализ наличия в контейнере реализации интерфейса ITreeFormInterface
procedure TMainForm.FormActivate(Sender: TObject);
begin
 try
    // если в контейнере обнаружена реализация интерфейса ITreeFormInterface, то записать экземпляр объекта в переменную FSecondaryForm
    FTreeForm:= Globalcontainer.Resolve<ITreeFormInterface>;
    // разрешаем отображение кнопки "Дерево"
    BtnTree.Visible:=true;
  except
    // запрет отображения кнопки "Дерево" в случае если  реализация интерфейса ITreeFormInterface не найдена в контейнере
    BtnTree.Visible:=false;
  end;
end;

// При закрытии формы освобождаем ресурсы
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.FreeOnRelease;
end;

// Возвращаем объект формы
function TMainForm.GetForm: TForm;
begin
  Result:= Self;
end;

end.
