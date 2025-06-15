
import 'package:jogos_zerados/app/core/database_constants.dart';
import 'package:jogos_zerados/app/data/adapters/console_adapter.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/console_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteConsoleRepository implements ConsoleRepository {
  Future<Database> _init() async {
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/db_consoles.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute('''
          CREATE TABLE $kConsoles(
          $kId INTEGER PRIMARY KEY,
          $kName TEXT
          )
          ''');
      },
    );
  }

  @override
  Future<Console> create(Console console) async {
    final repository = await _init();
    final consoleAdapter = ConsoleAdapter();
    final map = consoleAdapter.toMap(console);

    final id = await repository.insert(kConsoles, map);

    return read(id);
  }

  @override
  Future<void> delete(Console console) async {
    final repository = await _init();
    await repository.delete(kConsoles, where: '$kId = ${console.id}');
  }

  @override
  Future<List<Console>> fetch() async {
    final repository = await _init();
    final consoleAdapter = ConsoleAdapter();

    List<Map> maps = await repository.query(
      kConsoles,
      orderBy: "$kName ASC",
      columns: [
        kId,
        kName,
      ],
    );

    List<Console> consoles = [];
    for (Map map in maps) {
      consoles.add(consoleAdapter.fromMap(map));
    }
    return consoles;
  }

  @override
  Future<Console> read(int id) async {
    final repository = await _init();
    List<Map> maps = await repository.query(
      kConsoles,
      columns: [
        kId,
        kName,
      ],
      where: '$kId = $id',
    );

    final consoleAdapter = ConsoleAdapter();
    List<Console> consoles = [];
    for (Map map in maps) {
      consoles.add(consoleAdapter.fromMap(map));
    }
    final consoleStandard = Console( id: id, name: '');

    return consoles.isEmpty ? consoleStandard : consoles.first;
  }

  @override
  Future<void> update(Console console) async {
    final repository = await _init();
    final consoleAdapter = ConsoleAdapter();
    final map = consoleAdapter.toMap(console);

    await repository.update(
      kConsoles,
      map,
      where: '$kId = ${console.id}',
    );
  }
}
