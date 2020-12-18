class Especie {
  int _codigo;
  String _descricao;

  Especie(this._descricao);

  Especie.fromMap(Map<String, dynamic> map) {
    this._codigo = map['codigo'];
    this._descricao = map['descricao'];
  }

  Map<String, dynamic> toMap() {
    return {'codigo': codigo, 'descricao': descricao};
  }

  int get codigo => _codigo;

  set codigo(int value) => _codigo = value;

  String get descricao => _descricao;

  set descricao(String value) => _descricao = value;
}
