import 'package:campus_claim/Screens/Updating_item_screen.dart';
import 'package:campus_claim/Screens/add_item_screen.dart';
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
        automaticallyImplyLeading: false,
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        height: 80,
        width: 393,
        decoration: BoxDecoration(
          color: Color(0xFFA855F7),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddItemsList()),
                );
              },
              icon: Icon(Icons.upload, size: 36, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ItemListScroll()),
                );
              },
              icon: Icon(Icons.list, size: 36, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => updating_Item_Screen()),
                );
              },
              icon: Icon(Icons.update, size: 32, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
