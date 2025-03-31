import 'dart:io';

import 'package:intl/intl.dart';

class DateUtils {
  /// Formattazione data DateTime in data-ora Stringa
  static String timeFormated(String? time) {
    final DateTime now = time == null
        ? DateTime.now().toLocal()
        : DateTime.parse(time).toLocal();
    final DateFormat formatter =
        DateFormat('yyyy-MM-dd HH:mm:ss', Platform.localeName);
    return formatter.format(now);
  }

  /// Formattazione data DateTime in data Stringa
  static String dataFormattata(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  /// Formattazione data DateTime in data-ora Stringa
  static String dataOraFormattata(DateTime data) {
    return DateFormat('dd/MM/yyyy HH:mm').format(data);
  }

  /// Conversione data da formato CARL a formato DateTime corretto
  static DateTime? conversioneDataCarlFormatDateTime(String? data) {
    return data == null ? null : DateTime.parse(data).toLocal()
        // TODO: da capire se togliere definitivamente perchè così le ore tornano
        // .add(
        //       Duration(
        //         hours: -int.parse(
        //           data.substring(data.length - 6).substring(0, 3),
        //         ),
        //         minutes: -int.parse(
        //           data.substring(data.length - 6).substring(4),
        //         ),
        //       ),
        //     )
        ;
  }

  /// Conversione data DateTime in stringa con formato CARL
  static String? conversioneDataDateTimeCarlFormat(DateTime? data) {
    return data == null
        ? null
        : "${data.add(const Duration(hours: -2)).toIso8601String().substring(0, 23)}+00:00";
  }

  /// Funzione per sapere se la data è in giornata
  static bool isToday(DateTime? date) {
    final now = DateTime.now();
    if (date == null) return false;
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
