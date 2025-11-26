import 'package:flutter/widgets.dart';

extension DoubleExtensions on double {
  Widget toHeightGap() {
    return SizedBox(height: toDouble());
  }

  Widget toWidthGap() {
    return SizedBox(width: toDouble());
  }

  String get formattedPrice {
    String numberString = toInt().toString();
    String formattedNumber = numberString.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m.group(1)},',
    );
    return formattedNumber;
  }

  String get formattedIDRPrice {
    if (this < 1000) {
      return toString();
    }

    if (this < 1000000) {
      double rb = this / 1000;
      return "${rb.toStringAsFixed(rb % 1 == 0 ? 0 : 1)} rb";
    }

    double jt = this / 1000000;
    return "${jt.toStringAsFixed(jt % 1 == 0 ? 0 : 1)} jt";
  }

  String formatPercent() {
    return "${toStringAsFixed(2)}%";
  }
}
