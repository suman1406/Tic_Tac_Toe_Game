import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<List<String>> _boards = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String player = 'X';
  String winner = '';

  void play(int i, int j) {
    if (_boards[i][j] == '') {
      setState(() {
        _boards[i][j] = player;
        _checkWinner();
        if (winner == '') {
          player = player == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  void _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (_boards[i][0] == _boards[i][1] &&
          _boards[i][1] == _boards[i][2] &&
          _boards[i][0] != '') {
        setState(() {
          winner = _boards[i][0];
        });
        showWinnerDialogBox();
        return;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (_boards[0][i] == _boards[1][i] &&
          _boards[1][i] == _boards[2][i] &&
          _boards[0][i] != '') {
        setState(() {
          winner = _boards[0][i];
        });
        showWinnerDialogBox();
        return;
      }
    }

    if (_boards[0][0] == _boards[1][1] &&
        _boards[1][1] == _boards[2][2] &&
        _boards[0][0] != '') {
      setState(() {
        winner = _boards[0][0];
      });
      showWinnerDialogBox();
      return;
    }

    if (_boards[0][2] == _boards[1][1] &&
        _boards[1][1] == _boards[2][0] &&
        _boards[0][2] != '') {
      setState(() {
        winner = _boards[0][2];
      });
      showWinnerDialogBox();
      return;
    }

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_boards[i][j] == '') {
          return;
        }
      }
    }

    setState(() {
      winner = 'Tie';
    });
    showWinnerDialogBox();
  }

  void showWinnerDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Winner'),
          content: Text(winner == 'Tie' ? 'Game is Tie' : 'Player $winner won'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      _boards[0] = ['', '', ''];
      _boards[1] = ['', '', ''];
      _boards[2] = ['', '', ''];
      player = 'X';
      winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: resetGame,
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                int i = index ~/ 3;
                int j = index % 3;
                return GestureDetector(
                  onTap: () {
                    play(i, j);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _boards[i][j] == 'X'
                          ? Colors.amberAccent
                          : _boards[i][j] == 'O'
                              ? Colors.redAccent
                              : Colors.white,
                      border: Border.all(
                        color: _boards[i][j] == 'X'
                            ? Colors.amberAccent
                            : _boards[i][j] == 'O'
                                ? Colors.redAccent
                                : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _boards[i][j],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
