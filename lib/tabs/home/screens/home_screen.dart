import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List RandomImages = [
    'https://pbs.twimg.com/media/D8dDZukXUAAXLdY.jpg',
    'https://pbs.twimg.com/profile_images/1249432648684109824/J0k1DN1T_400x400.jpg',
    'https://i0.wp.com/thatrandomagency.com/wp-content/uploads/2021/06/headshot.png?resize=618%2C617&ssl=1',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaOjCZSoaBhZyODYeQMDCOTICHfz_tia5ay8I_k3k&s'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Padding(
        padding: EdgeInsets.all(14.w),
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
                        "Today, 19:00 - 22:00",
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
                      "Exploding Kittens 18+",
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
                        "Mariupol, Ukraine",
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
                      BoardedTag("Munchkin"),
                      BoardedTag("Exploding Kittens"),
                      BoardedTag("Alias"),
                      BoardedTag("Just Chatting"),
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
                              i <
                                  (RandomImages.length < 3
                                      ? RandomImages.length
                                      : 3);
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
                                      RandomImages[i],
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
      ),
    );
  }
}

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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
