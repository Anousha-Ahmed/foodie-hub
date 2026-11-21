class Formatters {
  /// 1500 -> "Rs 1,500"
  static String price(int value) {
    final s = value.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return 'Rs $s';
  }
}