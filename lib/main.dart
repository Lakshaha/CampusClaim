// ignore_for_file: camel_case_types
import 'package:campus_claim/Screens/Updating_item_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/add_item_screen.dart';
import 'Screens/item_list_screen.dart';
import 'Screens/starting_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    await auth.signInAnonymously();
  }
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
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: startRoute,
      routes: {
        '/': (context) => Starting(),
        'add_item': (context) => AddItemsList(),
        'item_list': (context) => ItemListScroll(),
        'update_item': (context) => updating_Item_Screen(),
      },
    );
  }
}
