import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/domain/states/games_state.dart';
import 'package:jogos_zerados/app/ui/components/custom_search_textfield.dart';
import 'package:jogos_zerados/app/ui/components/games_listview.dart';
import 'package:jogos_zerados/app/ui/components/welcome_message.dart';
import 'package:jogos_zerados/app/ui/pages/game_registration_page.dart';
import 'package:provider/provider.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {

  void _openGameRegistration([Game? game]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameRegistrationScreen(game: game),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesState>(
      builder: (context, gameState, child) {
        return gameState.games.isEmpty
            ? const WelcomeMessage()
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                  child: CustomSearchTextField(onSubmitted: (a){}),
                ),
                GamesListView(
                          games: gameState.games,
                          onGameTap: _openGameRegistration,
                        ),
              ],
            );
      },
    );
  }
}


