unit UnitPostMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    lblPostString: TLabel;
    mmoTx: TMemo;
    lbledtIP: TLabeledEdit;
    lbledtPort: TLabeledEdit;
    btnPostMessage: TBitBtn;
    mmoRx: TMemo;
    lbledtWebAPIUrl: TLabeledEdit;
    idtcpclnt1: TIdTCPClient;
    lblBody: TLabel;
    edtBody: TEdit;
    btnPostString: TBitBtn;
    Label1: TLabel;
    cbbContentType: TComboBox;
    procedure btnPostMessageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPostStringClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnPostMessageClick(Sender: TObject);
begin

  idtcpclnt1.Host := lbledtIP.Text;
  idtcpclnt1.Port := strtoint(lbledtPort.Text);
  idtcpclnt1.Connect();
  try

  // Accept = "text/html, application/xhtml+xml, */*

    idtcpclnt1.SendCmd(mmoTx.Text);
    mmoRx.Lines.Clear;
    mmoRx.Lines.Add(idtcpclnt1.CurrentReadBuffer);
  except
    on e:Exception do
    ShowMessage(e.Message);
  end;
  idtcpclnt1.Disconnect;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  lbledtIP.Text := '127.0.0.1';
//  lbledtPort.Text := '5000';
//  lbledtWebAPIUrl.Text := '/api/values';
//  edtBody.Text := '{"value":"100"}';
  Self.cbbContentType.Text := 'application/x-www-form-urlencoded';
end;

procedure TForm1.btnPostStringClick(Sender: TObject);
begin
    mmoTx.Text := 'POST ' + Trim(lbledtWebAPIUrl.Text) + ' HTTP/1.1' + #13#10 + 'Host: ' + idtcpclnt1.Host + #13#10 +  'Content-Type: ' + cbbContentType.Text + #13#10 + 'Content-Length: ' + IntToStr(StrLen(PAnsiChar(edtBody.Text))) + #13#10 + #13#10 + edtBody.Text;
end;

end.
