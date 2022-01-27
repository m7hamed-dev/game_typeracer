import 'package:flutter/material.dart';
import 'package:game_typeracer/providers/game_state_provider.dart';
import 'package:game_typeracer/utils/socket_client.dart';
import 'package:game_typeracer/utils/socket_methods.dart';
import 'package:game_typeracer/widgets/btn.dart';
import 'package:provider/src/provider.dart';

import 'input.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  // controllers
  final _gameController = TextEditingController();
  final _nameController = TextEditingController();
  // sockert methods
  final _socketMethods = SocketMethods();
  //
  late GameStateProvider gameStateProvider;
  //
  void _hundlerStart() {
    _socketMethods.startTimer(
      _playerMe['_id'],
      gameStateProvider.gameState['id'],
    );
  }

  var _playerMe = null;
  //
  void _findPlayerMe(GameStateProvider game) {
    game.gameState['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket.id) {
        _playerMe = player;
      }
    });
  }

  //
  @override
  void initState() {
    super.initState();
    gameStateProvider = context.read<GameStateProvider>();
    _findPlayerMe(gameStateProvider);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameView page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Input(
              controller: _nameController,
              hint: 'nick name',
              onChange: (value) {},
            ),
            Btn(
              child: const Text('!!'),
              onPressed: () {},
            )
          ],
        ),
      ),
      bottomNavigationBar: GameTextField(onTap: _hundlerStart),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _gameController.dispose();
    _nameController.dispose();
  }
}

class GameTextField extends StatefulWidget {
  const GameTextField({Key? key, required this.onTap}) : super(key: key);
  final Function()? onTap;
  @override
  _GameTextFieldState createState() => _GameTextFieldState();
}

class _GameTextFieldState extends State<GameTextField> {
  @override
  Widget build(BuildContext context) {
    return Btn(
      onPressed: widget.onTap,
    );
  }
}
