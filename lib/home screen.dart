import 'package:flutter/material.dart';
import 'game logic.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool gameover = false;

  int turn = 0;

  String winner = '';

  String activeplayer = 'x';

  bool computer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      ...firstHalf(),
                      expa(),
                      secondHalf(),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ...firstHalf(),

                            secondHalf(),
                          ],
                        ),
                      ),
                      expa(),
                    ],
                  )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              gameover = false;
              Player.playero = [];
              Player.playerx = [];
              turn = 0;
              winner = '';
              activeplayer = 'x';
            });
          },
          child: const Icon(Icons.repeat),
        ));
  }

  Widget secondHalf() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Text(
        '$winner',
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }

  List<Widget> firstHalf() {
    return [
      SwitchListTile.adaptive(
        value: computer,
        onChanged: (val) => setState(() => computer = val),
        title: const Text(
          'Do you want to play against the machine?',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "it's $activeplayer turn",
          style: const TextStyle(
              fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  Expanded expa() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: gameover
                ? null
                : () {
                    if (!Player.playero.contains(index) &&
                        !Player.playerx.contains(index)) {
                      if (computer == true)
                        smartplay(index);
                      else
                        playgame(index);
                    }
                  },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(18, 21, 72, 1.0),
              ),
              child: Center(
                  child: Text(
                Player.playerx.contains(index)
                    ? 'x'
                    : Player.playero.contains(index)
                        ? 'o'
                        : '',
                style: TextStyle(
                  fontSize: 100,
                  color:
                      Player.playero.contains(index) ? Colors.red : Colors.blue,
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }

  void playgame(int index) {
    if (activeplayer == 'x')
      Player.playerx.add(index);
    else
      Player.playero.add(index);

    update();
  }

  void update() {
    setState(() {
      activeplayer = (activeplayer == 'x') ? 'o' : 'x';
      turn++;
      if (turn == 9) {
        gameover = true;
        winner = 'Tie';
      }
      checkWinner();
    });
  }

  randomplay(int ind) {
    if (activeplayer == 'x') Player.playerx.add(ind);
    update();
    List empty = [];
    Random r = Random();
    for (int i = 0; i < 9; i++) {
      if (!(Player.playero.contains(i) || Player.playerx.contains(i)))
        empty.add(i);
    }

    Player.playero.add(empty[r.nextInt(empty.length)]);
    update();
  }

  checkWinner() {
    if (Player.playerx.containsall(0, 1, 2) ||
        Player.playerx.containsall(3, 4, 5) ||
        Player.playerx.containsall(6, 7, 8) ||
        Player.playerx.containsall(0, 3, 6) ||
        Player.playerx.containsall(1, 4, 7) ||
        Player.playerx.containsall(2, 5, 8) ||
        Player.playerx.containsall(0, 4, 8) ||
        Player.playerx.containsall(2, 4, 6)) {
      setState(() => winner = 'The winner is X');
      gameover = true;
    } else if (Player.playero.containsall(0, 1, 2) ||
        Player.playero.containsall(3, 4, 5) ||
        Player.playero.containsall(6, 7, 8) ||
        Player.playero.containsall(0, 3, 6) ||
        Player.playero.containsall(1, 4, 7) ||
        Player.playero.containsall(2, 5, 8) ||
        Player.playero.containsall(0, 4, 8) ||
        Player.playero.containsall(2, 4, 6)) {
      setState(() => winner = 'The winner is O');
      gameover = true;
    }
  }

  smartplay(int ind) {
    if (activeplayer == 'x') Player.playerx.add(ind);
    update();
    List empty = [];
    Random r = Random();
    for (int i = 0; i < 9; i++)
      if (!(Player.playero.contains(i) || Player.playerx.contains(i)))
        empty.add(i);

    int index;


    // start - center
     if (Player.playerx.containsall(0, 1) && empty.contains(2))
    index = 2;
    else if (Player.playerx.containsall(3, 4) && empty.contains(5))
    index = 5;
    else if (Player.playerx.containsall(6, 7) && empty.contains(8))
    index = 8;
    else if (Player.playerx.containsall(0, 3) && empty.contains(6))
    index = 6;
    else if (Player.playerx.containsall(1, 4) && empty.contains(7))
    index = 7;
    else if (Player.playerx.containsall(2, 5) && empty.contains(8))
    index = 8;
    else if (Player.playerx.containsall(0, 4) && empty.contains(8))
    index = 8;
    else if (Player.playerx.containsall(2, 4) && empty.contains(6))
    index = 6;

    // start - end
    else if (Player.playerx.containsall(0, 2) && empty.contains(1))
    index = 1;
    else if (Player.playerx.containsall(3, 5) && empty.contains(4))
    index = 4;
    else if (Player.playerx.containsall(6, 8) && empty.contains(7))
    index = 7;
    else if (Player.playerx.containsall(0, 6) && empty.contains(3))
    index = 3;
    else if (Player.playerx.containsall(1, 7) && empty.contains(4))
    index = 4;
    else if (Player.playerx.containsall(2, 8) && empty.contains(5))
    index = 5;
    else if (Player.playerx.containsall(0, 8) && empty.contains(4))
    index = 4;
    else if (Player.playerx.containsall(2, 6) && empty.contains(4))
    index = 4;

// center - end
    else if (Player.playerx.containsall(1, 2) && empty.contains(0))
    index = 0;
    else if (Player.playerx.containsall(4, 5) && empty.contains(3))
    index = 3;
    else if (Player.playerx.containsall(7, 8) && empty.contains(6))
    index = 6;
    else if (Player.playerx.containsall(3, 6) && empty.contains(0))
    index = 0;
    else if (Player.playerx.containsall(4, 7) && empty.contains(1))
    index = 1;
    else if (Player.playerx.containsall(5, 8) && empty.contains(2))
    index = 2;
    else if (Player.playerx.containsall(4, 8) && empty.contains(0))
    index = 0;
    else if (Player.playerx.containsall(4, 6) && empty.contains(2))
    index = 2;

//start - center
    else if (Player.playero.containsall(0, 1) && empty.contains(2))
      index = 2;
    else if (Player.playero.containsall(3, 4) && empty.contains(5))
      index = 5;
    else if (Player.playero.containsall(6, 7) && empty.contains(8))
      index = 8;
    else if (Player.playero.containsall(0, 3) && empty.contains(6))
      index = 6;
    else if (Player.playero.containsall(1, 4) && empty.contains(7))
      index = 7;
    else if (Player.playero.containsall(2, 5) && empty.contains(8))
      index = 8;
    else if (Player.playero.containsall(0, 4) && empty.contains(8))
      index = 8;
    else if (Player.playero.containsall(2, 4) && empty.contains(6))
      index = 6;

    // start - end
    else if (Player.playero.containsall(0, 2) && empty.contains(1))
      index = 1;
    else if (Player.playero.containsall(3, 5) && empty.contains(4))
      index = 4;
    else if (Player.playero.containsall(6, 8) && empty.contains(7))
      index = 7;
    else if (Player.playero.containsall(0, 6) && empty.contains(3))
      index = 3;
    else if (Player.playero.containsall(1, 7) && empty.contains(4))
      index = 4;
    else if (Player.playero.containsall(2, 8) && empty.contains(5))
      index = 5;
    else if (Player.playero.containsall(0, 8) && empty.contains(4))
      index = 4;
    else if (Player.playero.containsall(2, 6) && empty.contains(4))
      index = 4;

// center - end
    else if (Player.playero.containsall(1, 2) && empty.contains(0))
      index = 0;
    else if (Player.playero.containsall(4, 5) && empty.contains(3))
      index = 3;
    else if (Player.playero.containsall(7, 8) && empty.contains(6))
      index = 6;
    else if (Player.playero.containsall(3, 6) && empty.contains(0))
      index = 0;
    else if (Player.playero.containsall(4, 7) && empty.contains(1))
      index = 1;
    else if (Player.playero.containsall(5, 8) && empty.contains(2))
      index = 2;
    else if (Player.playero.containsall(4, 8) && empty.contains(0))
      index = 0;
    else if (Player.playero.containsall(4, 6) && empty.contains(2))
      index = 2;


    else
      index = empty[r.nextInt(empty.length)];
    Player.playero.add(index);

    update();
  }
}

extension ContainsAll on List {
  bool containsall(int x, int y, [z]) {
    if (z == null)
      return contains(x) && contains(y);
    else
      return contains(x) && contains(y) && contains(z);
  }
}
