import 'package:intl/intl.dart';

class DateHelpers {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static DateTime parseDate(String dateStr) {
    return DateTime.parse(dateStr);
  }
}
