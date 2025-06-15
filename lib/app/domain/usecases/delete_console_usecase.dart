import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/console_repository.dart';
import 'package:jogos_zerados/app/injector.dart';

class DeleteConsoleUseCase {
  final repository = injector.get<ConsoleRepository>();

  Future<void> call(Console console) async {
    await repository.delete(console);
  }
}
