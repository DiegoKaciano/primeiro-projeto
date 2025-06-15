import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/core/app_constants.dart';
import 'package:jogos_zerados/app/data/models/game_api_model.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/states/consoles_state.dart';
import 'package:jogos_zerados/app/domain/usecases/genre_translation.dart';
import 'package:jogos_zerados/app/ui/components/custom_button_picked.dart';
import 'package:jogos_zerados/app/ui/components/custom_dropdown.dart';
import 'package:jogos_zerados/app/ui/components/custom_snackbar.dart';
import 'package:jogos_zerados/app/ui/components/custom_switch.dart';
import 'package:jogos_zerados/app/ui/components/custom_text.dart';
import 'package:jogos_zerados/app/ui/components/date_picker_field.dart';
import 'package:jogos_zerados/app/ui/components/genre_tag.dart';
import 'package:jogos_zerados/app/ui/components/rating_stars.dart';
import 'package:jogos_zerados/app/ui/dialogs/delete_confirmation_dialog.dart';
import 'package:jogos_zerados/app/ui/pages/search_page.dart';
import 'package:jogos_zerados/app/ui/viewmodels/console_view_model.dart';
import 'package:jogos_zerados/app/ui/viewmodels/game_view_model.dart';
import 'package:provider/provider.dart';

class GameRegistrationScreen extends StatefulWidget {
  final Game? game;

  const GameRegistrationScreen({super.key, this.game});

  @override
  State<GameRegistrationScreen> createState() => _GameRegistrationScreenState();
}

class _GameRegistrationScreenState extends State<GameRegistrationScreen> {
  final gameViewModel = GameViewModel();
  final consoleViewModel = ConsoleViewModel();

  TextEditingController notesController = TextEditingController();
  String selectedGame = '';
  String? urlImage;
  String? selectedPlatform;
  int rating = 0;
  List<String> genres = [];
  List<String> platforms = [];
  bool isFinished = false;
  String? selectedConsole;
  String? selectedGameState;
  Console? console;
  DateTime? startDate;
  DateTime? endDate;

  void _saveGame() {
    if (selectedGame.isEmpty) {
      showCustomSnackBar(context, 'Por favor, insira o título do jogo.');
      return;
    }

    if (selectedPlatform == null || selectedPlatform!.isEmpty) {
      showCustomSnackBar(context, 'Por favor, selecione uma plataforma.');
      return;
    }

    if (platforms.isEmpty) {
      showCustomSnackBar(context, 'Por favor, insira as plataformas.');
      return;
    }

    if (console == null) {
      showCustomSnackBar(context, 'Por favor, selecione um console.');
      return;
    }

    if (!isFinished &&
        (selectedGameState == null || selectedGameState!.isEmpty)) {
      showCustomSnackBar(context, 'Por favor, selecione o estado do jogo.');
      return;
    }

    if (startDate == null) {
      showCustomSnackBar(context, 'Por favor, insira a data de início.');
      return;
    }

    if (isFinished && endDate == null) {
      showCustomSnackBar(context, 'Por favor, insira a data de conclusão.');
      return;
    }

    int? id;
    if (widget.game != null) {
      id = widget.game!.id;
    }
    final game = Game(
      id: id,
      title: selectedGame,
      genres: genres,
      namePlatform: selectedPlatform!,
      platforms: platforms,
      console: console!,
      gameState: isFinished ? '' : selectedGameState!,
      urlImage: urlImage ?? '',
      startDate: startDate!,
      completionDate: isFinished ? endDate! : DateTime.now(),
      isFinished: isFinished,
      rating: isFinished ? rating : 0,
      notes: notesController.text,
    );
    gameViewModel.saveGame(context, game);
    Navigator.pop(context);
  }

  Future<void> _navigateToSearch() async {
    final result = await Navigator.push<GameApiModel>(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );

    if (result != null) {
      setState(() {
        selectedGame = result.name;
        genres = result.genres;
        platforms = result.platforms;
        selectedPlatform = null;
        urlImage = result.urlImage;
      });
    }
  }

  void onChangedIsFinished(bool value) {
    setState(() {
      isFinished = value;
    });
  }

  void _deleteGame() {
    gameViewModel.deleteGame(context, widget.game!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await consoleViewModel.fetchConsoles(context);
    });
    if (widget.game != null) {
      final game = widget.game!;
      notesController.text = game.notes;
      selectedGame = game.title;
      urlImage = game.urlImage;
      platforms = game.platforms;
      selectedPlatform = game.namePlatform;
      rating = game.rating;
      genres = game.genres;
      isFinished = game.isFinished;
      selectedConsole = game.console.name;
      selectedGameState = game.gameState.isEmpty ? null : game.gameState;
      console = game.console;
      startDate = game.startDate;
      endDate = game.completionDate;
    }
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Jogos"),
        actions: [
          if (widget.game != null)
            IconButton(
              onPressed: () => showDeleteConfirmationDialog(
                context: context,
                title: widget.game!.title,
                onConfirm: _deleteGame,
              ),
              icon: Icon(Icons.delete),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomText(label: 'Nome do Jogo'),
            CustomButtonPicked(
              onTap: _navigateToSearch,
              selectedGame: selectedGame,
            ),
            if (genres.isNotEmpty) CustomText(label: 'Gêneros'),
            if (genres.isNotEmpty)
              Wrap(
                children: genres
                    .map((genre) => GenreTag(genre: translateGenre(genre)))
                    .toList(),
              ),
            CustomText(label: 'Plataforma'),
            CustomDropdown(
              items: platforms,
              selectedItem: selectedPlatform,
              isEnabled: true,
              onChanged: (value, index) {
                setState(() {
                  selectedPlatform = value;
                });
              },
            ),
            CustomText(label: 'Console'),
            Consumer<ConsolesState>(builder: (context, state, child) {
              return CustomDropdown(
                items: state.consoles.map((console) => console.name).toList(),
                selectedItem: selectedConsole,
                isEnabled: true,
                onChanged: (value, index) {
                  setState(() {
                    selectedConsole = value;
                    console = state.consoles[index];
                  });
                },
              );
            }),
            CustomText(label: 'Data de Início'),
            DatePickerField(
              selectedDate: startDate,
              onDateSelected: (date) {
                setState(() {
                  startDate = date;
                });
              },
            ),
            CustomText(label: 'Status do jogo'),
            CustomDropdown(
              items: gameStates,
              selectedItem: selectedGameState,
              isEnabled: !isFinished,
              onChanged: (value, index) {
                setState(() {
                  selectedGameState = value;
                });
              },
            ),
            SizedBox(height: 16),
            CustomSwitch(
              isFinished: isFinished,
              onChanged: onChangedIsFinished,
            ),
            if (isFinished)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(label: 'Data de Fim'),
                  DatePickerField(
                    selectedDate: endDate,
                    onDateSelected: (date) {
                      setState(() {
                        endDate = date;
                      });
                    },
                  ),
                  CustomText(label: 'Avaliação'),
                  RatingStars(
                    rating: rating,
                    onRatingChanged: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                    },
                  ),
                ],
              ),
            CustomText(label: 'Notas'),
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveGame,
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
