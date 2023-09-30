import 'package:boarded/tabs/auth/screens/sign_in_screen.dart';
import 'package:boarded/tabs/rooms/screens/create_room.dart';
import 'package:boarded/tabs/rooms/screens/edit_room_screen.dart';
import 'package:boarded/tabs/rooms/screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'bottom_nav.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: BottomNavigator()),
  '/create-room': (_) => const MaterialPage(child: CreateRoomScreen()),
  '/room/:name': (route) => MaterialPage(
        child: RoomScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/edit-room/:name': (routeData) => MaterialPage(
        child: EditRoomScreen(
          id: routeData.pathParameters['name']!,
        ),
      ),
});
