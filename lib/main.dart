// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/add_item_screen.dart';
import 'Screens/item_list_screen.dart';
import 'Screens/starting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final completed = prefs.getBool("onboarding_completed") ?? false;

  runApp(Campus_claim(startRoute: completed ? 'item_list' : '/'));
}

class Campus_claim extends StatelessWidget {
  final String startRoute;
  const Campus_claim({required this.startRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: startRoute,
      routes: {
        '/': (context) => Starting(),
        'add_item': (context) => AddItemsList(),
        'item_list': (context) => ItemListScroll(),
      },
    );
  }
}
