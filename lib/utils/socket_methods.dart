import 'package:flutter/material.dart';
import 'package:game_typeracer/providers/client_state_provider.dart';
import 'package:game_typeracer/providers/game_state_provider.dart';
import 'package:game_typeracer/utils/push.dart';
import 'package:game_typeracer/utils/socket_client.dart';
import 'package:game_typeracer/views/game_view.dart';
import 'package:game_typeracer/views/join_room_view.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;
  bool _isPlaying = false;
  // emit event to server
  void createGame(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.emit('create-game', {'nickname': nickName});
    }
  }

  // emit event to server
  void joinGame(String gameID, String nickName) {
    if (gameID.isNotEmpty && nickName.isNotEmpty) {
      _socketClient.emit(
        'join-game',
        {'gameID': gameID, 'nickname': nickName},
      );
    }
  }

  void startTimer(String playerID, String gameID) {
    _socketClient.emit(
      'timer',
      {'playerId': playerID, 'gameID': gameID},
    );
  }

  void sendUserInput(String value, String gameID) {
    _socketClient.emit(
      'userInput',
      {'userInput': value, 'gameID': gameID},
    );
  }

  // listenrs event from server
  void updateGameListener(BuildContext context) {
    // listen event from server
    _socketClient.on('updateGame', (data) {
      final _gameStateProvider = context.read<GameStateProvider>();
      //
      _gameStateProvider.updateGameState(
        id: data['_id'],
        isJoin: data['isJoin'],
        isOver: data['isOver'],
        players: data['players'],
        words: data['words'],
      );
      if (data['_id'].isNotEmpty && !_isPlaying) {
        Push.to(context, const GameView());
        _isPlaying = true;
      }
    });
  }

  void notCorrectGameListener(BuildContext context) {
    _socketClient.on('notCorrectGame', (data) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('$data'),
        ),
      );
    });
  }

  void updateTimeListener(BuildContext context) {
    final _clientStateProvidr = context.read<ClientStateProvider>();
    _socketClient.on('timer', (date) {
      _clientStateProvidr.setClientState(date);
    });
  }
}
