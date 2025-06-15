import 'package:jogos_zerados/app/core/database_constants.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';

class ConsoleAdapter {
  Map<String, dynamic> toMap(Console console) {
    final data = {
      kId: console.id,
      kName: console.name,
    };
    return data;
  }

  Console fromMap(Map map) {
    return Console(
      id: map[kId],
      name: map[kName],
    );
  }
}
