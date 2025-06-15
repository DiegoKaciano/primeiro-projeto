import 'package:jogos_zerados/app/domain/entities/console_entity.dart';

abstract class ConsoleRepository {
  Future<List<Console>> fetch();

  Future<Console> read(int id);

  Future<Console> create(Console console);

  Future<void> update(Console console);

  Future<void> delete(Console console);
}