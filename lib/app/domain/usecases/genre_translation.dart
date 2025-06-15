final Map<String, String> genreTranslations = {
  "Action": "Ação",
  "Adventure": "Aventura",
  "RPG": "RPG",
  "Shooter": "Tiro",
  "Puzzle": "Quebra-cabeça",
  "Sports": "Esportes",
  "Strategy": "Estratégia",
  "Simulation": "Simulação",
  "Casual": "Casual",
  "Platformer": "Plataforma",
  "Fighting": "Luta",
  "Racing": "Corrida",
  "Arcade": "Arcade",
  "Music": "Música",
  "Party": "Festa",
  "Board Games": "Jogos de Tabuleiro",
  "Card Game": "Jogo de Cartas",
  "Trivia": "Trivia",
  "Educational": "Educacional",
  "Indie": "Indie",
  "MMORPG": "MMORPG",
  "MOBA": "MOBA",
  "Horror": "Terror",
  "Survival": "Sobrevivência",
  "Stealth": "Furtivo",
  "Sandbox": "Mundo Aberto",
  "Visual Novel": "Romance Visual",
  "Dating Sim": "Simulador de Namoro",
  "Roguelike": "Roguelike",
  "Roguelite": "Roguelite",
  "Point-and-Click": "Aponte e Clique",
  "Rhythm": "Ritmo",
  "Tactical": "Tático",
  "Tower Defense": "Defesa de Torre",
  "Turn-Based": "Baseado em Turnos",
  "First-Person": "Primeira Pessoa",
  "Third-Person": "Terceira Pessoa",
  "Real-Time Strategy": "Estratégia em Tempo Real",
  "Text Adventure": "Aventura de Texto",
  "Massively Multiplayer": "Multijogador em Massa",
};

String translateGenre(String genre) {
  return genreTranslations[genre] ?? genre;
}

String translateGenres(List<String> genres){
  final List<String> translatedStrings = genres.map((genre) => translateGenre(genre)).toList();
  return translatedStrings.join(', ');
}
