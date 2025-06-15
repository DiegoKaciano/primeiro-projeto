import 'package:flutter/cupertino.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';

class ConsolesState extends ChangeNotifier {
  List<Console> _consoles = [];

  List<Console> get consoles => _consoles;

  void setConsoles(List<Console> value) {
    _consoles = value;
    notifyListeners();
  }
}
