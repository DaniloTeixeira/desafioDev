import 'package:flutter/material.dart';
import 'package:project/models/harvest.dart';
import 'package:project/utils/harvest_helper.dart';

class ManageHarvest extends StatefulWidget {
  @override
  _ManageHarvestState createState() => _ManageHarvestState();
}

class _ManageHarvestState extends State<ManageHarvest> {
  TextEditingController ctrCodigo = TextEditingController();
  TextEditingController ctrInformacoes = TextEditingController();
  TextEditingController ctrData = TextEditingController();
  TextEditingController ctrPeso = TextEditingController();
  TextEditingController ctrArvore = TextEditingController();
  Colheita colheita;

  List<Colheita> listaColheita = List<Colheita>();

  HarvestHelper _db = HarvestHelper();

  void gravarColheita({Colheita dados}) {
    setState(() async {
      if (dados == null) {
        Colheita colheita = Colheita(ctrInformacoes.text, ctrData.text,
            int.parse(ctrPeso.text), ctrArvore.text);
        int resultado = await _db.insertColheita(colheita);

        if (resultado != null) {
          print('CADATRADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO CADASTRAR!');
        }
      } else {
        dados.info = ctrInformacoes.text;
        dados.data = ctrData.text;
        dados.peso = int.parse(ctrPeso.text);
        dados.arvore = ctrArvore.text;
        int resultado = await _db.updateColheita(dados);

        if (resultado != null) {
          print('ALTERADO COM SUCESSO!' + resultado.toString());
        } else {
          print('ERRO AO ALTERAR!');
        }
      }
      ctrInformacoes.clear();
      ctrData.clear();
      ctrPeso.clear();
      ctrArvore.clear();
      consultaColheita();
      Navigator.pop(context);
    });
  }

  void consultaColheita() async {
    List consulta = await _db.getColheita();

    List<Colheita> listaTemporaria = List<Colheita>();

    for (var item in consulta) {
      Colheita e = Colheita.fromMap(item);
      listaTemporaria.add(e);
    }
    setState(() {
      listaColheita = listaTemporaria;
    });
    listaTemporaria = null;
  }

  void removerColheita(int codigo) async {
    int resultado = await _db.deleteColheita(codigo);
    consultaColheita();
  }

  void exibirTelaConfirma(int codigo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Excluir Colheita'),
            content: Text('Este item será excluído, deseja prosseguir?'),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                child: Text('SIM'),
                onPressed: () {
                  removerColheita(codigo);
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

  void exibirTelaCadastro({Colheita colheita}) {
    String textoTitulo = '';
    String textoBotao = '';

    if (colheita == null) {
      textoTitulo = 'Adicionar Colheita';
      textoBotao = 'SALVAR';
    } else {
      textoTitulo = 'Editar Colheita';
      textoBotao = 'EDITAR';
      ctrInformacoes.text = colheita.info;
      ctrData.text = colheita.data;
      ctrPeso.text = colheita.peso.toString();
      ctrArvore.text = colheita.arvore;
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
                  controller: ctrInformacoes,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Informações',
                    hintText: 'Insira as informações',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  controller: ctrData,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Data',
                    hintText: 'dd/mm/aaaa',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ctrPeso,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Peso Bruto em Kg.',
                    hintText: 'Insira o peso',
                  ),
                ),
                TextField(
                  controller: ctrArvore,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Árvore',
                    hintText: 'Insira a árvore',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('$textoBotao'),
                  onPressed: () {
                    gravarColheita(dados: colheita);
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
    consultaColheita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Gerenciamento de Colheita'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: listaColheita.length,
                itemBuilder: (context, index) {
                  final Colheita e = listaColheita[index];
                  return Card(
                    child: ListTile(
                      title: Text('Código: ' + e.codigo.toString()),
                      subtitle: Text('Informações: ' +
                          e.info +
                          '\n' +
                          'Data da colheita: ' +
                          e.data +
                          '\n' +
                          'Peso Bruto em kg.: ' +
                          e.peso.toString() +
                          'kg.' +
                          '\n' +
                          'Árvore: ' +
                          e.arvore),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              exibirTelaCadastro(colheita: e);
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
