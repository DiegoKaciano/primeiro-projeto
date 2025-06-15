import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/ui/components/detailed_game_card.dart';

class GamesListView extends StatelessWidget {
  final List<Game> games;
  final Function(Game) onGameTap;

  const GamesListView({
    super.key,
    required this.games,
    required this.onGameTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          final isLastItem = games.length == index + 1;
          return Column(
            children: [
              DetailedGameCard(game: game, onTap: () => onGameTap(game)),
              if (isLastItem) const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }
}