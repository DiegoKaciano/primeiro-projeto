import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/states/consoles_state.dart';
import 'package:jogos_zerados/app/domain/usecases/delete_console_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:provider/provider.dart';

class ConsoleDeleter {
  final deleteConsoleUseCase = injector.get<DeleteConsoleUseCase>();

  Future<void> deleteConsole(BuildContext context, Console console) async {
    try {
      final state = Provider.of<ConsolesState>(context, listen: false);
      final consoles = state.consoles.toList();
      await deleteConsoleUseCase.call(console);
      consoles.remove(console);
      state.setConsoles(consoles);
    } catch (e) {
      print('Error ConsoleDeleter');
    }
  }
}
