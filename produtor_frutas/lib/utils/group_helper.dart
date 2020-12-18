import 'package:path_provider/path_provider.dart';
import 'package:project/models/group.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'db.dart';

class GroupHelper {
  // Pega o caminho do celular para salvar o banco
  Future<Database> createDatabase() async {
    Directory pasta = await getApplicationDocumentsDirectory();
    String caminho = pasta.path + DATABASE;

    var bancoDeDados =
        await openDatabase(caminho, version: 1, onCreate: createTable);
    return bancoDeDados;
  }

  // Cria conexão com o banco
  static GroupHelper _dataBasehelper;
  static Database _dataBase;

  GroupHelper._createInstance();

  factory GroupHelper() {
    if (_dataBasehelper == null) {
      _dataBasehelper = GroupHelper._createInstance();
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

  Future<int> insertGrupo(Grupo grupo) async {
    Database db = await this.dataBase;
    var resultado = await db.insert('grupo', grupo.toMap());
    return resultado;
  }

// READ
  getGrupo() async {
    Database db = await this.dataBase;
    String sql = 'SELECT * FROM grupo';
    List listaGrupo = await db.rawQuery(sql);
    return listaGrupo;
  }

// UPDATE
  Future<int> updateGrupo(Grupo e) async {
    Database db = await this.dataBase;
    var resultado = await db
        .update('grupo', e.toMap(), where: 'codigo = ?', whereArgs: [e.codigo]);
    return resultado;
  }

// DELETE
  Future<int> deleteGrupo(int codigo) async {
    Database db = await this.dataBase;
    var resultado =
        await db.delete('grupo', where: 'codigo = ?', whereArgs: [codigo]);
    return resultado;
  }
}
