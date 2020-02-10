/* 

/* Future<List<Post>> fetchPosts() async {
  http.Response response = await http.get(
      "https://bdagencetest.000webhostapp.com/get.php");
  var responseJson = json.decode(response.body);
  return (responseJson['metcheckData']['forecastLocation']['forecast'] as List)
      .map((p) => Post.fromJson(p))
      .toList();
} */



class UserInfo {
  Source source;
  String coUsuario,
      noUsuario,
      dsSenha,
      coUsuarioAutorizacao,
      nuCpf,
      nuRg,
      noOrgaoEmisor,
      ufOrgaoEmissor,
      dsEndereco,
      noEmail,
      noEmailPessoal,
      nuTelefone,
      urlFoto,
      instantMessenger,
      msn,
      yms,
      dsCompEnd,
      dsBairro,
      nuCep,
      noCidade,
      ufCidade;
   int nuMatricula, icq;
   DateTime dtNascimento,
      dtAdmissaoEmpresa,
      dtDesligamento,
      dtInclusao,
      dtExpiracao,
      dtAlteracao,
      dtExpedicao;

  UserInfo({
    this.source,
    this.msn, 
    this.yms, 
    this.icq,
    this.coUsuario,
    this.noUsuario,
    this.dsSenha,
    this.coUsuarioAutorizacao,
    this.nuCpf,
    this.nuRg,
    this.noOrgaoEmisor,
    this.ufOrgaoEmissor,
    this.dsEndereco,
    this.noEmail,
    this.noEmailPessoal,
    this.nuTelefone,
    this.urlFoto,
    this.instantMessenger,
    this.dsCompEnd,
    this.dsBairro,
    this.nuCep,
    this.noCidade,
    this.ufCidade,
    this.nuMatricula,
    this.dtNascimento,
    this.dtAdmissaoEmpresa,
    this.dtDesligamento,
    this.dtInclusao,
    this.dtExpiracao,
    this.dtAlteracao,
    this.dtExpedicao,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        source: Source.fromJson(json["source"]),
        coUsuario: json["co_usuario"],
        noUsuario: json["no_usuario"],
        dsSenha: json["ds_senha"],
        coUsuarioAutorizacao: json["co_usuario_autorizacao"],
        nuMatricula: json["nu_matricula"],
        dtNascimento: json["dt_nacimento"],
        dtAdmissaoEmpresa: json["dt_admissao_empresa"],
        dtDesligamento: json["dt_desligamento"],
        dtInclusao: json["dt_inclusao"],
        dtExpiracao: json["dt_expiracao"],
        nuCpf: json["nu_cpf"],
        nuRg: json["nu_rg"],
        noOrgaoEmisor: json["no_orgao_emisor"],
        ufOrgaoEmissor: json["uf_orgao_emisor"],
        dsEndereco: json["ds_endereco"],
        noEmail: json["no_email"],
        noEmailPessoal: json["no_email_personal"],
        nuTelefone: json["nu_telefone"],
        dtAlteracao: json["dt_alteracao"],
        urlFoto: json["url_foto"],
        instantMessenger: json["instant_messenger"],
        icq: json["icq"],
        msn: json["msn"],
        yms: json["yms"],
        dsCompEnd: json["ds_comp_end"],
        dsBairro: json["ds_barrio"],
        nuCep: json["nu_cep"],
        noCidade: json["no_cidade"],
        ufCidade: json["dt_expedicao"],

        
        );
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}
 */