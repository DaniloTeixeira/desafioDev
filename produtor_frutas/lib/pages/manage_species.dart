import 'package:flutter/material.dart';
import 'package:project/models/species.dart';
import 'package:project/utils/species_helper.dart';

class ManageSpecies extends StatefulWidget {
  @override
  _ManageSpeciesState createState() => _ManageSpeciesState();
}

class _ManageSpeciesState extends State<ManageSpecies> {
  TextEditingController ctrCodigo = TextEditingController();
  TextEditingController ctrDescricao = TextEditingController();
  Especie especie;

  List<Especie> listaEspecie = List<Especie>();

  SpeciesHelper _db = SpeciesHelper();

  void gravarEspecie({Especie esp}) {
    setState(() async {
      if (esp == null) {
        Especie especie = Especie(ctrDescricao.text);
        int resultado = await _db.insertEspecie(especie);

        if (resultado != null) {
          print('CADATRADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO CADASTRAR!');
        }
      } else {
        esp.descricao = ctrDescricao.text;
        int resultado = await _db.updateEspecie(esp);

        if (resultado != null) {
          print('ALTERADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO ALTERAR!');
        }
      }
      ctrDescricao.clear();
      consultaEspecie();
      Navigator.pop(context);
    });
  }

  void consultaEspecie() async {
    List consultaEsp = await _db.getEspecie();
    // print('Contatos cadastrados: ' + consultaEsp.toString());

    List<Especie> listaTemporaria = List<Especie>();

    for (var item in consultaEsp) {
      Especie e = Especie.fromMap(item);
      listaTemporaria.add(e);
    }
    setState(() {
      listaEspecie = listaTemporaria;
    });
    listaTemporaria = null;
  }

  void removerEspecie(int codigo) async {
    int resultado = await _db.deleteEspecie(codigo);
    consultaEspecie();
  }

  void exibirTelaConfirma(int codigo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir Espécie'),
            content: Text('Este item será excluído, deseja prosseguir?'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                child: Text('SIM'),
                onPressed: () {
                  removerEspecie(codigo);
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                color: Colors.white,
                child: Text('NÃO'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void exibirTelaCadastro({Especie especie}) {
    String textoTitulo = '';
    String textoBotao = '';

    if (especie == null) {
      textoTitulo = 'Adicionar Espécie';
      textoBotao = 'SALVAR';
    } else {
      textoTitulo = 'Editar Descrição';
      textoBotao = 'EDITAR';
      ctrDescricao.text = especie.descricao;
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$textoTitulo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: ctrDescricao,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Insira a descrição',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('$textoBotao'),
                  onPressed: () {
                    gravarEspecie(esp: especie);
                  }),
              FlatButton(
                child: Text('CANCELAR'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    consultaEspecie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Gerenciamento de Espécie'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: listaEspecie.length,
                itemBuilder: (context, index) {
                  final Especie e = listaEspecie[index];
                  return Card(
                    child: ListTile(
                      title: Text('Código: ' + e.codigo.toString()),
                      subtitle: Text('Descrição: ' + e.descricao),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              exibirTelaCadastro(especie: e);
                            },
                            child: Icon(Icons.edit, color: Colors.blue),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              exibirTelaConfirma(e.codigo);
                            },
                            child: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          exibirTelaCadastro();
        },
      ),
    );
  }
}
