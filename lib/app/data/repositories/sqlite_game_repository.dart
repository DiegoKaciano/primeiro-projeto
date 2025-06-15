import 'package:jogos_zerados/app/core/database_constants.dart';
import 'package:jogos_zerados/app/data/adapters/games_adapter.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteGameRepository implements GameRepository {
  final List<String> query = [
    kId,
    kTitle,
    kGenre,
    kNamePlatform,
    kPlatforms,
    kIdConsole,
    kGameState,
    kUrlImage,
    kStartDate,
    kCompletionDate,
    kIsFinished,
    kRating,
    kNotes,
  ];

  void total(){}

  Future<Database> _init() async {
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/db_games5.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute('''
          CREATE TABLE $kGames(
          $kId INTEGER PRIMARY KEY,
          $kTitle TEXT,
          $kGenre TEXT, 
          $kNamePlatform TEXT, 
          $kPlatforms TEXT, 
          $kIdConsole INTEGER, 
          $kGameState TEXT, 
          $kUrlImage TEXT, 
          $kStartDate INTEGER,
          $kCompletionDate INTEGER,
          $kIsFinished INTEGER,
          $kRating INTEGER,
          $kNotes TEXT
          )
          ''');
      },
    );
  }

  @override
  Future<Game> create(Game game) async {
    final repository = await _init();
    final gamesAdapter = GamesAdapter();
    final map = gamesAdapter.toMap(game);

    final id = await repository.insert(kGames, map);

    return read(id);
  }

  @override
  Future<void> delete(Game game) async {
    final repository = await _init();
    await repository.delete(kGames, where: '$kId = ${game.id}');
  }

  @override
  Future<List<Game>> fetch([String? search]) async {
    final repository = await _init();
    final gamesAdapter = GamesAdapter();

    List<Map> maps;
    if (search != null) {
      maps = await repository.query(
        kGames,
        orderBy: "$kId DESC",
        where: '$kIdConsole = ?',
        whereArgs: [search],
        columns: query,
      );
    } else {
      maps = await repository.query(
        kGames,
        orderBy: "$kId DESC",
        columns: query,
      );
    }

    List<Game> games = [];
    for (Map map in maps) {
      final item = await gamesAdapter.fromMap(map);
      games.add(item);
    }
    return games;
  }

  @override
  Future<Game> read(int id) async {
    final repository = await _init();
    List<Map> maps = await repository.query(
      kGames,
      columns: query,
      where: '$kId = $id',
    );

    final gamesAdapter = GamesAdapter();
    List<Game> games = [];
    for (Map map in maps) {
      final item = await gamesAdapter.fromMap(map);
      games.add(item);
    }
    return games.first;
  }

  @override
  Future<void> update(Game game) async {
    final repository = await _init();
    final gamesAdapter = GamesAdapter();
    final map = gamesAdapter.toMap(game);

    await repository.update(
      kGames,
      map,
      where: '$kId = ${game.id}',
    );
  }

  @override
  Future<int> fetchStatus(int idConsole) async {
    final repository = await _init();

    List<Map> maps = await repository.query(
      kGames,
      where: '$kIdConsole = $idConsole',
      columns: query,
    );

    return maps.length;
  }
}
