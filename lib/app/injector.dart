import 'package:auto_injector/auto_injector.dart';
import 'package:jogos_zerados/app/data/repositories/sqlite_console_repository.dart';
import 'package:jogos_zerados/app/data/repositories/sqlite_game_repository.dart';
import 'package:jogos_zerados/app/data/services/rawg_api_services.dart';
import 'package:jogos_zerados/app/domain/repositories/console_repository.dart';
import 'package:jogos_zerados/app/domain/repositories/game_repository.dart';
import 'package:jogos_zerados/app/domain/services/game_api_services.dart';
import 'package:jogos_zerados/app/domain/usecases/create_console_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/create_game_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/delete_console_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/delete_game_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/fetch_consoles_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/fetch_games_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/fetch_status_games_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/get_console_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/update_console_usecase.dart';
import 'package:jogos_zerados/app/domain/usecases/update_game_usecase.dart';
import 'package:jogos_zerados/app/ui/services/console_deleter.dart';
import 'package:jogos_zerados/app/ui/services/console_fetcher.dart';
import 'package:jogos_zerados/app/ui/services/console_saver.dart';
import 'package:jogos_zerados/app/ui/services/game_deleter.dart';
import 'package:jogos_zerados/app/ui/services/game_fetcher.dart';
import 'package:jogos_zerados/app/ui/services/game_fetcher_status.dart';
import 'package:jogos_zerados/app/ui/services/game_saver.dart';

final injector = AutoInjector();

void setupInjector(){
  //Repository
  injector.addSingleton<GameRepository>(SqliteGameRepository.new);
  injector.addSingleton<ConsoleRepository>(SqliteConsoleRepository.new);
  //Services
  injector.addSingleton<GameApiServices>(RawgApiService.new);
  //Console
  injector.addSingleton<ConsoleFetcher>(ConsoleFetcher.new);
  injector.addSingleton<ConsoleDeleter>(ConsoleDeleter.new);
  injector.addSingleton<ConsoleSaver>(ConsoleSaver.new);
  //ConsolesUseCase
  injector.addSingleton<CreateConsoleUseCase>(CreateConsoleUseCase.new);
  injector.addSingleton<DeleteConsoleUseCase>(DeleteConsoleUseCase.new);
  injector.addSingleton<FetchConsolesUseCase>(FetchConsolesUseCase.new);
  injector.addSingleton<GetConsoleUseCase>(GetConsoleUseCase.new);
  injector.addSingleton<UpdateConsoleUseCase>(UpdateConsoleUseCase.new);
  //Game
  injector.addSingleton<GameFetcher>(GameFetcher.new);
  injector.addSingleton<GameDeleter>(GameDeleter.new);
  injector.addSingleton<GameSaver>(GameSaver.new);
  injector.addSingleton<GameFetcherStatus>(GameFetcherStatus.new);
  //GamesUseCase
  injector.addSingleton<CreateGameUseCase>(CreateGameUseCase.new);
  injector.addSingleton<DeleteGameUseCase>(DeleteGameUseCase.new);
  injector.addSingleton<FetchGamesUseCase>(FetchGamesUseCase.new);
  injector.addSingleton<UpdateGameUseCase>(UpdateGameUseCase.new);
  injector.addSingleton<FetchStatusGamesUseCase>(FetchStatusGamesUseCase.new);
  //
  injector.commit();
}