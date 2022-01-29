import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_typeracer/providers/client_state_provider.dart';
import 'package:game_typeracer/providers/game_state_provider.dart';
import 'package:game_typeracer/utils/socket_client.dart';
import 'package:game_typeracer/utils/socket_methods.dart';
import 'package:game_typeracer/widgets/btn.dart';
import 'package:game_typeracer/widgets/sentence_game.dart';
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
  @override
  void initState() {
    super.initState();
    _socketMethods.updateTimeListener(context);
  }

  //
  @override
  Widget build(BuildContext context) {
    final _gameStateProvider = context.watch<GameStateProvider>();
    final _clientStateProvidr = context.watch<ClientStateProvider>();
    //
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
            // part copy game id
            _gameStateProvider.gameState['isJoin']
                ? Btn(
                    child: const Text('Click Here To Copy'),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: _gameStateProvider.gameState['id'].toString(),
                      )).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Game ID Copied !!')),
                        );
                      });
                    },
                  )
                : const SizedBox(),
            const SizedBox(height: 40.0),
            Text('${_clientStateProvidr.clientState['timer']['msg']}'),
            Text('${_clientStateProvidr.clientState['timer']['countDown']}'),
            const SizedBox(height: 20.0),
            const SentenceGame(),
            const SizedBox(height: 20.0),
            Input(
              controller: _nameController,
              hint: 'nick name',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GameTextField(),
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
  const GameTextField({Key? key}) : super(key: key);
  @override
  _GameTextFieldState createState() => _GameTextFieldState();
}

class _GameTextFieldState extends State<GameTextField> {
  bool _isBtn = true;
  //
  late GameStateProvider gameStateProvider;
  // sockert methods
  final _socketMethods = SocketMethods();
  //
  void _hundlerStart() {
    _socketMethods.startTimer(
        _playerMe['_id'], gameStateProvider.gameState['id']);
    //
    setState(() {
      _isBtn = false;
    });
  }

  var _playerMe = {};
  //
  void _findPlayerMe(GameStateProvider game) {
    game.gameState['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket.id) {
        _playerMe = player;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    gameStateProvider = context.read<GameStateProvider>();
    _findPlayerMe(gameStateProvider);
  }

  final _wordsController = TextEditingController();
  //
  void _hundleTextChange(String value, String gameID) {
    String _lastChar = value[value.length - 1];
    if (_lastChar == ' ') {
      _socketMethods.sendUserInput(value, gameID);
      _wordsController.text = '';
      setState(() {});
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    final _gameStateProvider = context.watch<GameStateProvider>();
    return _playerMe['isPartyLeader'] && _isBtn
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Btn(
              onPressed: _hundlerStart,
              child: const Text('start game'),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Input(
              readOnly: _gameStateProvider.gameState['isJoin'],
              controller: _wordsController,
              hint: 'Type Here !!',
              onChange: (value) {
                _hundleTextChange(value, _gameStateProvider.gameState['id']);
              },
            ),
          );
  }
}
