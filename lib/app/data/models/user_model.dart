class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String photoBase64;

  UserModel({
    required this.uid,
    required this.fullName,
    this.email = '',
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.photoBase64 = '',
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
        'photoBase64': photoBase64,
      };

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
        uid: m['uid'] ?? '',
        fullName: m['fullName'] ?? '',
        email: m['email'] ?? '',
        phone: m['phone'] ?? '',
        address: m['address'] ?? '',
        city: m['city'] ?? '',
        state: m['state'] ?? '',
        zipCode: m['zipCode'] ?? '',
        country: m['country'] ?? '',
        photoBase64: m['photoBase64'] ?? '',
      );
}