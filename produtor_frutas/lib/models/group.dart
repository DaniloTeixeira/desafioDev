class Grupo {
  int _codigo;
  String _nome;
  String _descricao;
  String _arvores;

  Grupo(this._nome, this._descricao, this._arvores);

  Grupo.fromMap(Map<String, dynamic> map) {
    _codigo = map['codigo'];
    _nome = map['nome'];
    _descricao = map['descricao'];
    _arvores = map['arvores'];
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': _codigo,
      'nome': _nome,
      'descricao': _descricao,
      'arvores': _arvores
    };
  }

  int get codigo => _codigo;

  set codigo(int value) => _codigo = value;

  String get nome => _nome;

  set nome(String value) => _nome = value;

  String get descricao => _descricao;

  set descricao(String value) => _descricao = value;

  String get arvores => _arvores;

  set arvores(String value) => _arvores = value;
}
