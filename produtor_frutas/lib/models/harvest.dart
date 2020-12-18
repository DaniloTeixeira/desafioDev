class Colheita {
  int _codigo;
  String _informacoes;
  String _data;
  int _pesoBruto;
  String _arvore;

  Colheita(this._informacoes, this._data, this._pesoBruto, this._arvore);

  Colheita.fromMap(Map<String, dynamic> map) {
    _codigo = map['codigo'];
    _informacoes = map['info'];
    _data = map['data'];
    _pesoBruto = map['peso'];
    _arvore = map['arvore'];
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': _codigo,
      'info': _informacoes,
      'data': _data,
      'peso': _pesoBruto,
      'arvore': _arvore
    };
  }

  int get codigo => _codigo;

  set codigo(int value) => _codigo = value;

  String get info => _informacoes;

  set info(String value) => _informacoes = value;

  String get data => _data;

  set data(String value) => _data = value;

  int get peso => _pesoBruto;

  set peso(int value) => _pesoBruto = value;

  String get arvore => _arvore;

  set arvore(String value) => _arvore = value;
}
