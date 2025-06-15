import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/states/consoles_state.dart';
import 'package:jogos_zerados/app/domain/usecases/fetch_consoles_usecase.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:provider/provider.dart';

class ConsoleFetcher {
  final fetchConsolesUseCase = injector.get<FetchConsolesUseCase>();

  Future<void> fetchConsoles(BuildContext context) async {
    try {
      final state = Provider.of<ConsolesState>(context, listen: false);
      final consoles = await fetchConsolesUseCase.call();
      state.setConsoles(consoles);
    } catch (e) {
      print('Error ConsoleFetcher');
    }
  }
}