import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/data/models/game_api_model.dart';
import 'package:jogos_zerados/app/domain/services/game_api_services.dart';
import 'package:jogos_zerados/app/injector.dart';
import 'package:jogos_zerados/app/ui/components/custom_search_textfield.dart';
import 'package:jogos_zerados/app/ui/components/empty_list_view_message.dart';
import 'package:jogos_zerados/app/ui/components/game_info_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final gameApiServices = injector.get<GameApiServices>();
  final focusNode = FocusNode();

  String searchText = '';

  void search(String query) {
    setState(() {
      searchText = query;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Procurar'),
      ),
      body: Column(
        children: <Widget>[
          CustomSearchTextField(
            focusNode: focusNode,
            onSubmitted: search,
          ),
          searchText.isEmpty
              ? EmptyListViewMessage(title: 'Procure por seu jogo!')
              : Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: gameApiServices.fetchGames(searchText),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      } else {
                        final games = snapshot.data!;

                        return ListView.builder(
                          itemCount: games.length,
                          itemBuilder: (context, index) {
                            final game = GameApiModel.fromMap(games[index]);
                            return GestureDetector(
                              onTap: () => Navigator.pop(context, game),
                              child: GameInfoCard(gameInfo: game),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
