import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/states/consoles_state.dart';
import 'package:jogos_zerados/app/ui/components/console_card.dart';
import 'package:jogos_zerados/app/ui/dialogs/delete_confirmation_dialog.dart';
import 'package:jogos_zerados/app/ui/pages/console_registration_page.dart';
import 'package:jogos_zerados/app/ui/viewmodels/console_view_model.dart';
import 'package:provider/provider.dart';

class ConsolesPages extends StatefulWidget {
  const ConsolesPages({super.key});

  @override
  State<ConsolesPages> createState() => _ConsolesPagesState();
}

class _ConsolesPagesState extends State<ConsolesPages> {
  final consoleViewModel = ConsoleViewModel();

  void _openConsoleRegistration(Console console) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConsoleRegistrationPage(
          console: console,
        ),
      ),
    );
  }

  Future<void> _deleteConsole(Console console) async {
    await consoleViewModel.deleteConsole(context, console);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ConsolesState>(builder: (context, state, child) {
              return ListView.builder(
                itemCount: state.consoles.length,
                itemBuilder: (context, index) {
                  final console = state.consoles[index];
                  final isLastItem = state.consoles.length == index + 1;
                  return Column(
                    children: [
                      ConsoleCard(
                        console: console,
                        onTap: () => _openConsoleRegistration(console),
                        onLongPress: () => showDeleteConfirmationDialog(
                          context: context,
                          title: console.name,
                          onConfirm: () => _deleteConsole(console),
                        ),
                      ),
                      if (isLastItem) SizedBox(height: 100),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
