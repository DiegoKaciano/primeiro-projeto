import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/entities/game_entity.dart';
import 'package:jogos_zerados/app/ui/components/custom_floating_button.dart';
import 'package:jogos_zerados/app/ui/pages/console_registration_page.dart';
import 'package:jogos_zerados/app/ui/pages/consoles_pages.dart';
import 'package:jogos_zerados/app/ui/pages/game_registration_page.dart';
import 'package:jogos_zerados/app/ui/pages/games_page.dart';
import 'package:jogos_zerados/app/ui/viewmodels/console_view_model.dart';
import 'package:jogos_zerados/app/ui/viewmodels/game_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gameViewModel = GameViewModel();
  final consoleViewModel = ConsoleViewModel();

  final _pageController = PageController(initialPage: 0);
  final List<Widget> screens = [GamesPage(), ConsolesPages()];

  int selectedScreens = 0;
  bool isFabOpen = false;

  void _toggleFab() {
    setState(() {
      isFabOpen = !isFabOpen;
    });
  }

  void _openGameRegistration([Game? game]) {
    _toggleFab();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameRegistrationScreen(game: game),
      ),
    );
  }

  Future<void> _openConsoleRegistration() async {
    _toggleFab();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConsoleRegistrationPage(),
      ),
    );
    await _fetchGames();
    await _fetchConsoles();
  }

  Future<void> _fetchGames([String? search]) async {
    await gameViewModel.fetchGames(context, search);
  }

  Future<void> _fetchConsoles() async {
    await consoleViewModel.fetchConsoles(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchGames();
      await _fetchConsoles();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      selectedScreens = index;
      if (isFabOpen) isFabOpen = false;
    });
    _pageAnimate(index);
  }

  void _pageAnimate(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: screens,
        ),
      ),
      floatingActionButton: Stack(children: [
        if (isFabOpen)
          CustomFloatingButton(
            position: 170,
            title: 'Add Game',
            iconData: Icons.videogame_asset,
            onTap: _openGameRegistration,
          ),
        if (isFabOpen)
          CustomFloatingButton(
            position: 100,
            title: 'Add Console',
            iconData: Icons.games,
            onTap: _openConsoleRegistration,
          ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            heroTag: 'main_fab',
            onPressed: _toggleFab,
            backgroundColor: Colors.deepPurple,
            tooltip: 'Add',
            child: Icon(isFabOpen ? Icons.close : Icons.add),
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedScreens,
        selectedItemColor: Colors.blue,
        onTap: _pageAnimate,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset_rounded),
              label: 'Jogos',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Consoles',
          ),
        ],
      ),
    );
  }
}
