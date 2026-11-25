import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/address_model.dart';

class AddressService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _col => _db
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('addresses');

  Stream<List<AddressModel>> watch() => _col.snapshots().map((snap) {
        final list =
            snap.docs.map((d) => AddressModel.fromMap(d.id, d.data())).toList();
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return list;
      });

  Future<void> add(AddressModel a) => _col.add(a.toMap());

  Future<void> update(AddressModel a) => _col.doc(a.id).update(a.toMap());

  Future<void> delete(String id) => _col.doc(id).delete();
}