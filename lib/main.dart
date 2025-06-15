import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/states/consoles_state.dart';
import 'package:jogos_zerados/app/domain/states/games_state.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:jogos_zerados/app/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  setupInjector();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GamesState(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConsolesState(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
