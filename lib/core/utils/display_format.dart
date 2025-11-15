import 'package:intl/intl.dart';

class DisplayFormat {
  static String formatPrice(double? price) {
    final inrFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    String formattedPrice = inrFormat.format(price ?? 0);

    return formattedPrice;
  }
}
