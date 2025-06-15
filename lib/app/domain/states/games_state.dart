import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';

class GamesState extends ChangeNotifier {
  List<Game> _games = [];

  List<Game> get games => _games;

  void setGames(List<Game> value) {
    _games = value;
    notifyListeners();
  }
}
