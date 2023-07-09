import 'package:flutter/material.dart';

/// Loader "page"
/// to call when waiting a responce from a Strem or Future Function
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
