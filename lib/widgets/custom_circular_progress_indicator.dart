import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator(
      {this.width,
      this.height,
      this.backgroundColor,
      this.color,
      this.strokeWidth,
      super.key});
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? color;
  final double? strokeWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? width : 40.spMin,
      height: height != null ? height : 40.spMin,
      child: Center(
        child: CustomCircularProgressIndicator(
          backgroundColor:
              backgroundColor != null ? backgroundColor : Colors.white30,
          color: color != null ? color : Colors.deepPurple,
          strokeWidth: strokeWidth != null ? strokeWidth! : 3.spMin,
        ),
      ),
    );
  }
}
