// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:campus_claim/Screens/add_item_screen.dart';
import 'package:campus_claim/Screens/item_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class updating_Item_Screen extends StatefulWidget {
  const updating_Item_Screen({super.key});

  @override
  State<updating_Item_Screen> createState() => _updating_Item_ScreenState();
}

class _updating_Item_ScreenState extends State<updating_Item_Screen> {
  late final String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
  }

  Stream<QuerySnapshot> myItemsStream() {
    return FirebaseFirestore.instance
        .collection('items')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> change_status(String itemId, bool value) async {
    await FirebaseFirestore.instance.collection('items').doc(itemId).update({
      'isFound': value,
    });
  }

  Future<void> confirmFound(BuildContext context, String itemId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm', style: TextStyle(fontFamily: 'Manrope')),
          content: Text('Have you found this item?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF43F5E),
              ),
              child: Text(
                "NO",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('items')
                    .doc(itemId)
                    .update({'isFound': true});
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF10b981),
              ),
              child: Text(
                "YES",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFA855F7),
        automaticallyImplyLeading: false,
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
      body: (StreamBuilder(
        stream: myItemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "You havent uploaded any items yet!!!",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            );
          }
          final items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final docs = items[index];
              final data = docs.data() as Map<String, dynamic>;
              final bool isFound = data['isFound'] ?? false;
              final imageUrl = data['imageUrl'];

              return Card(
                //elevation: 4,
                margin: EdgeInsets.only(bottom: 12),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(12),
                // ),
                color: isFound ? Color(0xFF10b981) : Color(0xFFF43F5E),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl != null && imageUrl.toString().isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data['imageUrl'],
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/image.png',
                            fit: BoxFit.cover,
                            height: 160,
                            width: double.infinity,
                          ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        data['itemName']?.toString() ?? 'Unnamed item',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        data['contact']?.toString() ?? 'Contact missing',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        data['location']?.toString() ?? 'Not located',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Text(
                              isFound ? "STATUS: FOUND" : "STATUS: LOST",
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: isFound,
                            onChanged: isFound
                                ? null
                                : (_) => confirmFound(context, docs.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      )),
      bottomNavigationBar: Container(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => updating_Item_Screen()),
                //);
              },
              icon: Icon(Icons.update, size: 32, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
