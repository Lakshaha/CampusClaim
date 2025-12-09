import 'package:flutter/material.dart';

class ItemListScroll extends StatefulWidget {
  const ItemListScroll({super.key});

  @override
  State<ItemListScroll> createState() => _ItemListScrollState();
}

class _ItemListScrollState extends State<ItemListScroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFA855F7),
        title: Text(
          'CampusClaim',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            letterSpacing: 2,
          ),
        ),
      ),
      body: Text('Body'),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload item',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lost items'),
          BottomNavigationBarItem(
            icon: Icon(Icons.restart_alt),
            label: 'Update item',
          ),
        ],
      ),
    );
  }
}
