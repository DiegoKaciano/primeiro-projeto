import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

class FetchStatusGamesUseCase {
  final repository = injector.get<GameRepository>();

  Future<int> call(int idConsole) async {
    return await repository.fetchStatus(idConsole);
  }
}
