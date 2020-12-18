import 'package:flutter/material.dart';
import 'package:project/models/group.dart';
import 'package:project/utils/group_helper.dart';

class ManageGroup extends StatefulWidget {
  @override
  _ManageGroupState createState() => _ManageGroupState();
}

class _ManageGroupState extends State<ManageGroup> {
  TextEditingController ctrCodigo = TextEditingController();
  TextEditingController ctrNome = TextEditingController();
  TextEditingController ctrDescricao = TextEditingController();
  TextEditingController ctrArvores = TextEditingController();
  Grupo grupo;

  List<Grupo> listaGrupo = List<Grupo>();

  GroupHelper _db = GroupHelper();

  void gravarGrupo({Grupo dados}) {
    setState(() async {
      if (dados == null) {
        Grupo grupo = Grupo(ctrNome.text, ctrDescricao.text, ctrArvores.text);
        int resultado = await _db.insertGrupo(grupo);

        if (resultado != null) {
          print('CADATRADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO CADASTRAR!');
        }
      } else {
        dados.nome = ctrNome.text;
        dados.descricao = ctrDescricao.text;
        dados.arvores = ctrArvores.text;
        int resultado = await _db.updateGrupo(dados);

        if (resultado != null) {
          print('ALTERADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO ALTERAR!');
        }
      }
      ctrNome.clear();
      ctrDescricao.clear();
      ctrArvores.clear();
      consultaGrupo();
      Navigator.pop(context);
    });
  }

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

  void removerGrupo(int codigo) async {
    int resultado = await _db.deleteGrupo(codigo);
    consultaGrupo();
  }

  void exibirTelaConfirma(int codigo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir Grupo'),
            content: Text('Este item será excluído, deseja prosseguir?'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                child: Text('SIM'),
                onPressed: () {
                  removerGrupo(codigo);
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

  void exibirTelaCadastro({Grupo grupo}) {
    String textoTitulo = '';
    String textoBotao = '';

    if (grupo == null) {
      textoTitulo = 'Adicionar Grupo';
      textoBotao = 'SALVAR';
    } else {
      textoTitulo = 'Editar Grupo';
      textoBotao = 'EDITAR';
      ctrNome.text = grupo.nome;
      ctrDescricao.text = grupo.descricao;
      ctrArvores.text = grupo.arvores;
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
                  controller: ctrNome,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Insira o nome',
                  ),
                ),
                TextField(
                  controller: ctrDescricao,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Insira a descrição',
                  ),
                ),
                TextField(
                  controller: ctrArvores,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Árvores',
                    hintText: 'Insira as árvores',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('$textoBotao'),
                  onPressed: () {
                    gravarGrupo(dados: grupo);
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
    consultaGrupo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Gerenciamento de Grupos'),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              exibirTelaCadastro(grupo: e);
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
