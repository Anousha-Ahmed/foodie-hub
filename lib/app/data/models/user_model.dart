class UserModel {
  final String uid;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'fullName': fullName,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
      };

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
        uid: m['uid'] ?? '',
        fullName: m['fullName'] ?? '',
        phone: m['phone'] ?? '',
        address: m['address'] ?? '',
        city: m['city'] ?? '',
        state: m['state'] ?? '',
        zipCode: m['zipCode'] ?? '',
        country: m['country'] ?? '',
      );
}
