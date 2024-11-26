import 'package:corporatica_task/widgets/tappable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  static final backButtonLeadingWidth = 16.spMin + 15.spMin;

  @override
  Widget build(BuildContext context) {
    return TappableWidget(
      onTap: () => Navigator.of(context).maybePop(),
      child: Padding(
        padding: EdgeInsets.only(left: 16.spMin),
        child: SvgPicture.asset(
          "assets/backButton.svg",
        ),
      ),
    );
  }
}
