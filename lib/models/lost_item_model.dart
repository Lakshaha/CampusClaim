import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Item {
  final String? id;
  final String itemName;
  final String contactDetails;
  final String location;
  final String? imageUrl;
  final DateTime createdAt;
  final String userId;

  Item({
    this.id,
    required this.itemName,
    required this.contactDetails,
    required this.location,
    this.imageUrl,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      "itemName": itemName,
      "contact": contactDetails,
      "imageUrl": imageUrl,
      "location": location,
      "createdAt": createdAt,
      "userId": userId,
    };
  }

  //firebase map to item object
  factory Item.fromMap(Map<String, dynamic> data, String docId) {
    return Item(
      id: docId,
      itemName: data['itemName'],
      contactDetails: data['contact'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: (data['userId']),
    );
  }
}
