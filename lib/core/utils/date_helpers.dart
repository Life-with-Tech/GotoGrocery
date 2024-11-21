import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DateHelpers {
  static String formatDate(String? date) {
    if (date != "" && date != null && date.isNotEmpty) {
      final formateData = DateTime.parse(date!);
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(formateData);
    }
    return date.toString();
  }

  static DateTime parseDate(String dateStr) {
    return DateTime.parse(dateStr);
  }

  static final Uuid _uuid = Uuid();
  static String generateUID() {
    return _uuid.v4();
  }
}
