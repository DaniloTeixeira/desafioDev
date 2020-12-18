import 'package:flutter/material.dart';
import 'package:project/pages/manage_group.dart';
import 'package:project/pages/manage_harvest.dart';
import 'package:project/pages/manage_tree.dart';
import 'package:project/pages/filter_tree.dart';
import 'package:project/pages/filter_group.dart';
import 'package:project/pages/filter_species.dart';
import 'package:project/pages/filter_period.dart';
import 'pages/home_page.dart';
import 'pages/manage_species.dart';
import 'routes.dart/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Produtor de frutas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME_PAGE: (_) => HomePage(),
          AppRoutes.MANAGE_SPECIES: (_) => ManageSpecies(),
          AppRoutes.MANAGE_TREE: (_) => ManageTree(),
          AppRoutes.MANAGE_GROUP: (_) => ManageGroup(),
          AppRoutes.MANAGE_HARVEST: (_) => ManageHarvest(),
          AppRoutes.FILTER_TREE: (_) => FilterTree(),
          AppRoutes.FILTER_GROUP: (_) => FilterGroup(),
          AppRoutes.FILTER_SPECIES: (_) => FilterSpecies(),
          AppRoutes.FILTER_PERIOD: (_) => FilterPeriod(),
        });
  }
}
