import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/ui/pages/game_registration_page.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videogame_asset, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Bem-vindo ao Jogos Zerados!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Parece que você ainda não adicionou nenhum jogo à sua lista. Comece agora e mantenha o controle dos seus jogos favoritos!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameRegistrationScreen(),
                  ),
                );
              },
              child: const Text('Adicionar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
