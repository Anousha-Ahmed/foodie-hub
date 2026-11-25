class AddressModel {
  final String id;
  final String type; 
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final int createdAt;

  const AddressModel({
    this.id = '',
    required this.type,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'type': type,
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
        'createdAt': createdAt,
      };

  factory AddressModel.fromMap(String id, Map<String, dynamic> m) =>
      AddressModel(
        id: id,
        type: m['type'] ?? '',
        address: m['address'] ?? '',
        city: m['city'] ?? '',
        state: m['state'] ?? '',
        zipCode: m['zipCode'] ?? '',
        country: m['country'] ?? '',
        createdAt: (m['createdAt'] as num?)?.toInt() ?? 0,
      );

  String get fullText => [address, city, state, zipCode, country]
      .where((e) => e.trim().isNotEmpty)
      .join(', ');
}