import 'dart:developer';

import 'package:boarded/models/card.dart';
import 'package:boarded/models/user.dart';
import 'package:boarded/providers/cards_provider.dart';
import 'package:boarded/providers/user_provider.dart';
import 'package:boarded/ui/l_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  final UserModel user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, ref) {
    AsyncValue<List<CardModel?>> cards = ref.watch(cardsControllerProvider);
    return Scaffold(
      body: Center(
        child: cards.when(
          data:
              (data) => Column(
                children:
                    data
                        .map(
                          (e) => LCard(
                            title: e?.title ?? "",
                            startDate: e?.startDate,
                            isActive: e?.isActive ?? false,
                          ),
                        )
                        .toList(),
              ),
          error: (error, stack) {
            log('CardsController error: $error');
            return const Scaffold(
              body: Center(child: Text('Oops, something unexpected happened')),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
