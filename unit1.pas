unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, Menus, StdCtrls, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
 const
  e = 0.001; // точность
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function for_grap(x: real): real;
begin
  Result := x - arctan(exp(ln(x) * (1 / 3)));
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  if savedialog1.Execute then
    memo1.Lines.SaveToFile(savedialog1.FileName);
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);

var
  x_n, x_k, x_h: real;
  y, x, p: real;
  t, code_xn, code_xk, code_dx: byte;
  s: string;
begin
  begin
    val(Edit1.Text, x_n, code_xn);
    if code_xn <> 0 then
      t := Application.MessageBox('Ошибка ввода начала координат!!! ', '', 0)
    else
    begin
      val(Edit2.Text, x_k, code_xk);
      if code_xk <> 0 then
        t := Application.MessageBox('Ошибка ввода конца координат !!! ', '', 0)
      else
      begin
        val(Edit4.Text, x_h, code_dx);
        if code_dx <> 0 then
          t := Application.MessageBox('Ошибка ввода шага !!!', '', 0)
       else
        begin
          if x_n > x_k then
           ShowMessage('Ошибка Хнач не должно быть болше Хкон. !!!')
          else
          if checkbox3.Checked then
            Form1.Width := 812;
          if checkbox.Checked then 
          begin
            if (for_grap(x_n) * for_grap(x_k))>0 then
              Memo1.Lines.Add('Корней не существует !!!')
            else
            begin
              p := x_n - (x_k - x_n) * for_grap(x_n) / (for_grap(x_k) - for_grap(x_n));
              while abs(for_grap(p)) > e do
              begin
                if (for_grap(x_n) * for_grap(p)) > 0 then
                  x_n := p
                else
                  x_k := p;
                p := x_n - (x_k - x_n) * for_grap(x_n) / (for_grap(x_k) - for_grap(x_n));
              end;
              memo1.Lines.Add('sqr ' + Floattostrf(p, fffixed, 6, 2));
            end;
          end;
          if checkbox1.Checked then
            memo1.Lines.Add('    X      F(X)');
          x := x_n;
          while x <= x_k do
          begin
            y := for_grap(x);
            s := Floattostrf(x, fffixed, 6, 2) + '     ' + Floattostrf(y, fffixed, 10, 4);
            if checkbox1.Checked then
              memo1.Lines.Add(s);
            if checkbox3.Checked then
              Chart1LineSeries1.AddXY(x, y, '', clBlack);
            x := x - x_h;
          end;
        end;
     
    end;
  end;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit4.Text := '';
  Memo1.Clear;
  Checkbox1.Checked := False;
  Checkbox2.Checked := False;
  Chart1lineseries1.Clear;
  Form1.Width := 392;
end;
// 199  checkbox2
//151 end;
//147 x:=x + x_h
end.
