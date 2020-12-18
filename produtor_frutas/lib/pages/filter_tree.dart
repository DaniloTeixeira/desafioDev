import 'package:flutter/material.dart';
import 'package:project/models/tree.dart';
import 'package:project/utils/tree_helper.dart';

class FilterTree extends StatefulWidget {
  @override
  _FilterTreeState createState() => _FilterTreeState();
}

class _FilterTreeState extends State<FilterTree> {
  List<Arvore> listaArvore = List<Arvore>();
  TreeHelper _db = TreeHelper();

  void consultaArvore() async {
    List consulta = await _db.getArvore();

    List<Arvore> listaTemporaria = List<Arvore>();

    for (var item in consulta) {
      Arvore e = Arvore.fromMap(item);
      listaTemporaria.add(e);
    }
    setState(() {
      listaArvore = listaTemporaria;
    });
    listaTemporaria = null;
  }

  @override
  void initState() {
    super.initState();
    consultaArvore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Relatório por Árvore'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: listaArvore.length,
                itemBuilder: (context, index) {
                  final Arvore e = listaArvore[index];
                  return Card(
                    child: ListTile(
                      title: Text('Código: ' + e.codigo.toString()),
                      subtitle: Text('Descrição: ' +
                          e.descricao +
                          '\n' +
                          'Idade: ' +
                          e.idade.toString() +
                          ' anos' +
                          '\n' +
                          'Espécie: ' +
                          e.especie),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
