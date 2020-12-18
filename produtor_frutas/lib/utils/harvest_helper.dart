import 'package:path_provider/path_provider.dart';
import 'package:project/models/harvest.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'db.dart';

class HarvestHelper {
  // Pega o caminho do celular para salvar o banco
  Future<Database> createDatabase() async {
    Directory pasta = await getApplicationDocumentsDirectory();
    String caminho = pasta.path + DATABASE;

    var bancoDeDados =
        await openDatabase(caminho, version: 1, onCreate: createTable);
    return bancoDeDados;
  }

  // Cria conexão com o banco
  static HarvestHelper _dataBasehelper;
  static Database _dataBase;

  HarvestHelper._createInstance();

  factory HarvestHelper() {
    if (_dataBasehelper == null) {
      _dataBasehelper = HarvestHelper._createInstance();
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

  // Define estrutura da tabela
// Métodos CRUD

  Future<int> insertColheita(Colheita colheita) async {
    Database db = await this.dataBase;
    var resultado = await db.insert('colheita', colheita.toMap());
    return resultado;
  }

// READ
  getColheita() async {
    Database db = await this.dataBase;
    String sql = 'SELECT * FROM colheita';
    List listaColheita = await db.rawQuery(sql);
    return listaColheita;
  }

// UPDATE
  Future<int> updateColheita(Colheita e) async {
    Database db = await this.dataBase;
    var resultado = await db.update('colheita', e.toMap(),
        where: 'codigo = ?', whereArgs: [e.codigo]);
    return resultado;
  }

// DELETE
  Future<int> deleteColheita(int codigo) async {
    Database db = await this.dataBase;
    var resultado =
        await db.delete('colheita', where: 'codigo = ?', whereArgs: [codigo]);
    return resultado;
  }
}
