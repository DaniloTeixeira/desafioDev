class Arvore {
  int _codigo;
  String _descricao;
  int _idade;
  String _especie;

  Arvore(this._descricao, this._idade, this._especie);

  Arvore.fromMap(Map<String, dynamic> map) {
    _codigo = map['codigo'];
    _descricao = map['descricao'];
    _idade = map['idade'];
    _especie = map['especie'];
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'idade': idade,
      'especie': especie
    };
  }

  int get codigo => _codigo;

  set codigo(int value) => _codigo = value;

  String get descricao => _descricao;

  set descricao(String value) => _descricao = value;

  int get idade => _idade;

  set idade(int value) => _idade = value;

  String get especie => _especie;

  set especie(String value) => _especie = value;
}
