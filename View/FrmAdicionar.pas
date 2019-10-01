unit FrmAdicionar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  ClienteController, ClienteModel;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtNome: TEdit;
    edtCPF: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Adicionar: TButton;
    procedure AdicionarClick(Sender: TObject);
  private
    FClienteControl: TClienteControl;
    FCliente: TCliente;
    { Private declarations }
  public
    { Public declarations }
    property ClienteControl: TClienteControl read FClienteControl
      write FClienteControl;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  UITypes, CPFException;

procedure TForm2.AdicionarClick(Sender: TObject);
begin
  FCliente := TCliente.Create;
  try
    FCliente.Nome := edtNome.Text;
    FCliente.CPF := edtCPF.Text;
    try
      FClienteControl.ValidarCPF(FCliente.CPF);
      FClienteControl.ClienteDAO.CPFDuplicado(FCliente);
      FClienteControl.ClienteDAO.Inserir(FCliente);
      if (MessageDlg('Cliente cadastrado', mtConfirmation, [mbOK], 0) = mrOK)
      then
        ModalResult := mrOK;
    except
      on E: ECpfDuplicado do
        raise;
      on E: ECpfInvalido do
        raise;
      on E: Exception do
        raise Exception.Create('Ocorreu um erro ' + E.Message);
    end;
  finally
    FCliente.Free;
  end;
end;

end.
