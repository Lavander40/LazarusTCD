unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Menus, LazUTF8;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    Separator3: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator2: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Separator1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);

  private

  public
    function Code(S:WideString; Key:Integer):WideString;
    function Decode(S:WideString; Key:Integer):WideString;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem3Click(Sender: TObject);
var
  fileName, S, SS:WideString;
  Key:Integer;
  F:TIniFile;
begin
  if SaveDialog1.Execute then begin
    fileName:=SaveDialog1.FileName;
    S:= Memo1.Text;
    Key := 99;
    SS := Code(S, Key);
    F:= TIniFile.Create(FileName);
    F.WriteInteger('main', 'Key', Key);
    F.WriteString('main', 'Message', SS);
    F.Free;
  end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
var
  fileName, S, SS:WideString;
  Key:Integer;
  F:TIniFile;
begin
  if OpenDialog1.Execute then begin
    fileName:=OpenDialog1.FileName;
    F:=TIniFile.Create(FileName);
    Key:=F.ReadInteger('main','Key',Key);
    SS:=F.ReadString('main','Message',SS);
    S:=Decode(SS,Key);
    Memo1.Text:=S;
  end;
end;

function TForm1.Code(S:WideString; Key:Integer):WideString;
var SS,S_:WideString; i,K:Integer; C:WideChar;
begin
  SS:='';
  for i:=1 to Length(S) do begin
    C:=S[i];
    K:=Ord(C);
    K:=K xor Key;
    S_:=UnicodeToUTF8(K);
    SS:=SS+S_;
  end;
  Result:=SS;
end;

function TForm1.Decode(S:WideString; Key:Integer):WideString;
var SS,S_:WideString; i,K:Integer; C:WideChar;
begin
  SS:='';
  for i:=1 to Length(S) do begin
    C:=S[i];
    K:=Ord(C);
    K:= K xor Key;
    S_:=UnicodeToUTF8(K);
    SS:=SS+S_;
  end;
  Result:=SS;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Close;
end;

end.

