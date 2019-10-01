unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  FrmEditar, FrmAdicionar, ClienteController, ClienteModel,
  System.Generics.Collections;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ListView1: TListView;
    Panel2: TPanel;
    Atualizar: TButton;
    Adicionar: TButton;
    Editar: TButton;
    edtBusca: TEdit;
    Label1: TLabel;
    procedure AdicionarClick(Sender: TObject);
    procedure EditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FListaClienteView: TObjectList<TCliente>;
    FClienteControl: TClienteControl;
    procedure ConfigListView;
    procedure BuscarCliente;
    procedure ListarListView(const ListaClientes: TObjectList<TCliente>);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdicionarClick(Sender: TObject);
var
  LFormAdicionar: TForm2;
begin
  LFormAdicionar := TForm2.Create(nil);
  try
    LFormAdicionar.ClienteControl := FClienteControl;
    LFormAdicionar.ShowModal;
  finally
    if LFormAdicionar.ModalResult = mrOK then
      BuscarCliente;
    if Assigned(LFormAdicionar) then
      LFormAdicionar.Free;
  end;
end;

procedure TForm1.EditarClick(Sender: TObject);
var
  LFormEditar: TForm3;
begin
  if ListView1.ItemIndex = -1 then
    raise Exception.Create('N�o existem clientes selecionados.');
  LFormEditar := TForm3.Create(nil);
  try
    LFormEditar.ClienteControl := FClienteControl;
    LFormEditar.Cliente := FListaClienteView[ListView1.ItemIndex];
    LFormEditar.ShowModal;
  finally
    if LFormEditar.ModalResult = mrOK then
      BuscarCliente;
    if Assigned(LFormEditar) then
      LFormEditar.Free;
  end;
end;

procedure TForm1.edtBuscaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FListaClienteView := FClienteControl.ClienteDAO.BuscarLista(edtBusca.Text);
  ListarListView(FListaClienteView);
end;

procedure TForm1.AtualizarClick(Sender: TObject);
begin
  BuscarCliente;
end;

procedure TForm1.ConfigListView;
var
  LListaColuna: TListColumn;
begin
  with ListView1 do
  begin
    RowSelect := True;
    ViewStyle := vsReport;
    Align := alClient;
    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'ID';
    LListaColuna.Width := 80;
    LListaColuna.Alignment := taLeftJustify;

    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'Nome';
    LListaColuna.Width := 190;
    LListaColuna.Alignment := taLeftJustify;

    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'CPF';
    LListaColuna.Width := 170;
    LListaColuna.Alignment := taLeftJustify;

    LListaColuna := Columns.Add;
    LListaColuna.Caption := 'DATA';
    LListaColuna.Width := 170;
    LListaColuna.Alignment := taLeftJustify;
  end;
end;

procedure TForm1.BuscarCliente;
begin
  FListaClienteView := FClienteControl.ClienteDAO.RetornarListaCompleta;
  if FListaClienteView.Count > 0 then
    ListarListView(FListaClienteView);

end;

procedure TForm1.ListarListView(const ListaClientes: TObjectList<TCliente>);
var
  I: Integer;
  ListaItem: TListItem;
begin
  ListView1.Clear;
  for I := 0 to FListaClienteView.Count - 1 do
  begin
    ListaItem := ListView1.Items.Add;
    ListaItem.Caption := IntToStr(FListaClienteView[I].ID);
    ListaItem.SubItems.Add(FListaClienteView[I].Nome);
    ListaItem.SubItems.Add(FListaClienteView[I].CPF);
    ListaItem.SubItems.Add(DateToStr(FListaClienteView[I].Data));
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FClienteControl := TClienteControl.Create;
  ConfigListView;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListaClienteView);
  FClienteControl.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  BuscarCliente;
end;

end.
