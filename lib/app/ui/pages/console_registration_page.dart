import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/ui/components/custom_text.dart';
import 'package:jogos_zerados/app/ui/components/custom_textfield.dart';
import 'package:jogos_zerados/app/ui/viewmodels/console_view_model.dart';

class ConsoleRegistrationPage extends StatefulWidget {
  final Console? console;

  const ConsoleRegistrationPage({super.key, this.console});

  @override
  State<ConsoleRegistrationPage> createState() =>
      _ConsoleRegistrationPageState();
}

class _ConsoleRegistrationPageState extends State<ConsoleRegistrationPage> {
  final consoleViewModel = ConsoleViewModel();
  TextEditingController consoleEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void _saveConsole() {
    int? id;
    if (widget.console != null) {
      id = widget.console!.id;
    }
    final console = Console(
      id: id,
      name: consoleEditingController.text.trim(),
    );
    consoleViewModel.saveConsole(context, console);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.console != null) {
      consoleEditingController.text = widget.console!.name;
    }
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    consoleEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Consoles"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomText(label: 'Nome do console'),
            CustomTextField(
              controller: consoleEditingController,
              focusNode: focusNode,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveConsole,
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
