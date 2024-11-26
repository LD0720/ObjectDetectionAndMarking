import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Divider extends StatelessWidget {
  const Divider(
      {super.key,
      this.height,
      this.indent,
      this.endIndent,
      this.thickness,
      this.color});
  final double? height;
  final double? indent;
  final double? endIndent;
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.grey.withOpacity(0.2),
      height: height ?? 1.spMin,
      endIndent: endIndent ?? 0.spMin,
      indent: indent ?? 0.spMin,
      thickness: thickness ?? 1.spMin,
    );
  }
}
