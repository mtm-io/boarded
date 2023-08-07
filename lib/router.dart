import 'package:boarded/tabs/auth/screens/sign_in_screen.dart';
import 'package:boarded/tabs/host/screens/create_room.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'bottom_nav.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: BottomNavigator()),
  '/create-room': (_) => const MaterialPage(child: CreateRoomScreen()),
});
