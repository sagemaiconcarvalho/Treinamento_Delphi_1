unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    imgFundo: TImage;
    img8: TImage;
    img9: TImage;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img7: TImage;
    img5: TImage;
    img6: TImage;
    procedure img1Click(Sender: TObject);
  private
    jogadasPrimeiroJogador, jogadasSegundoJogador: Array[0..8] of String;
    numeroJogadas: Integer;
    procedure jogar(img: TImage);
    procedure reiniciaJogo;
    function jogadorGanhou(jogadas, possibilidade: Array of String): boolean; overload;
    function jogadorGanhou(jogadas: Array of String): boolean; overload;
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

const
  POSIBILIDADE_1: array[0..2] of string = ('1','2','3');
  POSIBILIDADE_2: array[0..2] of string  = ('4','5','6');
  POSIBILIDADE_3: array[0..2] of string  = ('7','8','9');
  POSIBILIDADE_4: array[0..2] of string  = ('1','4','7');
  POSIBILIDADE_5: array[0..2] of string  = ('2','5','8');
  POSIBILIDADE_6: array[0..2] of string  = ('3','6','9');
  POSIBILIDADE_7: array[0..2] of string  = ('1','5','9');
  POSIBILIDADE_8: array[0..2] of string  = ('3','5','7');

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.img1Click(Sender: TObject);
begin
  jogar(TImage(Sender));
end;

procedure TfrmPrincipal.jogar(img: TImage);
begin
  if img.Picture.Graphic = nil then
  begin
    if numeroJogadas mod 2 = 0 then
    begin
      img.Picture.LoadFromFile('img\Cebolinha.png');
      jogadasPrimeiroJogador[numeroJogadas] := Copy(img.Name, 4, 1);
    end
    else
    begin
      img.Picture.LoadFromFile('img\Monica.png');
      jogadasSegundoJogador[numeroJogadas] := Copy(img.Name, 4, 1);
    end;

    numeroJogadas := numeroJogadas + 1;
  end;

  if jogadorGanhou(jogadasPrimeiroJogador) then
  begin
    Application.MessageBox('Cebolinha Ganhou!', 'Jogo da Velha');
    reiniciaJogo;
  end
  else if jogadorGanhou(jogadasSegundoJogador) then
  begin
    Application.MessageBox('Mônica Ganhou!', 'Jogo da Velha');
    reiniciaJogo;
  end;
end;

procedure TfrmPrincipal.reiniciaJogo;
var
  i: Integer;
begin
  img1.Picture.Graphic := nil;
  img2.Picture.Graphic := nil;
  img3.Picture.Graphic := nil;
  img4.Picture.Graphic := nil;
  img5.Picture.Graphic := nil;
  img6.Picture.Graphic := nil;
  img7.Picture.Graphic := nil;
  img8.Picture.Graphic := nil;
  img9.Picture.Graphic := nil;

  for i := 0 to Length(jogadasPrimeiroJogador) -1 do
    jogadasPrimeiroJogador[i] := '';

  for i := 0 to Length(jogadasSegundoJogador) -1 do
    jogadasSegundoJogador[i] := '';
end;

function TfrmPrincipal.jogadorGanhou(jogadas, possibilidade: array of String): boolean;
var
  i, j, acertos: Integer;
begin
  acertos := 0;
  for i := 0 to Length(possibilidade) -1 do
  begin
    for j := 0 to Length(jogadas) -1 do
    begin
      if possibilidade[i] = jogadas[j] then
        inc(acertos);
    end;
  end;

  Result := acertos = 3;
end;

function TfrmPrincipal.jogadorGanhou(jogadas: array of String): boolean;
begin
  Result := jogadorGanhou(jogadas, POSIBILIDADE_1);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_2);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_3);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_4);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_5);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_6);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_7);
  if not Result then
    Result := jogadorGanhou(jogadas, POSIBILIDADE_8);
end;

end.

