import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jogos_zerados/app/domain/services/game_api_services.dart';

class RawgApiService implements GameApiServices {
  final String apiKey = 'd1e691b3634741d08984f6ee0778575a';

  @override
  Future<List> fetchGames(String searchQuery) async {
    searchQuery = searchQuery.trimRight();
    final response = await http.get(
      Uri.parse(
          'https://api.rawg.io/api/games?key=$apiKey&search=$searchQuery'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Falha ao carregar jogos');
    }
  }
}
