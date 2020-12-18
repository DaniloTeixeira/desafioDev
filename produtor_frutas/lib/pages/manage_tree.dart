import 'package:flutter/material.dart';
import 'package:project/models/tree.dart';
import 'package:project/utils/tree_helper.dart';

class ManageTree extends StatefulWidget {
  @override
  _ManageTreeState createState() => _ManageTreeState();
}

class _ManageTreeState extends State<ManageTree> {
  TextEditingController ctrCodigo = TextEditingController();
  TextEditingController ctrDescricao = TextEditingController();
  TextEditingController ctrIdade = TextEditingController();
  TextEditingController ctrEspecie = TextEditingController();
  Arvore arvore;

  List<Arvore> listaArvore = List<Arvore>();

  TreeHelper _db = TreeHelper();

  void gravarArvore({Arvore dados}) {
    setState(() async {
      if (dados == null) {
        Arvore arvore = Arvore(
            ctrDescricao.text, int.parse(ctrIdade.text), ctrEspecie.text);
        int resultado = await _db.insertArvore(arvore);

        if (resultado != null) {
          print('CADATRADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO CADASTRAR!');
        }
      } else {
        dados.descricao = ctrDescricao.text;
        dados.idade = int.parse(ctrIdade.text);
        dados.especie = ctrEspecie.text;
        int resultado = await _db.updateArvore(dados);

        if (resultado != null) {
          print('ALTERADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO ALTERAR!');
        }
      }
      ctrDescricao.clear();
      ctrIdade.clear();
      ctrEspecie.clear();
      consultaArvore();
      Navigator.pop(context);
    });
  }

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

  void removerArvore(int codigo) async {
    int resultado = await _db.deleteArvore(codigo);
    consultaArvore();
  }

  void exibirTelaConfirma(int codigo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir Árvore'),
            content: Text('Este item será excluído, deseja prosseguir?'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                child: Text('SIM'),
                onPressed: () {
                  removerArvore(codigo);
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

  void exibirTelaCadastro({Arvore arvore}) {
    String textoTitulo = '';
    String textoBotao = '';

    if (arvore == null) {
      textoTitulo = 'Adicionar Árvore';
      textoBotao = 'SALVAR';
    } else {
      textoTitulo = 'Editar Árvore';
      textoBotao = 'EDITAR';
      ctrDescricao.text = arvore.descricao;
      ctrIdade.text = arvore.idade.toString();
      ctrEspecie.text = arvore.especie;
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
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ctrIdade,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Idade',
                    hintText: 'Insira a idade',
                  ),
                ),
                TextField(
                  controller: ctrEspecie,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Espécie',
                    hintText: 'Insira a espécie',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('$textoBotao'),
                  onPressed: () {
                    gravarArvore(dados: arvore);
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
    consultaArvore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Gerenciamento de Árvore'),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              exibirTelaCadastro(arvore: e);
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
