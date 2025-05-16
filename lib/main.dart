import 'dart:developer';
import 'dart:io';

import 'package:boarded/models/user.dart';
import 'package:boarded/pages/entry_page.dart';
import 'package:boarded/providers/token_provider.dart';
import 'package:boarded/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final String baseUrl =
    Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: EntryPage());
  }
}
