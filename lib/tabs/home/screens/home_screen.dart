import 'package:boarded/tabs/home/tamplates/room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<String> randomImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaOjCZSoaBhZyODYeQMDCOTICHfz_tia5ay8I_k3k&s'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: ListView(
          children: [
            const RoomCard(
              time: "Tomorrow, 7:00 - 22:00",
              title: 'Переможнi настолки у парку "Муромець"',
              place: "Kyiv, Ukraine",
              tags: [
                "Just Chatting",
                "Exploding Kittens",
                "Alias",
              ],
            ),
            RoomCard(
              images: randomImages,
              time: "Friday, 15:00 - 18:00",
              title: "Просто Настолки",
              place: "Kyiv, Ukraine",
              tags: [
                "Exploding Kittens",
                "Just Chatting",
                "Alias",
              ],
            ),
            RoomCard(
              images: randomImages,
              time: "Friday, 15:00 - 18:00",
              title: "Fuck You",
              place: "Kyiv, Ukraine",
            ),
          ],
        ));
  }
}
