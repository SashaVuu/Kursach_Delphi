unit MainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;                

type
  TFormMainMenu = class(TForm)
    ButtonFindJob: TButton;
    ButtonFindPeople: TButton;
    ButtonCreateBlanket: TButton;
    Image1: TImage;        
    Label1: TLabel;
    Label2: TLabel;
    procedure ButtonFindJobClick(Sender: TObject);
    procedure ButtonFindPeopleClick(Sender: TObject);
    procedure ButtonCreateBlanketClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMainMenu: TFormMainMenu;

implementation
  Uses ToFindJobs,ToFindPeople,ToCreateBlanket;
{$R *.dfm}

//Переход на форму "Поиск работы"
procedure TFormMainMenu.ButtonFindJobClick(Sender: TObject);
begin
FormFindJobs.Show;
FormMainMenu.Hide;
end;

//Переход на форму "Поиск сотрудников"
procedure TFormMainMenu.ButtonFindPeopleClick(Sender: TObject);
begin
FormFindPeople.Show;
FormMainMenu.Hide;
end;

//Переход на форму "Создать анкету"
procedure TFormMainMenu.ButtonCreateBlanketClick(Sender: TObject);
begin
FormCreateBlanket.Show;
FormMainMenu.Hide;
end;

end.
