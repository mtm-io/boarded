import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';

/// Loader "page"
/// to call when waiting a responce from a Strem or Future Function
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Pallete.loaderColor,
      ),
    );
  }
}

void showDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const Loader(),
  );
}

void hideProgressDialogue(BuildContext context) {
  Navigator.of(context).pop(const Loader());
}
