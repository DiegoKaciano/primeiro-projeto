import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required VoidCallback onConfirm,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Deseja realmente excluir o jogo $title?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Excluir'),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
