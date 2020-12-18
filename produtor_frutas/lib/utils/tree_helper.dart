import 'package:path_provider/path_provider.dart';
import 'package:project/models/tree.dart';
import 'package:project/utils/db.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class TreeHelper {
  // Pega o caminho do celular para salvar o banco
  Future<Database> createDatabase() async {
    Directory pasta = await getApplicationDocumentsDirectory();
    String caminho = pasta.path + DATABASE;

    var bancoDeDados =
        await openDatabase(caminho, version: 1, onCreate: createTable);
    return bancoDeDados;
  }

  // Cria conexão com o banco
  static TreeHelper _dataBasehelper;
  static Database _dataBase;

  TreeHelper._createInstance();

  factory TreeHelper() {
    if (_dataBasehelper == null) {
      _dataBasehelper = TreeHelper._createInstance();
    }
    return _dataBasehelper;
  }
  // Inicializa o banco
  Future<Database> get dataBase async {
    if (_dataBase == null) {
      _dataBase = await createDatabase();
    }
    return _dataBase;
  }

  // Métodos CRUD

  Future<int> insertArvore(Arvore arvore) async {
    Database db = await this.dataBase;
    var resultado = await db.insert('arvore', arvore.toMap());
    return resultado;
  }

// READ
  getArvore() async {
    Database db = await this.dataBase;
    String sql = 'SELECT * FROM arvore';
    List listaArvore = await db.rawQuery(sql);
    return listaArvore;
  }

// UPDATE
  Future<int> updateArvore(Arvore e) async {
    Database db = await this.dataBase;
    var resultado = await db.update('arvore', e.toMap(),
        where: 'codigo = ?', whereArgs: [e.codigo]);
    return resultado;
  }

// DELETE
  Future<int> deleteArvore(int codigo) async {
    Database db = await this.dataBase;
    var resultado =
        await db.delete('arvore', where: 'codigo = ?', whereArgs: [codigo]);
    return resultado;
  }
}
