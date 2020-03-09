import 'package:intl/intl.dart';

class FormatterUtils {
  static String date(int time) {
    if (time <= 0) {
      return "";
    }
    DateFormat format = DateFormat("yyyy/MM/dd");
    return format.format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
  }
}
