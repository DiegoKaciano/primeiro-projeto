import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/console_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

class CreateConsoleUseCase {
  final repository = injector.get<ConsoleRepository>();

  Future<Console> call(Console console) async {
    return await repository.create(console);
  }
}
