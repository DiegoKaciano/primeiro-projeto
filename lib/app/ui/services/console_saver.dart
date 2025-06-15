import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/states/consoles_state.dart';
import 'package:jogos_zerados/app/domain/usecases/create_console_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/update_console_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:provider/provider.dart';

class ConsoleSaver {
  final createConsoleUseCase = injector.get<CreateConsoleUseCase>();
  final updateConsoleUseCase = injector.get<UpdateConsoleUseCase>();

  Future<void> saveConsole(BuildContext context, Console console) async {
    try {
      final state = Provider.of<ConsolesState>(context, listen: false);
      final consoles = state.consoles.toList();


      if (console.id == null) {
        final newConsole = await createConsoleUseCase.call(console);
        consoles.add(newConsole);
      } else {
        await updateConsoleUseCase.call(console);
        final index = consoles.indexWhere((c) => c.id == console.id);
        if (index != -1) {
          consoles[index] = console;
        }
      }
      state.setConsoles(consoles);
    } catch (e) {
      print('Error ConsoleSaver');
    }
  }
}