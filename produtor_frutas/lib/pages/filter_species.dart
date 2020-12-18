import 'package:flutter/material.dart';
import 'package:project/models/species.dart';
import 'package:project/utils/species_helper.dart';

class FilterSpecies extends StatefulWidget {
  @override
  _FilterSpeciesState createState() => _FilterSpeciesState();
}

class _FilterSpeciesState extends State<FilterSpecies> {
  List<Especie> listaEspecie = List<Especie>();
  SpeciesHelper _db = SpeciesHelper();

  void consultaEspecie() async {
    List consultaEsp = await _db.getEspecie();

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
        title: Text('Relatório por Espécie'),
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
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
