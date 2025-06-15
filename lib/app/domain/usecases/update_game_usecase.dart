import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

class UpdateGameUseCase {
  final repository = injector.get<GameRepository>();

  Future<void> call(Game game) async {
    await repository.update(game);
  }
}
