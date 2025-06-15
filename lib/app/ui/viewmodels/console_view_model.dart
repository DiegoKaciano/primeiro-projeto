import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:jogos_zerados/app/ui/services/console_deleter.dart';
import 'package:jogos_zerados/app/ui/services/console_fetcher.dart';
import 'package:jogos_zerados/app/ui/services/console_saver.dart';

class ConsoleViewModel {
  final consoleFetcher = injector.get<ConsoleFetcher>();
  final consoleSaver = injector.get<ConsoleSaver>();
  final consoleDeleter = injector.get<ConsoleDeleter>();

  Future<void> fetchConsoles(BuildContext context) async {
    await consoleFetcher.fetchConsoles(context);
  }

  Future<void> saveConsole(BuildContext context, Console console) async {
    await consoleSaver.saveConsole(context, console);
  }

  Future<void> deleteConsole(BuildContext context, Console console) async {
    await consoleDeleter.deleteConsole(context, console);
  }
}
