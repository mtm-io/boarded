import 'package:boarded/tabs/home/screens/home_screen.dart';
import 'package:boarded/tabs/host/screens/host_page.dart';
import 'package:boarded/tabs/profile/screens/profile.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'core/constants/constants.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 1;

  final _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HostPage(),
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          controller: _pageController,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              //unselectedItemColor: Color.fromRGBO(126, 123, 123, 1),
              //selectedItemColor: Colors.white,
              enableFeedback: false,
              backgroundColor: const Color.fromARGB(255, 12, 12,
                  12), //changes background of Botton Navigation Bar
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedLabelStyle: const TextStyle(fontSize: 15),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Constants.diceD20,
                    height: 45.sp,
                    width: 45.sp,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Constants.compas,
                    height: 45.sp,
                    width: 40.sp,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  label: "",
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Constants.avatar,
                    height: 45.sp,
                    width: 45.sp,
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
                  _pageController.animateToPage(_selectedIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
