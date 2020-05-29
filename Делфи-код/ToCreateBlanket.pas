unit ToCreateBlanket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TWorks=Record
     Id:integer;
     Name:string[15];
     Surname:string[15];
     ThirdName:string[15];
     Age:integer;
     Telephone:string[15];
     Mail:string[25];
     Career:string[25];
     SalaryFrom:integer;
     SalaryTo:integer;
     Town:string[15];
     EdLvl:string[15];
     JobYear:integer;
     Smena:string[15];
     Pol:string[15];
     Company:string[20];
  end;
  TWorkAdress=^TWorkList;
  TWorkList= record
    data:TWorks;
    next:TWorkAdress;
  end;
  TFile=File of Tworks;
  TFormCreateBlanket = class(TForm)
    Label1: TLabel;
    ButtonBack: TButton;
    EditSurName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditName: TEdit;
    EditOtch: TEdit;
    EditAge: TEdit;
    EditTelephone: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    EditMail: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ComboBoxEdLvl: TComboBox;
    ComboBoxSmena: TComboBox;
    ComboBoxPol: TComboBox;
    EditSalaryFrom: TEdit;
    EditTown: TEdit;
    EditCareer: TEdit;
    EditYears: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    EditSalaryTo: TEdit;
    CButtonSend: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label20: TLabel;
    ComboBoxComp: TComboBox;
    procedure ButtonBackClick(Sender: TObject);
    procedure CButtonSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCreateBlanket: TFormCreateBlanket;
  HeadSpis:TWorkAdress;
  SetOfChis: set of char=['1','2','3','4','5','6','7','8','9','0'];
implementation

uses MainMenu,ToFindPeople;


{$R *.dfm}
              {    *Блок вспомогательных процедур и функций*    }

//Добавление записи в файл
Procedure AddZapToFile(WorkHead:TworkAdress;Var F:TFile);
var temp2:TWorkAdress;
begin
  temp2:=WorkHead^.next;
  while temp2<>nil do
  begin
    write(F,temp2^.data);
    temp2:=temp2^.next;
  end;
   Seek(f,FileSize(f));
end;

//Проверка строки str1 на содержание цифр
procedure TryOnInteger(str1:string;var Flag:boolean);
var i:integer;
begin
  Flag:=true;
    for i:=1 to length(str1) do
      if not (str1[i] in SetOfChis) then
        Flag:=False;
end;

//Чтение из файла в список
Procedure FromFileToZap(Var WorkHead:TworkAdress;Var F:TFile; Var N1:integer);
var p:TWorkAdress;
//N1-количество записей
begin
  new(WorkHead);
  p:=WorkHead;
  while not eof(f) do
  begin
    new(p^.next);
    p:=p^.next;
    read(f,p^.data);
    p^.next:=nil;
    n1:=n1+1;
  end;;
end;


                {      *Обработка событий*      }

//Обработка события 'Назад',возвращение к предыдущей форме
procedure TFormCreateBlanket.ButtonBackClick(Sender: TObject);
begin
FormMainMenu.Show;
FormCreateBlanket.Hide;
   EditName.Text:='';
   EditSurName.Text:='';
   EditOtch.Text:='';
   EditAge.Text:='';
   EditTelephone.Text:='';
   EditMail.Text:='';
   EditCareer.Text:='';
   EditSalaryFrom.Text:='';
   EditSalaryTo.Text:='';
   EditTown.Text:='';
   ComboBoxEdLvl.Text:='';
   EditYears.Text:='';
   ComboBoxSmena.Text:='';
   ComboBoxPol.Text:='';
   ComboBoxComp.Text:='';
   CButtonSend.Enabled:=True;
end;




//Обработка события 'Отправить' анкету
procedure TFormCreateBlanket.CButtonSendClick(Sender: TObject);
var
  WorkHead,temp2:TWorkAdress;
  F:TFile;
  N:integer;
  Fl:boolean;
begin
 if  (ComboBoxComp.Text<>'') and (ComboBoxEdLvl.Text<>'') and (ComboBoxPol.Text<>'')
 and (ComboBoxSmena.Text<>'') and (EditAge.Text<>'') and (EditCareer.Text<>'')
 and (EditMail.Text<>'') and (EditName.Text<>'') and (EditOtch.Text<>'')
 and (EditSalaryFrom.Text<>'') and (EditSalaryTo.Text<>'')
 and (EditSurName.Text<>'') and (EditTelephone.Text<>'')
 and (EditYears.Text<>'') and (EditTown.Text<>'') then
 begin
  TryOnInteger(EditSalaryFrom.Text,Fl);
  if Fl=true then
    TryOnInteger(EditSalaryto.Text,Fl);
  if Fl=true then
    TryOnInteger(EditYears.Text,Fl);
  if Fl=true then
    TryOnInteger(EditAge.Text,Fl);
  if Fl=true then
  begin
    //Заносим инфу из файла в список
    AssignFile(F,'MyFile2.dat');
    Reset(F);

    //Перебрасывание данных из файла в список
    FromFileToZap(WorkHead,F,N);

    //Добавление человека в запись
    if WorkHead=nil then
      new(WorkHead);
    temp2:=WorkHead;
    temp2^.next:=nil;
    While temp2^.next<>nil do
      temp2:=temp2^.next;
    new(temp2^.next);
    temp2:=temp2^.next;
    temp2^.next:=nil;

    With temp2^.data do
    begin
      Id:=N+1;
      Name:=EditName.Text;
      Surname:=EditSurName.Text;
      ThirdName:=EditOtch.Text;
      Age:=strtoint(EditAge.Text);
      Telephone:=EditTelephone.Text;
      Mail:=EditMail.Text;
      Career:=EditCareer.Text;
      SalaryFrom:=strtoint(EditSalaryFrom.Text);
      SalaryTo:=strtoint(EditSalaryTo.Text);
      Town:=EditTown.Text;
      EdLvl:=ComboBoxEdLvl.Text;
      JobYear:=strtoint(EditYears.Text);
      Smena:=ComboBoxSmena.Text;
      Pol:=ComboBoxPol.Text;
      Company:=ComboBoxComp.Text;
    end;
    //Добавление записи в файл
    AddZapToFile(WorkHead,F);
    CloseFile(f);
    CButtonSend.Enabled:= False;

    ShowMessage('Ваша анкета отправлена.Спасибо.');
    FormMainMenu.Show;
    FormCreateBlanket.Hide;
    EditName.Text:='';
    EditSurName.Text:='';
    EditOtch.Text:='';
    EditAge.Text:='';
    EditTelephone.Text:='';
    EditMail.Text:='';
    EditCareer.Text:='';
    EditSalaryFrom.Text:='';
    EditSalaryTo.Text:='';
    EditTown.Text:='';
    ComboBoxEdLvl.Text:='';
    EditYears.Text:='';
    ComboBoxSmena.Text:='';
    ComboBoxPol.Text:='';
    ComboBoxComp.Text:='';
  end
  else
    ShowMessage('Поля "Уровень З/П" ,"Опыт работы","Возраст" должны содержать числа!')
  end
  else
    ShowMessage('Все поля должны быть заполнены!');

end;


//Обработка события "Создание формы"
procedure TFormCreateBlanket.FormCreate(Sender: TObject);
var
  F:TextFile;
  value,stroka:string;
  i:integer;
begin
  Stroka:='-';
  ComboBoxComp.Items.Add(stroka);
  Stroka:='';
  AssignFile(F,'Passwords.txt');
  Reset(F);
  While (not eof(F)) do
  begin
    Readln(F,value);
    i:=1;
    while value[i]<>'\' do
    begin
      stroka:=stroka+value[i];
      i:=i+1;
    end;
    ComboBoxComp.Items.Add(stroka);
    stroka:='';
  end;
  CloseFile(F);
end;

end.



