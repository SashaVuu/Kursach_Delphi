unit ToFindJobs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids;

type
  TJobs=Record
     ID:integer;                    
     CompanyName:string[15];
     Vacancy:string[15];
     ZpMin:integer;
     ZpMax:integer;
     Town:string[15];
     EdLvl:string[25];
     JobYear:integer;
     Smena:string[25];
     Pol:string[25];
     AgeMin:integer;
     AgeMax:integer;
     PhoneNum:string[20];
  end;
  TJobsAdress=^TJobsList;
  TJobsList= record
    data:TJobs;
    next:TJobsAdress;
  end;
  TFormFindJobs = class(TForm)
    JButtonGoBack: TButton;
    StringGrid1: TStringGrid;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    JEditProfObl: TEdit;
    Label3: TLabel;
    JEditZPfrom: TEdit;
    Label4: TLabel;
    JEditTown: TEdit;
    Label5: TLabel;
    Bevel3: TBevel;
    Label6: TLabel;
    Bevel4: TBevel;
    Label7: TLabel;
    JEditOpit: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Bevel5: TBevel;
    Label11: TLabel;
    Bevel6: TBevel;
    Label13: TLabel;
    JButtonOpitUp: TButton;
    JButtonOpitDown: TButton;
    Label12: TLabel;
    Label14: TLabel;
    JEditFindID: TEdit;
    JButtonToBlanket: TButton;
    JButtonFindWork: TButton;
    JEditZPto: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    JButtonReturnGrid: TButton;
    JComboBoxObr: TComboBox;
    JComboBoxSmena: TComboBox;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Label10: TLabel;
    JButtonKnowNum: TButton;
    MemoKnowNum: TMemo;
    procedure JButtonGoBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JButtonFindWorkClick(Sender: TObject);
    procedure JButtonReturnGridClick(Sender: TObject);
    procedure JButtonToBlanketClick(Sender: TObject);
    procedure JButtonOpitUpClick(Sender: TObject);
    procedure JButtonOpitDownClick(Sender: TObject);
    procedure JButtonKnowNumClick(Sender: TObject);
    procedure JEditFindIDChange(Sender: TObject);

  private
    { Private declarations }
  public                                                    
    { Public declarations }
  end;

var
  FormFindJobs: TFormFindJobs;
  MainHead:TJobsAdress;
  NumOfStrok:integer;

implementation
  Uses MainMenu,ToCreateBlanket;
{$R *.dfm}

             {    *���� ��������������� �������� � �������*    }

//������������ �� ������ �� ���������� ����� (F) �������,� ������������
//�� ������� ����������������� ������(JobsHead).� ������� ���-�� �������
procedure FromTxtToSpis(Var JobsHead:TJobsAdress;Var F:TextFile; Var N1:integer);
var
  HM:integer;
  value,k:String;
  OneZap:TJobs;
  p:TJobsAdress;
//N1-���������� �������
begin
  new(JobsHead);
  p:=JobsHead;
  ReadLn(F,value);
  while not eof(f) do
  begin
    new(p^.next);
    p:=p^.next;
    ReadLn(F,value);
    while value<>'.' do
    begin
       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.ID:=StrToInt(k);

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.CompanyName:=k;

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.Vacancy:=k;

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.ZpMin:=StrToInt(k);

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.ZpMax:=StrToInt(k);

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.Town:=k;

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.EdLvl:=k;

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.JobYear:=StrToInt(k);

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.Smena:=k;

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.Pol:=k;

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.AgeMin:=StrToInt(k);

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.AgeMax:=StrToInt(k);

       HM:=Pos(',',value);
       k:=Copy(value,1,HM-1);
       Delete(value,1,HM);
       OneZap.PhoneNum:=k;
     end;
    p^.data:=OneZap;
    p^.next:=nil;
    n1:=n1+1;
  end;
end;

//�������� ������ (RowNumber) �� ������� (Grid)
procedure GridDeleteRow(RowNumber: Integer; Grid: TstringGrid;Var Rows:integer;Var Fl:Boolean);
 var
   i: Integer;
 begin
   if Grid.RowCount=2 then
   begin
     Fl:=False;
   end
   else
   begin

   if (RowNumber = Grid.RowCount - 1) then
     { On the last row}
     Grid.RowCount := Grid.RowCount - 1
   else
   begin
     { Not the last row}
     for i := RowNumber to Grid.RowCount - 1 do
       Grid.Rows[i] := Grid.Rows[i + 1];
     Grid.RowCount := Grid.RowCount - 1;
   end;
   Rows:=Grid.RowCount;
   end;

 end;


//����� ������ str2 � ������� j ��������� � �����. ����������� � ����������
procedure FindInStgrid(j:integer;str2:string;Stringgrid: TstringGrid);
var i,k,rows1:integer;
    fl:boolean;
begin
  i:=1;
  Fl:=true;
  Rows1:=Stringgrid.RowCount;
  while i<rows1 do
  begin
    if str2<>Stringgrid.Cells[j,i] then
    begin
      GridDeleteRow(i,Stringgrid,Rows1,Fl);
      if Fl =False then
      begin
        Stringgrid.Cells[0,1]:=':-(';
        for k:=1 to 8 do
          Stringgrid.Cells[k,1]:='';
        i:=rows1;
      end;
      i:=i-1;
    end;
    i:=i+1;
  end;
end;

//����� �� ����� �� ... ��� �  ����������� � ����������
procedure FindInStgridOpit(str2:string;Stringgrid: TstringGrid);
var i,k,rows1,j:integer;
    fl:boolean;
begin
  j:=6;
  i:=1;
  Fl:=true;
  Rows1:=Stringgrid.RowCount;
  while i<rows1 do
  begin
    if strtoint(str2)>strtoint(Stringgrid.Cells[j,i]) then
    begin
      GridDeleteRow(i,Stringgrid,Rows1,Fl);
      if Fl =False then
      begin
        Stringgrid.Cells[0,1]:=':-(';
        for k:=1 to 8 do
          Stringgrid.Cells[k,1]:='';
        i:=rows1;
      end;
      i:=i-1;
    end;
    i:=i+1;
  end;
end;

//����� �� �������� (��)
procedure FindZPFrom(ZPEditfrom:string;Stringgrid: TstringGrid);
var
   i,rows,j,k:integer;
   StrFrom,StrDop:string;
   Fl:boolean;
begin
  Fl:=True;
  rows:=Stringgrid.RowCount;
  i:=1;
  while i<rows do
  begin
     StrDop:=Stringgrid.Cells[3,i];
     j:=1;
     StrFrom:='';
     while StrDop[j]<>'-' do
     begin
       StrFrom:=StrFrom+StrDop[j];
       j:=j+1;
    end;
    if strtoint(ZPEditFrom)>strtoint(StrFrom) then
    begin
      GridDeleteRow(i,Stringgrid,Rows,Fl);
      if Fl =False then
      begin
        Stringgrid.Cells[0,1]:=':-(';
        for k:=1 to 8 do
          Stringgrid.Cells[k,1]:='';
        i:=rows;
      end;
      i:=i-1;
    end;
    i:=i+1;
  end;
end;

//����� �� �������� (��)
procedure FindZPTo(ZPEditto:string;Stringgrid: TstringGrid);
var
   i,rows,j,k:integer;
   StrFrom,StrDop,StrTo:string;
   Fl:Boolean;
begin
  rows:=Stringgrid.RowCount;
  i:=1;
  Fl:=True;
  while i<rows do
  begin
     StrDop:=Stringgrid.Cells[3,i];
     j:=1;
     StrFrom:='';
     while StrDop[j]<>'-' do
     begin
       StrFrom:=StrFrom+StrDop[j];
       j:=j+1;
    end;
    Delete(StrDop,1,length(StrFrom)+1);
    StrTo:=StrDop;
    if strtoint(ZPEditTo)<strtoint(StrTo) then
    begin
      GridDeleteRow(i,Stringgrid,Rows,Fl);
      if Fl =False then
      begin
        Stringgrid.Cells[0,1]:=':-(';
        for k:=1 to 8 do
          Stringgrid.Cells[k,1]:='';
        i:=rows;
      end;
      i:=i-1;
    end;
    i:=i+1;
  end;
end;

//���������� ������� �� ������
procedure FillFromSpisToGrid(Mainhead1:TJobsAdress;Stringgrid2: TstringGrid);
var
   temp:TJobsAdress;                   
   i:integer;
begin
  StringGrid2.RowCount:=NumOfStrok;
  Stringgrid2.Cells[0,0]:='ID';
  Stringgrid2.Cells[1,0]:='��������';
  Stringgrid2.Cells[2,0]:='�����������';
  Stringgrid2.Cells[3,0]:='������� �/�';
  Stringgrid2.Cells[4,0]:='�����';
  Stringgrid2.Cells[5,0]:='�����������';
  Stringgrid2.Cells[6,0]:='����(��...���)';
  Stringgrid2.Cells[7,0]:='�����';
  Stringgrid2.Cells[8,0]:='�������';

  temp:=MainHead1^.next;
  i:=1;
  While temp<>nil do
  begin
      with  temp^.data do
      begin
        Stringgrid2.Cells[0,i]:=Inttostr(ID);
        Stringgrid2.Cells[1,i]:=CompanyName;
        Stringgrid2.Cells[2,i]:=Vacancy;
        Stringgrid2.Cells[3,i]:=Inttostr(ZpMin)+'-'+Inttostr(ZpMax);
        Stringgrid2.Cells[4,i]:=Town;
        Stringgrid2.Cells[5,i]:=EdLvl;
        Stringgrid2.Cells[6,i]:=Inttostr(JobYear);
        Stringgrid2.Cells[7,i]:=Smena;
        Stringgrid2.Cells[8,i]:=Inttostr(AgeMin)+'-'+Inttostr(AgeMax);
      end;
      temp:=temp^.next;
      i:=i+1;
  end;
end;

//���������� ��������� � ������� (SG)
Procedure BubbleSortSG(TypeOfSort:string;SG:TstringGrid);
var
 i,n,j,z:integer;
 k:string;
begin
  N:=SG.RowCount-1;
  for i:=1 to n-1 do
  begin
    for j:=1 to n-i do
    begin
     if TypeOfSort='�����������' then
     begin
      if strtoint(SG.Cells[6,j])>strtoint(SG.Cells[6,j+1]) then
      begin
        for z:=0 to 8 do
        begin
          k:=SG.Cells[z,j];
          SG.Cells[z,j]:=SG.Cells[z,j+1];
          SG.Cells[z,j+1]:=k;
        end;
      end;
     end
     else if TypeOfSort='��������' then
     begin
      if strtoint(SG.Cells[6,j])<strtoint(SG.Cells[6,j+1]) then
      begin
        for z:=0 to 8 do
        begin
          k:=SG.Cells[z,j];
          SG.Cells[z,j]:=SG.Cells[z,j+1];
          SG.Cells[z,j+1]:=k;
        end;
      end;
     end;
    end;
  end;
end;

//����� � ������� (SG) ID � ����������� ����� (Fl)
//����������� �� ������� ������ ID � �������
procedure FindID(strID:string;Sg:TstringGrid;Var i:integer;Var Fl:boolean);
var
  N:integer;
begin
  N:=SG.RowCount;
  i:=0;
  Fl:=True;
  while (i<=N) and (Fl=True) do
  begin
    i:=i+1;
    if SG.Cells[0,i]=strID then
      Fl:=False;
  end;
end;


//�������� �������� �� ������ (str1) �������
//�� �������� � ���-�� '0'..'9'
Procedure CheckIfNum(str1:string;Var Fl:Boolean);
Type
  M=set of Char;
var
  MnoVo:M;
  i:integer;
begin
  i:=1;
  MnoVo:=['0'..'9'];
  while (i<=length(str1)) and (Fl=True) do
  begin
    if not (str1[i] in MnoVo) then
      Fl:=False;
    i:=i+1;
  end;
end;


                   {      *��������� �������*      }


//����������� � ������� ����
procedure TFormFindJobs.JButtonGoBackClick(Sender: TObject);
begin
  FormMainMenu.Show;
  FormFindJobs.Hide;
end;

//���������� ������� ��� �������� ����� �
//������������ ���������������� ������
procedure TFormFindJobs.FormCreate(Sender: TObject);
const
  m=9;
var
  temp:TJobsAdress;
  N,i:integer;
  F:TextFile;
begin
  AssignFile(F,'AboutJobs2.txt');
  Reset(F);
  //�������������� ������ �� ����� � ������
  FromTxtToSpis(MainHead,F,N);
  CloseFile(F);

  StringGrid1.ColCount:=M;
  Stringgrid1.Cells[0,0]:='ID';
  Stringgrid1.Cells[1,0]:='��������';
  Stringgrid1.Cells[2,0]:='�����������';
  Stringgrid1.Cells[3,0]:='������� �/�';
  Stringgrid1.Cells[4,0]:='�����';
  Stringgrid1.Cells[5,0]:='�����������';
  Stringgrid1.Cells[6,0]:='����(��...���)';
  Stringgrid1.Cells[7,0]:='�����';
  Stringgrid1.Cells[8,0]:='�������';

  StringGrid1.RowCount:=N+1;

 //Output on StringGrid
  temp:=MainHead^.next;
  i:=1;
  while temp<>nil do
  begin
    with  temp^.data do
    begin
      Stringgrid1.Cells[0,i]:=Inttostr(ID);
      Stringgrid1.Cells[1,i]:=CompanyName;
      Stringgrid1.Cells[2,i]:=Vacancy;
      Stringgrid1.Cells[3,i]:=Inttostr(ZpMin)+'-'+Inttostr(ZpMax);
      Stringgrid1.Cells[4,i]:=Town;
      Stringgrid1.Cells[5,i]:=EdLvl;
      Stringgrid1.Cells[6,i]:=Inttostr(JobYear);
      Stringgrid1.Cells[7,i]:=Smena;
      Stringgrid1.Cells[8,i]:=Inttostr(AgeMin)+'-'+Inttostr(AgeMax);
    end;
    temp:=temp^.next;
    i:=i+1;
  end;
  NumOfStrok:=i;
  MemoKnowNum.Clear;
  MemoKnowNum.enabled:= false;
end;

//��������� ������� "�����" � ������� �� ���������
procedure TFormFindJobs.JButtonFindWorkClick(Sender: TObject);
Var
  NumFl:Boolean;
begin
  FillFromSpisToGrid(MainHead,Stringgrid1);
  if (JEditProfObl.Text<>'') and (JEditTown.Text<>'') and
  (JEditZPfrom.Text<>'') and (JEditZPto.Text<>'')then
  begin
     NumFl:=True;
     CheckIfNum(JEditZPfrom.Text,NumFl);
     CheckIfNum(JEditZPto.Text,NumFl);
     CheckIfNum(JEditOpit.Text,NumFl);
     If NumFl=True then
     begin
       FindInStgrid(2,JEditProfObl.Text,Stringgrid1);
       if Stringgrid1.Cells[0,1]<>':-(' then
       begin
         FindZPFrom(JEditZPfrom.Text,Stringgrid1);
         FindZPTo(JEditZPto.Text,Stringgrid1);
         FindInStgrid(4,JEditTown.Text,Stringgrid1);
         if JComboBoxObr.Text<>'' then
           FindInStgrid(5,JComboBoxObr.Text,Stringgrid1);
         if JEditOpit.Text<>'' then
           FindInStgridOpit(JEditOpit.Text,Stringgrid1);
         if JComboBoxSmena.Text<>'' then
           FindInStgrid(7,JComboBoxSmena.Text,Stringgrid1);
       end;
       if Stringgrid1.Cells[0,1]=':-(' then
         ShowMessage('� ��������� �� ������� ������� ���������� �����������.');
     end
     else
       ShowMessage('���� "������� �/�","����" ������ ��������� �����.');
  end
  else
    ShowMessage('���� "�����������","������� �/�","�����" ����������� ��� ����������.');
end;


//��������� ������� "������� �������"
procedure TFormFindJobs.JButtonReturnGridClick(Sender: TObject);
begin
   FillFromSpisToGrid(MainHead,Stringgrid1);
end;


//��������� ������� "�������" ������
//������� �� ����� "�������� ������" � ��������� ������������ �����
procedure TFormFindJobs.JButtonToBlanketClick(Sender: TObject);
var
  Flag:Boolean;
  i:integer;
begin
  if JEditFindID.Text<>'' then
  begin
  FindID(JEditFindID.Text,Stringgrid1,i,Flag);
  if Flag=False then
  begin
    FormCreateBlanket.ComboBoxComp.Text:=Stringgrid1.Cells[1,i];
    FormCreateBlanket.EditCareer.Text:=JEditProfObl.Text;
    FormCreateBlanket.EditSalaryFrom.Text:=JEditZPfrom.Text;
    FormCreateBlanket.EditSalaryTo.Text:=JEditZPto.Text;
    FormCreateBlanket.EditTown.Text:=JEditTown.Text;
    FormCreateBlanket.ComboBoxEdLvl.Text:=JComboBoxObr.Text;
    FormCreateBlanket.ComboBoxSmena.Text:=JComboBoxSmena.Text;
    FormCreateBlanket.EditYears.Text:=JEditOpit.Text;
    FormCreateBlanket.Show;
    FormFindJobs.Hide;
  end
  else
    ShowMessage('������ ID � ������� ���.���������� ��������� ������.');
  end
  else
    ShowMessage('�� ������ �� �����.');
end;

//��������� ������� ���������� �� ����� ������ �� "�����������"
procedure TFormFindJobs.JButtonOpitUpClick(Sender: TObject);
begin
  BubbleSortSG('�����������',StringGrid1);
end;
//��������� ������� ���������� �� ����� ������ �� "�������"
procedure TFormFindJobs.JButtonOpitDownClick(Sender: TObject);
begin
  BubbleSortSG('��������',StringGrid1);
end;

//��������� ������� "������" ��������� ����� ��������
procedure TFormFindJobs.JButtonKnowNumClick(Sender: TObject);
var
  temp2,WorkHead:TJobsAdress;
  FlagFind,Flag:Boolean;
  phone:string;
  i:integer;
begin
  MemoKnowNum.enabled:= true;
  if  JEditFindID.Text<>'' then
  begin
  FindID(JEditFindID.Text,Stringgrid1,i,Flag);
  if Flag=False then
  begin
   WorkHead:=MainHead;
   temp2:=WorkHead^.next;
   i:=1;
   FlagFind:=true;
  while (temp2<>nil) and (FlagFind=True) do
  begin
    if temp2^.data.ID=strtoint(JEditFindID.text) then
    begin
      phone:=temp2^.data.PhoneNum;
      MemoKnowNum.Lines.Insert(0,phone);
      FlagFind:=False;
    end;
    temp2:=temp2^.next;
  end;
  end
  else
    ShowMessage('������ ID � ������� ���.���������� ��������� ������.');
  end
  else
    ShowMessage('�� �� ����� ID.');
  MemoKnowNum.enabled:= false;
end;

//��� ���������  JEditFindID ���� MemoKnowNum ���������
procedure TFormFindJobs.JEditFindIDChange(Sender: TObject);
begin
  MemoKnowNum.Clear;
end;

end.

