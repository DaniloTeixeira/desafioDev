import 'package:flutter/material.dart';
import 'package:project/utils/group_helper.dart';
import 'package:project/models/group.dart';

class FilterGroup extends StatefulWidget {
  @override
  _FilterGroupState createState() => _FilterGroupState();
}

class _FilterGroupState extends State<FilterGroup> {
  List<Grupo> listaGrupo = List<Grupo>();
  GroupHelper _db = GroupHelper();

  void consultaGrupo() async {
    List consulta = await _db.getGrupo();

    List<Grupo> listaTemporaria = List<Grupo>();

    for (var item in consulta) {
      Grupo e = Grupo.fromMap(item);
      listaTemporaria.add(e);
    }
    setState(() {
      listaGrupo = listaTemporaria;
    });
    listaTemporaria = null;
  }

  @override
  void initState() {
    super.initState();
    consultaGrupo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Relatório por Grupo'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: listaGrupo.length,
                itemBuilder: (context, index) {
                  final Grupo e = listaGrupo[index];
                  return Card(
                    child: ListTile(
                      title: Text('Código: ' + e.codigo.toString()),
                      subtitle: Text(
                        'Nome: ' +
                            e.nome +
                            '\n' +
                            'Descrição: ' +
                            e.descricao +
                            '\n' +
                            'Árvores: ' +
                            e.arvores,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
