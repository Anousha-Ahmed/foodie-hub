class Formatters {
  /// 1500 -> "Rs 1,500"
  static String price(int value) {
    final s = value
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return 'Rs $s';
  }

  static String orderedAt(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'
    ];
    final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final m = d.minute.toString().padLeft(2, '0');
    final ap = d.hour >= 12 ? 'pm' : 'am';
    return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]}, $h:$m$ap';
  }
}