import 'package:flutter/material.dart';
import 'package:game_typeracer/providers/game_state_provider.dart';
import 'package:game_typeracer/utils/socket_client.dart';
import 'package:game_typeracer/utils/socket_methods.dart';
import 'package:provider/src/provider.dart';

class SentenceGame extends StatefulWidget {
  const SentenceGame({Key? key}) : super(key: key);

  @override
  _SentenceGameState createState() => _SentenceGameState();
}

class _SentenceGameState extends State<SentenceGame> {
  Map _playerMe = {};

  final _socketMethods = SocketMethods();
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
    _socketMethods.updateGameListener(context);
  }

  // three -> typed words , current word , words to be typed
  // 1 typed words
  Widget _getTypedWords(List words, Map player) {
    var _tempWords = words.sublist(0, player['currentWordIndex']);
    String _typedWord = '';
    _typedWord = _tempWords.join(' ');
    //
    return Text(
      _typedWord,
      style: const TextStyle(
        fontSize: 16.0,
        color: Color.fromRGBO(52, 235, 119, 1),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    final _gameStateProvider = context.watch<GameStateProvider>();
    _findPlayerMe(_gameStateProvider);
    //
    return Container(
      child: _getTypedWords(
        _gameStateProvider.gameState['words'],
        _playerMe,
      ),
    );
  }
}
