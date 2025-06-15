import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

class CreateGameUseCase {
  final repository = injector.get<GameRepository>();

  Future<Game> call(Game game) async {
    return await repository.create(game);
  }
}
