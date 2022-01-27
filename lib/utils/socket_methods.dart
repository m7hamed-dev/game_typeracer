import 'package:flutter/material.dart';
import 'package:game_typeracer/providers/game_state_provider.dart';
import 'package:game_typeracer/utils/push.dart';
import 'package:game_typeracer/utils/socket_client.dart';
import 'package:game_typeracer/views/game_view.dart';
import 'package:game_typeracer/views/join_room_view.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;
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
    // if (gameID.isNotEmpty && nickName.isNotEmpty) {
    _socketClient.emit(
      'timer',
      {'playerId': playerID, 'gameID': gameID},
    );
    // }
  }

  //61f23d9d5e8def5e472334ae
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
      if (data['_id'].isNotEmpty) {
        Push.to(context, const GameView());
      }
    });
  }

  void notCorrectGameListener(BuildContext context) {
    // listen event from server
    _socketClient.on('notCorrectGame', (data) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('$data'),
        ),
      );
    });
  }
}
