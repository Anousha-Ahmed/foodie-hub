class Validators {
  static String? required(String? v, [String field = 'This field']) =>
      (v == null || v.trim().isEmpty) ? '$field is required' : null;

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone number is required';
    final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 10 || digits.length > 13) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Minimum 6 characters';
    return null;
  }

  static String? cardNumber(String? v) {
    final d = (v ?? '').replaceAll(' ', '');
    if (d.isEmpty) return 'Card number is required';
    if (d.length != 16) return 'Enter a 16-digit card number';
    return null;
  }

  static String? expiry(String? v) {
    if (v == null || v.isEmpty) return 'Required';
    final m = RegExp(r'^(\d{2})/(\d{4})$').firstMatch(v);
    if (m == null) return 'Use mm/yyyy';
    final month = int.parse(m.group(1)!);
    final year = int.parse(m.group(2)!);
    if (month < 1 || month > 12) return 'Invalid month';
    final now = DateTime.now();
    if (year < now.year || (year == now.year && month < now.month)) {
      return 'Card expired';
    }
    return null;
  }

  static String? cvv(String? v) {
    if (v == null || v.isEmpty) return 'Required';
    if (!RegExp(r'^\d{3,4}$').hasMatch(v)) return 'Invalid CVV';
    return null;
  }

  /// Firebase Auth ko email chahiye, is liye phone se fake email banate hain.
  static String phoneToEmail(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return '$digits@foodapp.com';
  }
}