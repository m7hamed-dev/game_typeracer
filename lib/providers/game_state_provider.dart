import 'package:flutter/material.dart';
import 'package:game_typeracer/models/game_state.dart';

class GameStateProvider extends ChangeNotifier {
  //
  GameState _gameState = GameState(
      id: '_id', isJoin: false, isOver: false, players: [], words: []);
  //
  Map<String, dynamic> get gameState => _gameState.toJson();
  //
  void updateGameState({
    required id,
    required isJoin,
    required isOver,
    required players,
    required words,
  }) {
    _gameState = GameState(
      id: id,
      isJoin: isJoin,
      isOver: isOver,
      players: players,
      words: words,
    );
    notifyListeners();
  }
}
