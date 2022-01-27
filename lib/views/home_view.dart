import 'package:flutter/material.dart';
import 'package:game_typeracer/utils/push.dart';
import 'package:game_typeracer/views/create_room_view.dart';
import 'package:game_typeracer/views/join_room_view.dart';
import 'package:game_typeracer/widgets/btn.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Btn(
              child: const Text('create room'),
              onPressed: () {
                Push.to(context, const CreateRoomView());
              },
            ),
            Btn(
              child: const Text('join room'),
              onPressed: () {
                Push.to(context, const JoinRoomView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
