import 'package:flutter/widgets.dart';

extension IntExtensions on int {
  Widget toHeightGap() {
    return SizedBox(height: toDouble());
  }

  Widget toWidthGap() {
    return SizedBox(width: toDouble());
  }

  String toTimeDescription() {
    final years = this ~/ 12;
    final months = this % 12;

    final yearString = years > 0 ? '$years year${years > 1 ? 's' : ''}' : '';
    final monthString = months > 0 ? '$months mo${months > 1 ? 's' : ''}' : '';

    if (years > 0 && months > 0) {
      return '$yearString $monthString';
    } else if (years > 0) {
      return yearString;
    } else if (months > 0) {
      return monthString;
    } else {
      return 'Less than a month';
    }
  }

  DateTime? unixToDateTime() {
    try {
      return DateTime.fromMillisecondsSinceEpoch(this * 1000);
    } catch (error) {
      return null;
    }
  }

  String toFormattedNumber() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
