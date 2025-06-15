import 'package:flutter/material.dart';
import 'package:jogos_zerados/app/domain/entities/console_entity.dart';
import 'package:jogos_zerados/app/ui/viewmodels/game_view_model.dart';

class ConsoleCard extends StatefulWidget {
  final Console console;
  final Function() onTap;
  final Function() onLongPress;

  const ConsoleCard({
    super.key,
    required this.console,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<ConsoleCard> createState() => _ConsoleCardState();
}

class _ConsoleCardState extends State<ConsoleCard> {
  final gameViewModel = GameViewModel();
  String total = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //test();
    });
  }

  void test() async {
    String result = await gameViewModel.fetchStatus(widget.console.id!);
    setState(() {
      total = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (total != '0')
                Text(
                  total,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  widget.console.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
