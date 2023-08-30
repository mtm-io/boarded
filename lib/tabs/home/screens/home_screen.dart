import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/tabs/home/tamplates/room_card.dart';
import 'package:boarded/tabs/home/tamplates/search_tag.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:boarded/core/common/anim_searchbar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<String> randomImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaOjCZSoaBhZyODYeQMDCOTICHfz_tia5ay8I_k3k&s',
    'https://imgv3.fotor.com/images/cover-photo-image/a-beautiful-girl-with-gray-hair-and-lucxy-neckless-generated-by-Fotor-AI.jpg',
    'https://pixlr.com/images/index/remove-bg.webp',
    'https://images.pexels.com/photos/4154191/pexels-photo-4154191.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ];
  TextEditingController textController = TextEditingController();
  bool _isOpen = false;
  bool _isBellOpen = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height), // Set this height
            child: Container(
              decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                      Pallete.blackColor,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.w),
                          child: _isOpen
                              ? const SizedBox(width: 0)
                              : MyText(
                                  "Search",
                                  style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
                                ),
                        ),
                        Spacer(),
                        _isBellOpen
                            ? const SizedBox(width: 0)
                            : Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: SvgPicture.asset(
                                  Constants.notify,
                                  height: 20.sp,
                                  width: 20.sp,
                                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(right: 14.w),
                          child: SafeArea(
                            child: ClipRect(
                              child: AnimSearchBar(
                                height: 45.h,
                                searchBarOpen: (isOpen) {
                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    setState(() {
                                      if (isOpen == 1) {
                                        _isOpen = true;
                                      } else {
                                        _isOpen = false;
                                      }
                                    });
                                  });

                                  setState(() {
                                    if (isOpen == 1) {
                                      _isBellOpen = true;
                                    } else {
                                      Future.delayed(const Duration(milliseconds: 130), () {
                                        setState(() {
                                          _isBellOpen = false;
                                        });
                                      });
                                    }
                                  });
                                },
                                width: MediaQuery.of(context).size.width - 28.w,
                                textController: textController,
                                onSuffixTap: () {
                                  //setState(() {
                                  // textController.clear();
                                  // });
                                },
                                onSubmitted: (text) {
                                  print(text);
                                },
                                autoFocus: false,
                                style: TextStyle(fontSize: 17.sp, color: Pallete.whiteColor),
                                textFieldColor: Pallete.blackColor,
                                searchIconColor: Pallete.whiteColor,
                                color: Pallete.blackColor,
                                textFieldIconColor: Pallete.whiteColor,
                                rtl: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h, left: 3.w, top: 10.h),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SearchTag("Kyiv", Constants.city),
                            SearchTag("Anytime", Constants.time),
                            SearchTag("3", Constants.number),
                            SearchTag("Anything", Constants.category),
                            SearchTag("Offline", Constants.online),
                            SearchTag("Language", Constants.language),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              RoomCard(
                time: "Tomorrow, 7:00 - 22:00",
                title: 'Board Games English Club',
                place: "Kyiv, Ukraine",
                tags: [
                  "Just Chatting",
                  "Exploding Kittens",
                  "Alias",
                ],
                cardColorNum: 1,
              ),
              RoomCard(
                images: randomImages,
                time: "Friday, 15:00 - 18:00",
                title: "Просто Настолки",
                place: "Mariupol, Ukraine",
                tags: [
                  "Exploding Kittens",
                  "Just Chatting",
                  "Alias",
                ],
                cardColorNum: 2,
              ),
              RoomCard(
                images: randomImages,
                time: "Friday, 15:00 - 18:00",
                title: "Настолки на набережній",
                place: "Obolonska Naberezhna Street, 20, Kyiv, Ukraine",
                tags: [
                  "Exploding Kittens",
                  "Just Chatting",
                  "Mafia",
                  "Alias",
                  "Jaust Chilling",
                  "Soap",
                ],
                cardColorNum: 3,
              ),
            ],
          )),
    );
  }
}
