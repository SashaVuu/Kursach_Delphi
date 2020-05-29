unit ToFindPeople;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids;

type
  StrMass=array [1..5] of string;
  TFormFindPeople = class(TForm)
    ButtonBack: TButton;
    Label1: TLabel;
    StringGrid2: TStringGrid;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    TEditLoginEnter: TEdit;
    Bevel3: TBevel;
    ButtonShowWithOutFirm: TButton;
    Label5: TLabel;
    Label7: TLabel;
    JEditID: TEdit;
    ButtonWatchMore: TButton;
    Label9: TLabel;
    Label10: TLabel;
    TEditPasswordEnter: TEdit;
    Bevel4: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Memo1: TMemo;
    Label13: TLabel;
    ButtonAutorization: TButton;
    TEditLoginReg: TEdit;
    Label14: TLabel;
    TEditPasswordReg: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    TEditPasswordReg2: TEdit;
    ButtonRegestration: TButton;
    Label17: TLabel;
    ButtonShowWithFirm: TButton;
    J2EditProf: TEdit;
    Label20: TLabel;
    Label4: TLabel;
    ButtonFindInGrid: TButton;
    Button5: TButton;
    Label6: TLabel;
    Label18: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label19: TLabel;
    procedure ButtonBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonShowWithOutFirmClick(Sender: TObject);
    procedure ButtonWatchMoreClick(Sender: TObject);
    procedure ButtonAutorizationClick(Sender: TObject);
    procedure ButtonRegestrationClick(Sender: TObject);
    procedure ButtonFindInGridClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ButtonShowWithFirmClick(Sender: TObject);
    procedure JEditIDChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFindPeople: TFormFindPeople;
  FirmName:string;
  
implementation
Uses MainMenu,ToCreateBlanket;
{$R *.dfm}

           {    *���� ��������������� �������� � �������*    }

//������ �� ��������������� ����� (F) � ������
//� ������������ ���������������� ������ (WorkHead)
//c ����������� � ��������� ���������� ������� (N1)

Procedure FromFileToZap1(Var WorkHead:TworkAdress;Var F:TFile; Var N1:integer);
var p:TWorkAdress;
//N1-���������� �������
begin
  new(WorkHead);
  //���������� ��������� HeadSpis ����� �������
  //����� ������ ������
  p:=WorkHead;
  while not eof(f) do
  begin
    new(p^.next);
    p:=p^.next;
    read(f,p^.data);
    p^.next:=nil;
    n1:=n1+1;
  end;
end;

//����� ������ ������������ �� ����� (CompName) � ���������������� ������
//(WorkHead1),� ����� ���������� � ������� (StringGrid2)
procedure EachCompanyToGrid(CompName:string;WorkHead1:TWorkAdress;Var StringGrid2: TstringGrid);
var temp2:TWorkAdress;
    i:integer;
begin
  StringGrid2.RowCount:=2;
  Stringgrid2.Cells[0,0]:='ID';
  Stringgrid2.Cells[1,0]:='���';
  Stringgrid2.Cells[2,0]:='�������';
  Stringgrid2.Cells[3,0]:='�����������';
  Stringgrid2.Cells[4,0]:='������� �/�';
  Stringgrid2.Cells[5,0]:='�����';
  Stringgrid2.Cells[6,0]:='��.�������.';
  Stringgrid2.Cells[7,0]:='���� ���.(���)';
  Stringgrid2.Cells[8,0]:='��������';
 //����� �� StringGrid
  temp2:=WorkHead1^.next;
  i:=1;
  while temp2<>nil do
  begin
    if temp2^.data.Company=CompName then
    begin
      with  temp2^.data do
      begin
        Stringgrid2.Cells[0,i]:=Inttostr(ID);
        Stringgrid2.Cells[1,i]:=Name;
        Stringgrid2.Cells[2,i]:=SurName;
        Stringgrid2.Cells[3,i]:=Career;
        Stringgrid2.Cells[4,i]:=Inttostr(SalaryFrom)+'-'+Inttostr(SalaryTo);
        Stringgrid2.Cells[5,i]:=Town;
        Stringgrid2.Cells[6,i]:=EdLvl;
        Stringgrid2.Cells[7,i]:=Inttostr(JobYear);
        Stringgrid2.Cells[8,i]:=Company;
      end;
      StringGrid2.RowCount:=StringGrid2.RowCount+1;
      i:=i+1;
    end;
    temp2:=temp2^.next;
  end;
  StringGrid2.RowCount:=StringGrid2.RowCount-1;
end;


//�������� ���� �� �������� ������(str1) � �������(j) ������� (SG)
//� ������������ ��������� ���������(F1)
//������� ��������� ��� ��� ���� �� ���������,� ����� �� �������
//������ ������� � ���������� �� ������ � ��� ����� �������� �� ���������
//� �������� ������ ������� ������ ��������
procedure CheckIfStrInSG(str1:string;j:integer;SG:TstringGrid; Var Fl:Boolean);
var N,i:integer;
begin
  Fl:=False;
  N:=SG.RowCount-1;
  for i:=1 to N do
  begin
    if str1=SG.Cells[j,i] then
      Fl:=True;
  end;
end;


//�������� ����������� ������������
//������� �����(Login) � ������(Password) � ������� � �����
//� ����������,�����. ����� ���������� (FlagLogin),(FlagPassword)
procedure SearchLoginInFile(Login,Password:string;Var FlagLogin,FlagPassword:boolean);
var
  value:string;
  FLog,FPas:string;
  i:integer;
  F:textfile;
begin
  AssignFile(F,'Passwords.txt');
  Reset(F);
  FlagLogin:=False;
  FlagPassword:=False;
  while (FlagLogin=false) and not eof(F) do
  begin
  Flog:='';
  FPas:='';
  Readln(F,value);
  i:=1;
  while value[i]<>'\' do
  begin
    FLog:=Flog+value[i];
    i:=i+1;
  end;
  if FLog=Login then
  begin
    FlagLogin:=True;
    Delete(value,1,length(FLog)+1);
    FPas:=value;
    if FPas=Password then
      FlagPassword:=True;
  end;
  end;
  CloseFile(F);
end;

//������ ������(Login) � ������(Pass1)
//��� ����������� � ����
procedure RegistrInFile (Login,Pass1:string);
var str1:string;
    F:TextFile;
begin
  AssignFile(F,'Passwords.txt');
  Append(F);
  str1:=Login+'\'+Pass1;
  writeln(F);
  write(F,Str1);
  CloseFile(F);
end;

//�������� �� "\" � ������(������ � ������)
procedure CheckSlashInPass(str1:string; Var Fl:boolean);
var i:integer;
begin
  Fl:=True;
  for i:=1 to Length(str1) do
    if str1[i]='\' then
       Fl:=False;
end;


//�������� ������ RowNumber(����� ������) �� �����������(Grid)
//� ����������� ������ ���-�� ����� (Rows)
procedure GridDeleteRow(RowNumber: Integer; Grid: TstringGrid;Var Rows:integer);
 var
   i: Integer;
 begin
   if (RowNumber = Grid.RowCount - 1) then
   begin
     {//
     if Grid.RowCount=2 then
     begin
     end;}
     { On the last row}
     Grid.RowCount := Grid.RowCount - 1
   end
   else
   begin
     { Not the last row}
     for i := RowNumber to Grid.RowCount - 1 do
       Grid.Rows[i] := Grid.Rows[i + 1];
     Grid.RowCount := Grid.RowCount - 1;
   end;
   Rows:=Grid.RowCount;
 end;


//����� ������ str2 � j-��� ������� � ��������� �
//����������� ��������
procedure FindInStgrid(j:integer;str2:string;Stringgrid: TstringGrid);
var i,rows1:integer;
begin
  i:=1;
  Rows1:=Stringgrid.RowCount;
  while i<rows1 do
  begin
    if str2<>Stringgrid.Cells[j,i] then
    begin
      GridDeleteRow(i,Stringgrid,Rows1);
      i:=i-1;
    end;
    i:=i+1;
  end;
end;



//��������� ���������� ������� (StrArray)
//�������������� ����������� � ������������ (strID)
//������ ��� ���������� �������,����� ������� ��
//����������������� ������ (WorkHead)
procedure MoreDataAbout(strID:string;WorkHead:TWorkAdress;Var StrArr:StrMass);
var
  temp:TWorkAdress;
  fl:boolean;
begin
  temp:=WorkHead^.next;
  fl:=true;
  while (temp<>nil) and (Fl) do
  begin
    if inttostr(temp^.data.ID) = strID then
    begin
      StrArr[1]:=temp^.data.ThirdName;
      StrArr[2]:=temp^.data.Pol;
      StrArr[3]:=temp^.data.Telephone;
      StrArr[4]:=inttostr(temp^.data.Age);
      StrArr[5]:=temp^.data.Smena;
      Fl:=false;
    end;
    temp:=temp^.next;
  end;
end;



                   {      *��������� �������*      }

//��������� ������� '�����',����������� � ���������� �����
procedure TFormFindPeople.ButtonBackClick(Sender: TObject);
begin
  FormMainMenu.Show;
  FormFindPeople.Hide;                     
end;

//��������� ������� �������� �����  FormFindPeople
procedure TFormFindPeople.FormCreate(Sender: TObject);
var
 F1:TFile;
 CompanyName:string;
 N1:integer; //n1-amountofzap
begin
 //�������������� ������ �� ����� � ������
  Assignfile(F1,'MyFile2.dat');
  Reset(F1);
  FromFileToZap1(HeadSpis,F1,N1);
  CloseFile(F1);
  //����� �� ������� ,������ ��� ��������,�������
  //��������� ������ �� �� ��������� �����
  CompanyName:='-';
  EachCompanyToGrid(CompanyName,HeadSpis,StringGrid2);
  //���������� ������������ "��������","��������� ������������"
  //"�����������" ������ ������������ �� ���������� �����
  ButtonWatchMore.Enabled:= False;
  ButtonShowWithFirm.Enabled:= False;
  JEditID.Enabled:=False;
  memo1.enabled:= false;
end;

//��������� ������� "���������" ����������
//����������� �����������
procedure TFormFindPeople.ButtonAutorizationClick(Sender: TObject);
var
  AcceptLog,AcceptPas,FlagPass,FlagLogin:Boolean;
  CompanyName:string;
  //AcceptLog-����,�������� ���������������� �� ��������
  //AcceptPas-����,�������� ����������� ������
  //FlagPass-����,�������� ������� '\' � ������
  //FlagLogin-����,�������� ������� '\' � ������

begin

  //�������� �� ������� '\'
  CheckSlashInPass(TEditLoginEnter.Text,FlagPass);
  CheckSlashInPass(TEditPasswordEnter.Text,FlagLogin);

  if  (FlagPass=True) and (FlagLogin=True) then
  begin
    SearchLoginInFile(TEditLoginEnter.Text,TEditPasswordEnter.Text,AcceptLog,AcceptPas);
    if AcceptLog=False then
    begin
      ShowMessage ('������ �������� �� ����������������!');
    end
    else
    begin
      if  AcceptPas=False then
        ShowMessage ('������ ������ �������!')
      else
      begin
        CompanyName:=TEditLoginEnter.Text;
        FirmName:=TEditLoginEnter.Text;
        EachCompanyToGrid(CompanyName,HeadSpis,StringGrid2);
        //�������� ������� �
        //"��������� ������������","�����������" ������,
        //������������ �� ��������
        ButtonWatchMore.Enabled:= True;
        ButtonShowWithFirm.Enabled:= True;
        JEditID.Enabled:=True;
        ShowMessage ('����� �����������!');
        end;
    end;
  end
  else
    ShowMessage ('����� � ������ �� ����� ��������� ������ "\".');

end;


//��������� ������� "����������������" ��������
procedure TFormFindPeople.ButtonRegestrationClick(Sender: TObject);
Var
 FlagPass,FlagLogin:boolean;
begin
  //�������� �� ������� "\" � ������
  CheckSlashInPass(TEditLoginReg.Text,FlagPass);
  CheckSlashInPass(TEditPasswordReg.Text,FlagLogin);

  if (FlagLogin=True) and  (FlagPass=true) then
  begin
    if length(TEditPasswordReg.Text)>=3 then
    begin
      if TEditPasswordReg.Text=TEditPasswordReg2.Text then
      begin
        RegistrInFile(TEditLoginReg.Text,TEditPasswordReg.Text);
        FormCreateBlanket.ComboBoxComp.Items.Add(TEditLoginReg.Text);
        ShowMessage('����������� ������ �������!');
      end
      else
        ShowMessage('������ �� ���������!');
    end
    else
      ShowMessage('������ ������ ��������� ������ 3 ��������!');
  end
  else
      ShowMessage('����� � ������ �� ������� ��������� ������ "\".');
end;

//��������� ������� "�����" ������ �� ���������
procedure TFormFindPeople.ButtonFindInGridClick(Sender: TObject);
var
  flag:boolean;
begin
    if J2EditProf.Text<>'' then
    begin
     //��������� ���� �� ������ ����� ������ � �������
     CheckIfStrInSG(J2EditProf.Text,3,Stringgrid2,Flag);
     if Flag=true then
       FindInStgrid(3,J2EditProf.Text,Stringgrid2)
     else
       ShowMessage('�� ������� ������� ������ �� �������.');
    end
    else
      ShowMessage('�� ������ �� �����.');
end;


//��������� ������� "��������" ������������ ������,
//��������� ������ ���������������� ���������
procedure TFormFindPeople.ButtonWatchMoreClick(Sender: TObject);
Var NewData:StrMass;
    FlagOutput:Boolean;
begin
  memo1.enabled:= true;
  CheckIfStrInSG(JEditID.Text,0,StringGrid2,FlagOutPut);
  if FlagOutput=true then
  begin
    MoreDataAbout(JEditID.Text,HeadSpis,NewData);
    Memo1.Lines.Insert(0,  '��������: '+NewData[1]);
    Memo1.Lines.Insert(1,  '���:'+NewData[2]);
    Memo1.Lines.Insert(2,  '�������:'+NewData[3]);
    Memo1.Lines.Insert(3,  '�������:'+NewData[4]);
    Memo1.Lines.Insert(4,  '�����:'+NewData[5]);
  end
  else
   ShowMessage('������ � ������ ID ���!');
   ButtonWatchMore.Enabled:=False;
   memo1.enabled:= true;
end;

//����� �����
procedure TFormFindPeople.Button5Click(Sender: TObject);
Var
N,i:integer;
temp2,WorkHead1:TworkAdress;
begin
  N:=1;
  StringGrid2.RowCount:=N+1;
  Stringgrid2.Cells[0,0]:='ID';
  Stringgrid2.Cells[1,0]:='���';
  Stringgrid2.Cells[2,0]:='�������';
  Stringgrid2.Cells[3,0]:='�����������';
  Stringgrid2.Cells[4,0]:='������� �/�';
  Stringgrid2.Cells[5,0]:='�����';
  Stringgrid2.Cells[6,0]:='��.�������.';
  Stringgrid2.Cells[7,0]:='���� ���.(���)';
  Stringgrid2.Cells[8,0]:='��������';
  WorkHead1:=HeadSpis;
 //Output on StringGrid
  temp2:=WorkHead1^.next;
  i:=1;
  while temp2<>nil do
  begin
    with  temp2^.data do
    begin
        Stringgrid2.Cells[0,i]:=Inttostr(ID);
        Stringgrid2.Cells[1,i]:=Name;
        Stringgrid2.Cells[2,i]:=SurName;
        Stringgrid2.Cells[3,i]:=Career;
        Stringgrid2.Cells[4,i]:=Inttostr(SalaryFrom)+'-'+Inttostr(SalaryTo);
        Stringgrid2.Cells[5,i]:=Town;
        Stringgrid2.Cells[6,i]:=EdLvl;
        Stringgrid2.Cells[7,i]:=Inttostr(JobYear);
        Stringgrid2.Cells[8,i]:=Company;
    end;
      StringGrid2.RowCount:=StringGrid2.RowCount+1;
      i:=i+1;
      temp2:=temp2^.next;
  end;
  StringGrid2.RowCount:=StringGrid2.RowCount-1;
end;

//��������� ������� "����������"  ������,
//� ������� �� ������� �������� �����
procedure TFormFindPeople.ButtonShowWithOutFirmClick(Sender: TObject);
var
 F1:TFile;
 CompanyName:string;
 N1:integer;
begin
  //��� �� ����������� ����� ,����� ���������� ������
  Assignfile(F1,'MyFile2.dat');
  Reset(F1);
  FromFileToZap1(HeadSpis,F1,N1);
  CloseFile(F1);
  //�������������� ������ �� ����� � ������
  CompanyName:='-';
  EachCompanyToGrid(CompanyName,HeadSpis,StringGrid2);
end;

//��������� ������� "����������" ������,
//������������ �� ���������� ��������������
//�����
procedure TFormFindPeople.ButtonShowWithFirmClick(Sender: TObject);
var
    CompanyName1:string;
begin
     CompanyName1:=FirmName;
     EachCompanyToGrid(CompanyName1,HeadSpis,StringGrid2);
end;

//��������� ����������� EditID
procedure TFormFindPeople.JEditIDChange(Sender: TObject);
begin
  ButtonWatchMore.Enabled:=True;
  Memo1.Clear;
end;

end.

