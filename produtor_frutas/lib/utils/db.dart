import 'package:sqflite/sqflite.dart';

const DATABASE = 'producer.db';

String tableEspecie = "especie";

String codEspecie = "codigo";
String descEspecie = "descricao";

String tableArvore = "arvore";

String codArvore = "codigo";
String descArvore = "descricao";
String idadeArvore = "idade";
String especieArvore = "especie";

String tableGrupo = "grupo";

String codGrupo = "codigo";
String nomeGrupo = "nome";
String descGrupo = "descricao";
String arvoresGrupo = "arvores";

String tableColheita = "colheita";

String codColheita = "codigo";
String infoColheita = "info";
String dataColheita = 'data';
String pesoColheita = "peso";
String arvoreColheita = "arvore";

Future<void> createTable(Database db, int novaVersao) async {
  List<String> queryes = [
    "CREATE TABLE $tableEspecie ($codEspecie INTEGER PRIMARY KEY AUTOINCREMENT, $descEspecie TEXT);",
    "CREATE TABLE $tableArvore ($codArvore INTEGER PRIMARY KEY AUTOINCREMENT, $descArvore TEXT, $idadeArvore INTEGER, $especieArvore TEXT);",
    "CREATE TABLE $tableGrupo ($codGrupo INTEGER PRIMARY KEY AUTOINCREMENT, $nomeGrupo TEXT, $descGrupo TEXT, $arvoresGrupo TEXT);",
    "CREATE TABLE $tableColheita ($codColheita INTEGER PRIMARY KEY AUTOINCREMENT, $infoColheita TEXT, $dataColheita TEXT, $pesoColheita INTEGER, $arvoreColheita TEXT);",
  ];

  for (String query in queryes) {
    await db.execute(query);
  }
}
