import 'package:boarded/core/constants/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardedTag extends StatelessWidget {
  final String text;

  const BoardedTag(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50.r),
        ),
        color: Color.fromRGBO(31, 0, 0, 0.12),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          bottom: 6.h,
          left: 12.w,
          right: 12.w,
        ),
        child: MyText(
          text,
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 13.sp,
            height: 1.sp,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
