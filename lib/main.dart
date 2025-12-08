import 'package:flutter/material.dart';
import 'Screens/add_item_screen.dart';
import 'Screens/item_list_screen.dart';
import 'Screens/starting_screen.dart';

void main() {
  runApp(Campus_claim());
}

class Campus_claim extends StatelessWidget {
  const Campus_claim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Starting(),
        'add_item': (context) => AddItemsList(),
        'item_list': (context) => ItemListScroll(),
      },
    );
  }
}
