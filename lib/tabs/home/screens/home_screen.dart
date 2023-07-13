import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w600);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              return context.go('/login');
            },
            child: const Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.watch(authControllerProvider).signOut();
            },
            child: const Text("Sign Out"),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          hoverColor: Colors.grey[800]!,
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[900]!,
          padding: EdgeInsets.all(16.0),
          iconSize: 44,
          textStyle: optionStyle,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.dice,
              gap: 20,
              text: 'Host',
              onPressed: () {
                return context.go('/');
              },
            ),
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: 'Find',
              gap: 8,
              onPressed: () {
                return context.go('/');
              },
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
              if (_selectedIndex == 2) {
                context.go('/profile');
              }
            });
          },
        ),
      ),
    );
  }
}
