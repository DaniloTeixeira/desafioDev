import 'package:path_provider/path_provider.dart';
import 'package:project/models/species.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'db.dart';

class SpeciesHelper {
  // Pega o caminho do celular para salvar o banco
  Future<Database> createDatabase() async {
    Directory pasta = await getApplicationDocumentsDirectory();
    String caminho = pasta.path + DATABASE;

    var bancoDeDados =
        await openDatabase(caminho, version: 1, onCreate: createTable);
    return bancoDeDados;
  }

  // Cria conexão com o banco
  static SpeciesHelper _dataBasehelper;
  static Database _dataBase;

  SpeciesHelper._createInstance();

  factory SpeciesHelper() {
    if (_dataBasehelper == null) {
      _dataBasehelper = SpeciesHelper._createInstance();
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

  Future<int> insertEspecie(Especie especie) async {
    Database db = await this.dataBase;
    var resultado = await db.insert('especie', especie.toMap());
    return resultado;
  }

// READ
  getEspecie() async {
    Database db = await this.dataBase;
    String sql = 'SELECT * FROM especie';
    List listaEspecie = await db.rawQuery(sql);
    return listaEspecie;
  }

// UPDATE
  Future<int> updateEspecie(Especie e) async {
    Database db = await this.dataBase;
    var resultado = await db.update('especie', e.toMap(),
        where: 'codigo = ?', whereArgs: [e.codigo]);
    return resultado;
  }

// DELETE
  Future<int> deleteEspecie(int codigo) async {
    Database db = await this.dataBase;
    var resultado =
        await db.delete('especie', where: 'codigo = ?', whereArgs: [codigo]);
    return resultado;
  }
}
