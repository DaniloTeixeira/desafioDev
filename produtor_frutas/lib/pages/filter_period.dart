import 'package:flutter/material.dart';
import 'package:project/models/harvest.dart';
import 'package:project/utils/harvest_helper.dart';

class FilterPeriod extends StatefulWidget {
  @override
  _FilterPeriodState createState() => _FilterPeriodState();
}

class _FilterPeriodState extends State<FilterPeriod> {
  List<Colheita> listaColheita = List<Colheita>();
  HarvestHelper _db = HarvestHelper();

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
        title: Text('Relatório por Período'),
        centerTitle: true,
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
                      title: Text('Colheita ' + e.codigo.toString()),
                      subtitle: Text('Data: ' + e.data),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
