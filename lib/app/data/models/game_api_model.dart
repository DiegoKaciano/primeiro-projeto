import 'package:jogos_zerados/app/core/database_constants.dart';

class GameApiModel {
  final int id;
  final String name;
  final String? released;
  final String? urlImage;
  final double rating;
  final int playtime;
  final List<String> platforms;
  final List<String> genres;

  GameApiModel({
    required this.id,
    required this.name,
    required this.released,
    required this.urlImage,
    required this.rating,
    required this.playtime,
    required this.platforms,
    required this.genres,
  });

  factory GameApiModel.fromMap(Map map) {
    List<dynamic> genres = map['genres'];
    List<String> genreNames = genres.map((genre) => genre['name'] as String).toList();

    List<dynamic> platforms = map['platforms'];
    List<String> platformNames = platforms
        .map((platform) => platform['platform']['name'] as String)
        .toList();
    return GameApiModel(
      id: map[kId],
      name: map[kName],
      released: map[kReleased] ?? '',
      rating: map[kRating],
      platforms: platformNames,
      urlImage: map[kBackgroundImage] ?? '',
      playtime: map[kPlaytime],
      genres: genreNames,
    );
  }
}
