import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String name;
  final String image;
  final int price;
  final int quantity;
  const OrderItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

class OrderModel {
  final String orderId;
  final List<OrderItem> items;
  final int total;
  final String status;
  final DateTime createdAt;
  final int expectedMins;

  const OrderModel({
    required this.orderId,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.expectedMins,
  });

  factory OrderModel.fromMap(Map<String, dynamic> m) {
    final rawItems = (m['items'] as List?) ?? [];
    return OrderModel(
      orderId: m['orderId'] ?? '',
      items: rawItems
          .map((e) => OrderItem(
                name: e['name'] ?? '',
                image: e['image'] ?? '',
                price: (e['price'] as num?)?.toInt() ?? 0,
                quantity: (e['quantity'] as num?)?.toInt() ?? 1,
              ))
          .toList(),
      total: (m['total'] as num?)?.toInt() ?? 0,
      status: m['status'] ?? 'placed',
      createdAt: (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      expectedMins: (m['expectedMins'] as num?)?.toInt() ?? 20,
    );
  }

  int get itemCount => items.fold(0, (sum, e) => sum + e.quantity);

  bool get isOngoing =>
      status != 'delivered' &&
      DateTime.now().difference(createdAt).inMinutes < 30;

  String get dateText {
    String t(int n) => n.toString().padLeft(2, '0');
    return '${t(createdAt.day)}-${t(createdAt.month)}-${createdAt.year}';
  }
}