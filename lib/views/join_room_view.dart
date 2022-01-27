import 'package:flutter/material.dart';
import 'package:game_typeracer/utils/socket_methods.dart';
import 'package:game_typeracer/widgets/btn.dart';

import 'input.dart';

class JoinRoomView extends StatefulWidget {
  const JoinRoomView({Key? key}) : super(key: key);

  @override
  State<JoinRoomView> createState() => _JoinRoomViewState();
}

class _JoinRoomViewState extends State<JoinRoomView> {
  final _gameController = TextEditingController();
  final _nameController = TextEditingController();
  final _socketMethods = SocketMethods();
  //
  @override
  void initState() {
    super.initState();
    _socketMethods.updateGameListener(context);
    _socketMethods.notCorrectGameListener(context);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JoinRoomView page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Join Room'),
            const SizedBox(height: 20.0),
            Input(
              controller: _nameController,
              hint: 'nick name',
              onChange: (value) {},
            ),
            Input(
              controller: _gameController,
              hint: 'game ID',
              onChange: (value) {},
            ),
            Btn(
              child: const Text('Join'),
              onPressed: () => _socketMethods.joinGame(
                  _gameController.text, _nameController.text),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _gameController.dispose();
    _nameController.dispose();
  }
}
