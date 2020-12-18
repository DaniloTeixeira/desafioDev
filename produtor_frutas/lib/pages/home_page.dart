import 'package:flutter/material.dart';
import 'package:project/routes.dart/routes.dart';
import 'package:project/widgest/navDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Relatório de Colheitas'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.filter_alt),
            itemBuilder: (content) => [
              PopupMenuItem(
                value: 1,
                child: Text('Árvore'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Grupo de Árvore'),
              ),
              PopupMenuItem(
                value: 3,
                child: Text('Espécie'),
              ),
              PopupMenuItem(
                value: 4,
                child: Text('Periodo'),
              ),
            ],
            onSelected: (int menu) {
              if (menu == 1) {
                Navigator.of(context).pushNamed(AppRoutes.FILTER_TREE);
              } else if (menu == 2) {
                Navigator.of(context).pushNamed(AppRoutes.FILTER_GROUP);
              } else if (menu == 3) {
                Navigator.of(context).pushNamed(AppRoutes.FILTER_SPECIES);
              } else if (menu == 4) {
                Navigator.of(context).pushNamed(AppRoutes.FILTER_PERIOD);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/image_home.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
