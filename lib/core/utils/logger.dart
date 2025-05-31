import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';

class Logger {
  static const _bold = '\x1B[1m';
  static const _reset = '\x1B[0m';
  static const _green = '\x1B[32m';
  static const _yellow = '\x1B[33m';
  static const _red = '\x1B[31m';
  static const _blue = '\x1B[34m';

  static bool haveTime = true;

  static void info(Object? message) => _log('INFO', message, _green);

  static void warning(Object? message) => _log('WARN', message, _yellow);

  static void error(Object? message) => _log('ERROR', message, _red);

  static void debug(Object? message) => _log('DEBUG', message, _blue);

  //for error/failures classes
  static void failure(Object? message, String? level) =>
      _log(level ?? 'FAILURE', message, _red);

  static void _log(String level, Object? message, String color) {
    final now = DateFormat(DateFormat.HOUR_MINUTE).format(DateTime.now());
    final time = '$_yellow[$_reset $_bold$color$now$_reset $_yellow]$_reset';
    final logLine =
        '${haveTime ? time : ''} $color${_stringify(message, color)}'.trim();

    log(
      logLine,
      name: ' $_bold$color$level$_reset ',
    );
  }

  static String _stringify(Object? message, String color) {
    if ((message is Map || message is List || message is Set) &&
        !isFlatJson(message)) {
      const encoder = JsonEncoder.withIndent('  ');
      try {
        final formatted = '\n${encoder.convert(message)}';
        final lines = formatted.split('\n');
        final colored = lines.map((line) => '$color$line$_red').join('\n');
        return colored;
        // return '\n${encoder.convert(message)}';
      } catch (_) {
        return message.toString();
      }
    }
    return message.toString();
  }

  static bool isFlatJson(Object? data) {
    if (data == null) {
      return true;
    }
    if (data is Map) {
      return data.values
          .every((value) => value is! Map && value is! List && value is! Set);
    } else if (data is List) {
      return data.every(
          (element) => element is! Map && element is! List && element is! Set);
    } else if (data is Set) {
      return data.every(
          (element) => element is! Map && element is! List && element is! Set);
    }

    return false;
  }
}
