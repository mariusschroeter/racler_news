import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    return timeago.format(dateTime, locale: locale);
  }
  return DateFormat(format).format(dateTime);
}
