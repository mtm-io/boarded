// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/tabs/home/tamplates/tag.dart';

class RoomCard extends ConsumerStatefulWidget {
  final List<String> images;
  final String title;
  final String time;
  final String place;
  final List<String> tags;
  final void Function()? onArrowTap;
  final int cardColorNum;

  const RoomCard({
    super.key,
    this.images = const [],
    required this.title,
    required this.time,
    required this.place,
    required this.cardColorNum,
    this.tags = const [],
    this.onArrowTap,
  });

  @override
  ConsumerState<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends ConsumerState<RoomCard> {
  late List<String> images = widget.images;
  late List<String> tags = widget.tags;
  late String title = widget.title;
  late String time = widget.time;
  late String place = widget.place;
  late Function()? onArrowTap = widget.onArrowTap;
  late int cardColorNum = widget.cardColorNum;
  late Color cardColor = Constants.cardColors[cardColorNum];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 14.w,
        left: 14.w,
        bottom: 6.h,
        top: 6.h,
      ),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(23.r),
            ),
            color: cardColor,
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 23.w, top: 23.h, right: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.sp),
                        child: MyText(
                          time,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 17.sp,
                            height: 1.sp,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.sp),
                        child: MyText(
                          title,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 23.sp,
                            height: 1.sp,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      MyText(
                        place,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 17.sp,
                          height: 1.sp,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: 16.h,
                  ),
                  child: Wrap(
                    spacing: 5.h,
                    runSpacing: 5.h,
                    children: [
                      if (tags.length <= 5)
                        for (int i = 0; i < tags.length; i++)
                          BoardedTag(tags[i]),
                      if (tags.length > 5) ...[
                        for (int i = 0; i < 5; i++) BoardedTag(tags[i]),
                        BoardedTag("+${tags.length - 5}"),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 2.w,
                  ),
                  child: Row(
                    children: [
                      images.isEmpty
                          ? const SizedBox()
                          : MyText(
                              "Players:   ",
                              style: TextStyle(
                                fontSize: 17.sp,
                                height: 1.sp,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                      if (images.isEmpty)
                        MyText(
                          "Be the first to join!",
                          style: TextStyle(
                            fontSize: 17.sp,
                            height: 1.sp,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                      if (images.length <= 3 && images.isNotEmpty)
                        for (int i = 0; i < images.length; i++)
                          PlayerImage(image: images[i], color: cardColor),
                      if (images.length > 3) ...[
                        for (int i = 0; i < 3; i++)
                          PlayerImage(image: images[i], color: cardColor),
                        Align(
                          widthFactor: 0.6,

                          child: CircleAvatar(
                            radius: 17.sp,
                            backgroundColor: cardColor,
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(31, 0, 0, 0.12),
                              radius: 15.sp,
                              child: Padding(
                                padding: EdgeInsets.only(top: 2.8.h),
                                child: MyText(
                                  "+${images.length - 3}",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    height: 1.sp,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: GestureDetector(
                          onTap: () => onArrowTap!(),
                          child: SvgPicture.asset(
                            Constants.arrow,
                            width: 60.sp,
                            height: 60.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}

class PlayerImage extends StatelessWidget {
  final String image;
  final Color color;

  const PlayerImage({
    Key? key,
    required this.color,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.6,
      child: CircleAvatar(
        radius: 17.sp,
        backgroundColor: color,
        child: CircleAvatar(
          radius: 15.sp,
          backgroundImage: NetworkImage(
            image,
          ),
        ),
      ),
    );
  }
}
