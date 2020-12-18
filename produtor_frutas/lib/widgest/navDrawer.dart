import 'package:flutter/material.dart';
import 'package:project/routes.dart/routes.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/image_side_menu.jpg'),
              ),
            ),
          ),
          ListTile(
            title: Text('Grupos de Árvores'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed(AppRoutes.MANAGE_GROUP),
            },
          ),
          ListTile(
            title: Text('Espécies de Árvores'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed(AppRoutes.MANAGE_SPECIES),
            },
          ),
          ListTile(
            title: Text('Árvores'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed(AppRoutes.MANAGE_TREE),
            },
          ),
          ListTile(
            title: Text('Colheitas'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed(AppRoutes.MANAGE_HARVEST),
            },
          ),
        ],
      ),
    );
  }
}
