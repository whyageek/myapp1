import 'dart:async';
import 'package:intl/intl.dart';

class TimeUtils {
  static Stream<DateTime> getCurrentTimeStream() {
    return Stream.periodic(Duration(seconds: 1), (_) => DateTime.now());
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}
