import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/lost_item_model.dart';

class ItemService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadItem(Item item) async {
    await _db.collection('items').add(item.toMap());
  }

  Stream<List<Item>> getAllItems() {
    return _db
        .collection('items')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Item.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  Stream<List<Item>> getMyItems() {
    final uid = _auth.currentUser?.uid;

    if (uid == null) return Stream.value([]);

    return _db
        .collection('items')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Item.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  Future<void> deleteItem(String docId) async {
    await _db.collection('items').doc(docId).delete();
  }

  Future<Item?> getItem(String docId) async {
    var doc = await _db.collection('items').doc(docId).get();
    if (!doc.exists) return null;
    return Item.fromMap(doc.data()!, doc.id);
  }
}
