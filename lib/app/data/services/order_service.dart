import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_item_model.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> placeOrder({
    required String orderId,
    required List<CartItemModel> items,
    required int subtotal,
    required int deliveryCharges,
    required int total,
    required String address,
    required String instructions,
    required String paymentMethod,
  }) async {
    await _db.collection('orders').doc(orderId).set({
      'orderId': orderId,
      'uid': _auth.currentUser?.uid,
      'items': items
          .map((e) => {
                'name': e.item.name,
                'price': e.item.price,
                'quantity': e.quantity.value,
                'total': e.total,
              })
          .toList(),
      'subtotal': subtotal,
      'deliveryCharges': deliveryCharges,
      'total': total,
      'address': address,
      'instructions': instructions,
      'paymentMethod': paymentMethod,
      'status': 'placed',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}