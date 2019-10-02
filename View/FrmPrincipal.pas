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
    procedure ListView1DblClick(Sender: TObject);
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

// Clique do bot�o Adicionar (Exibe o Form de Adicionar um novo cliente)
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

// Clique do bot�o Editar (Exibe o Form Editar, passando a inst�ncia do controlador)
procedure TForm1.EditarClick(Sender: TObject);
var
  LFormEditar: TForm3;
begin
  if ListView1.ItemIndex = -1 then
    raise Exception.Create('Selecione um cliente');
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

// Evento de digitar no campo Busca (Pesquisa de acordo com o que for digitado)
procedure TForm1.edtBuscaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FListaClienteView := FClienteControl.ClienteDAO.BuscarLista(edtBusca.Text);
  ListarListView(FListaClienteView);
end;

// Clique no bot�o Atualizar (Atualiza o ListView com uma nova busca ao banco)
procedure TForm1.AtualizarClick(Sender: TObject);
begin
  BuscarCliente;
  edtBusca.Text := '';
end;

//Configura��es do ListView do Form Principal
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

// M�todo que realiza uma busca no banco, carrega os dados na lista de clientes
procedure TForm1.BuscarCliente;
begin
  FListaClienteView := FClienteControl.ClienteDAO.RetornarListaCompleta;
  if FListaClienteView.Count > 0 then
    ListarListView(FListaClienteView);

end;

// M�todo que insere no List View os dados da lista de clientes
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

// Evento de duplo clique que chama o evento EditarClick que exibe o form de edi��o
procedure TForm1.ListView1DblClick(Sender: TObject);
begin
  EditarClick(ListView1);
end;

//Ao criar � criada uma inst�ncia do controlador e configurada o list view
procedure TForm1.FormCreate(Sender: TObject);
begin
  FClienteControl := TClienteControl.Create;
  ConfigListView;
end;

//Ao destruir a lista e a inst�ncia do controlador s�o destruidas
procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListaClienteView);
  FClienteControl.Free;
end;

// Ao exibir o Form Principal os dados s�o buscados e carregados no ListView
procedure TForm1.FormShow(Sender: TObject);
begin
  BuscarCliente;
end;

end.
