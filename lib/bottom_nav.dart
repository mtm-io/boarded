import 'package:boarded/tabs/home/screens/home_screen.dart';
import 'package:boarded/tabs/host/screens/host_page.dart';
import 'package:boarded/tabs/profile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          hoverColor: Colors.grey[800]!,
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[900]!,
          padding: EdgeInsets.all(20.0),
          iconSize: 30,
          textStyle: optionStyle,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.dice,
              gap: 20,
              text: 'Host',
            ),
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: 'Find',
              gap: 8,
            ),
            GButton(
              icon: FontAwesomeIcons.user,
              text: 'Profile',
              gap: 8,
            )
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(_selectedIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear);
            });
          },
        ),
      ),
    );
  }
}
