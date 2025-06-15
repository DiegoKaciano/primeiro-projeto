import 'package:jogos_zerados/app/domain/entities/console_entity.dart';

class Game {
  final int? id;
  final String title;
  final List<String> genres;
  final String namePlatform;
  final List<String> platforms;
  final Console console;
  final String gameState;
  final String urlImage;
  final DateTime startDate;
  final DateTime completionDate;
  final bool isFinished;
  final int rating;
  final String notes;

  Game({
    this.id,
    required this.title,
    required this.genres,
    required this.namePlatform,
    required this.platforms,
    required this.console,
    required this.gameState,
    required this.urlImage,
    required this.startDate,
    required this.completionDate,
    required this.isFinished,
    required this.rating,
    required this.notes,
  });
}