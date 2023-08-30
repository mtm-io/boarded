import 'package:boarded/core/constants/fade_indexed_stack.dart';
import 'package:boarded/tabs/home/screens/home_screen.dart';
import 'package:boarded/tabs/host/screens/host_page.dart';
import 'package:boarded/tabs/profile/screens/profile.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'core/constants/constants.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    HostPage(),
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: SafeArea(
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Pallete.blackColor,
                    Pallete.blackColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 1.2,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h, top: 3.h),
              child: BottomNavigationBar(
                elevation: 0,
                //unselectedItemColor: Color.fromRGBO(126, 123, 123, 1),
                //selectedItemColor: Colors.white,
                enableFeedback: false,
                backgroundColor: Colors.transparent,
                //changes background of Botton Navigation Bar
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedLabelStyle: const TextStyle(fontSize: 15),
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      Constants.host,
                      height: 25.sp,
                      width: 25.sp,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      Constants.home,
                      height: 25.sp,
                      width: 25.sp,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      Constants.profileV2,
                      height: 25.sp,
                      width: 25.sp,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    label: "",
                  )
                ],
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
