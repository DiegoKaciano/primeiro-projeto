import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/data/models/game_api_model.dart';

class GameInfoCard extends StatelessWidget {
  final GameApiModel gameInfo;

  const GameInfoCard({super.key, required this.gameInfo});

  @override
  Widget build(BuildContext context) {
    final name = gameInfo.name;
    final urlImage = gameInfo.urlImage!;
    final rating = gameInfo.rating;
    final released = gameInfo.released!;
    final platforms = gameInfo.platforms;

    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (urlImage.isNotEmpty)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  urlImage,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (name.isNotEmpty)
                    _text(
                      text: name,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  if (released.isNotEmpty)
                    _textSpacing(
                      text: 'Data de Lançamento: $released',
                      fontSize: 14,
                    ),
                  _textSpacing(
                    text: 'Avaliação: $rating',
                    fontSize: 14,
                  ),
                  if (platforms.isNotEmpty)
                    _textSpacing(
                      text: 'Plataformas: ${platforms.join(', ')}',
                      fontSize: 14,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget _textSpacing({
    required String text,
    required double fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: _text(
        text: text,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
    );
  }
}
