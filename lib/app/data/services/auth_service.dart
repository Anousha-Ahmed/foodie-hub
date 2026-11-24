import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/utils/validators.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> signUp({
    required String fullName,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String zipCode,
    required String country,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: Validators.phoneToEmail(phone),
      password: password,
    );
    final user = UserModel(
      uid: cred.user!.uid,
      fullName: fullName,
      phone: phone,
      address: address,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
    );
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<void> signIn({required String phone, required String password}) async {
    await _auth.signInWithEmailAndPassword(
      email: Validators.phoneToEmail(phone),
      password: password,
    );
  }

  Future<UserModel?> getCurrentUserData() async {
    final u = _auth.currentUser;
    if (u == null) return null;
    final doc = await _db.collection('users').doc(u.uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }

  Future<void> updateUser(UserModel user) {
    return _db
        .collection('users')
        .doc(user.uid)
        .set(user.toMap(), SetOptions(merge: true));
  }

  Future<void> signOut() => _auth.signOut();
}