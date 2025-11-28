import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.height,
    required this.width,
    this.baseColor,
    this.highlightColor,
    this.backgrounColor,
  });

  final double height;
  final double width;
  //
  final Color? baseColor;
  final Color? highlightColor;
  final Color? backgrounColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: backgrounColor ?? Colors.grey,
      ),
    );
  }
}
