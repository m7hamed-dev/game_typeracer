class GameState {
  final String id;
  final bool isJoin;
  final bool isOver;
  final List players;
  final List words;

  GameState({
    required this.id,
    required this.isJoin,
    required this.isOver,
    required this.players,
    required this.words,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isJoin': isJoin,
      'isOver': isOver,
      'players': players,
      'words': words,
    };
  }
}
