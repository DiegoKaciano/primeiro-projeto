import 'package:jogos_zerados/app/domain/usecases/fetch_status_games_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';

class GameFetcherStatus {
  final fetchGamesUseCase = injector.get<FetchStatusGamesUseCase>();

  Future<String> fetchStatus(int idConsole) async {
    final total = await fetchGamesUseCase.call(idConsole);
    return total.toString();
  }
}