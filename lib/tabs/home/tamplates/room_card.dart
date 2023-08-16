import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/tabs/home/tamplates/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomCard extends ConsumerStatefulWidget {
  final List<String> images;
  final String title;
  final String time;
  final String place;
  final List<String> tags;

  const RoomCard({
    super.key,
    this.images = const [
      'https://pbs.twimg.com/media/D8dDZukXUAAXLdY.jpg',
      'https://pbs.twimg.com/profile_images/1249432648684109824/J0k1DN1T_400x400.jpg',
      'https://i0.wp.com/thatrandomagency.com/wp-content/uploads/2021/06/headshot.png?resize=618%2C617&ssl=1',
    ],
    required this.title,
    required this.time,
    required this.place,
    this.tags = const [],
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 14.w,
        left: 14.w,
        bottom: 6.h,
        top: 6.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(23.r),
          ),
          color: Color.fromRGBO(118, 188, 123, 1),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, top: 23.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.h),
                    child: MyText(
                      time,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 17.sp,
                        height: 1.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  MyText(
                    title,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      height: 1.sp,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.h),
                    child: MyText(
                      place,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 17.sp,
                        height: 1.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 16.h,
                ),
                child: Wrap(
                  spacing: 5.h,
                  runSpacing: 5.h,
                  children: [
                    for (int i = 0;
                        i < (tags.length < 5 ? tags.length : 5);
                        i++)
                      BoardedTag(tags[i]),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: 8.h,
                  left: 2.w,
                ),
                child: Row(
                  children: [
                    MyText(
                      "Players:   ",
                      style: TextStyle(
                        fontSize: 17.sp,
                        height: 1.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0;
                            i < (images.length < 3 ? images.length : 3);
                            i++)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            child: Align(
                              widthFactor: 0.6,
                              child: CircleAvatar(
                                radius: 17.sp,
                                backgroundColor:
                                    Color.fromRGBO(118, 188, 123, 1),
                                child: CircleAvatar(
                                  radius: 15.sp,
                                  backgroundImage: NetworkImage(
                                    images[i],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Align(
                          widthFactor: 0.6,
                          child: CircleAvatar(
                            radius: 17.sp,
                            backgroundColor: Color.fromRGBO(118, 188, 123, 1),
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(31, 0, 0, 0.12),
                              radius: 15.sp,
                              child: Padding(
                                padding: EdgeInsets.only(top: 2.8.h),
                                child: MyText(
                                  "+2",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    height: 1.sp,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10.w,
                      ),
                      child: SvgPicture.asset(
                        Constants.arrow,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
