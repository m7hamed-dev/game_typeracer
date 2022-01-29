class GameModel {
  GameModel({
    required this.gameID,
    required this.isJoin,
    required this.isOver,
    required this.players,
    required this.words,
  });

  final String gameID;
  final bool isJoin;
  final bool isOver;
  final List<PlayerModel> players;
  final List words;

  factory GameModel.fromJson(Map json) {
    return GameModel(
      gameID: json['_id'],
      isJoin: json['isJoin'],
      isOver: json['isOver'],
      players: json['players'],
      words: json['words'],
    );
  }
}

class PlayerModel {
  //
  final String socketID;
  final String playerID;
  final String nickname;
  final int currentWordIndex;
  final int WPM;
  final bool isPartyLeader;

  PlayerModel({
    required this.socketID,
    required this.playerID,
    required this.nickname,
    required this.currentWordIndex,
    required this.WPM,
    required this.isPartyLeader,
  });
  //
  factory PlayerModel.fromJson(Map json) {
    return PlayerModel(
      socketID: json['socketID'],
      playerID: json['playerID'],
      nickname: json['nickname'],
      currentWordIndex: json['currentWordIndex'],
      WPM: json['WPM'],
      isPartyLeader: json['isPartyLeader'],
    );
  }
}
