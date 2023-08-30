import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class SearchTag extends StatelessWidget {
  final String text;
  final String icon;

  const SearchTag(
    this.text,
    this.icon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.whiteColor),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
        child: Row(
          children: [
            if (icon == Constants.language) ...[
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: SvgPicture.asset(
                  icon,
                  height: 20.sp,
                  width: 20.sp,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ] else if (icon == Constants.online) ...[
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: SvgPicture.asset(
                  icon,
                  height: 20.sp,
                  width: 20.sp,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ] else if (icon == Constants.number) ...[
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: SvgPicture.asset(
                  icon,
                  height: 15.sp,
                  width: 15.sp,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ] else
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: SvgPicture.asset(
                  icon,
                  height: 17.sp,
                  width: 17.sp,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: 6.h,
                left: 6.w,
                right: 12.w,
              ),
              child: MyText(
                text,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 17.sp,
                  height: 1.sp,
                  color: Pallete.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
