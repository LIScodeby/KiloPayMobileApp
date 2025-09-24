// lib/core/utils/date_utils.dart
import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatShort(DateTime d) => DateFormat('dd.MM').format(d);
  static String formatMonthDay(DateTime d) => DateFormat('d MMM', 'ru').format(d);
  static String formatFull(DateTime d) =>
      DateFormat('dd.MM.yyyy HH:mm', 'ru').format(d);
}
