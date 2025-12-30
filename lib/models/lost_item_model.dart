import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String? id;
  final String itemName;
  final String contactDetails;
  final String location;
  String? imageUrl;
  final String userId;
  final bool isFound;

  Item({
    this.id,
    required this.itemName,
    required this.contactDetails,
    required this.location,
    this.imageUrl,
    required this.userId,
    required this.isFound,
  });

  Map<String, dynamic> toMap() {
    return {
      "itemName": itemName,
      "contact": contactDetails,
      "imageUrl": imageUrl,
      "location": location,
      "createdAt": FieldValue.serverTimestamp(), // 🔥 FIX
      "userId": userId,
      "isFound": isFound,
    };
  }

  //firebase map to item object
  factory Item.fromMap(Map<String, dynamic> data, String docId) {
    return Item(
      id: docId,
      itemName: data['itemName'] ?? 'No name',
      contactDetails: data['contact'] ?? 'No Contact',
      location: data['location'] ?? 'No loc',
      imageUrl: data['imageUrl'],
      //createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: (data['userId']),
      isFound: data['isFound'] ?? false,
    );
  }
}
