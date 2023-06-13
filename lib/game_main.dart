import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    );
  }
}

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int userChoice = 0;
  int computerChoice = 0;

  int scoreYou = 0;
  int scoreComputer = 0;
  double turns = 0.0;
  bool isPlay = false;

  late List<int> userScore;
  late List<int> computerScore;
  List<String> messages = ['You win!', 'Computer win!', 'No one win.'];
  String message = '';

  _changeRotation() {
    setState(() {
      turns += 1.0;
    });
  }

  play(int choice) {
    isPlay = true;
    userChoice = choice;
    turns += 1.0;
    setState(() {
      turns += 1.0;
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        computerChoice = Random().nextInt(3);
        isPlay = false;
        roundWinner();
      });
    });
  }

  roundWinner() {
    if (userChoice == 0 && computerChoice == 2 ||
        userChoice == 1 && computerChoice == 0 ||
        userChoice == 2 && computerChoice == 1) {
      scoreComputer++;
      computerScore.add(scoreComputer);
      message = messages[1];
    } else if (userChoice == 0 && computerChoice == 1 ||
        userChoice == 1 && computerChoice == 2 ||
        userChoice == 2 && computerChoice == 0) {
      scoreYou++;
      userScore.add(scoreYou);
      message = messages[0];
    } else {
      message = messages[2];
    }
  }

  @override
  void initState() {
    setState(() {
      userChoice = Random().nextInt(3);
      computerChoice = Random().nextInt(3);
      userScore = [];
      computerScore = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('ROCK, PAPER, SCISSORS'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 5,
            ),
            AnimatedOpacity(
              opacity: isPlay ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isPlay ? 1 : 0,
                curve: Curves.easeInOut,
                child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/btn0.png",
                        height: 30,
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/btn1.png",
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "assets/images/btn2.png",
                            height: 30,
                            width: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.red,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Text(
                    'Game Score',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '$scoreYou :',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$scoreComputer',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Computer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: !isPlay ? 1.0 : 0,
                      curve: Curves.easeInOut,
                      child: Image.asset(
                        'assets/images/btn$userChoice.png',
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'VS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    const Text(
                      'Computer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: !isPlay ? 1.0 : 0,
                      curve: Curves.easeInOut,
                      child: Image.asset(
                        'assets/images/btn$computerChoice.png',
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => play(1),
                      child: Image.asset(
                        'assets/images/btn1.png',
                        width: 75,
                        height: 75,
                      ),
                    ),
                    TextButton(
                      onPressed: () => play(2),
                      child: Image.asset('assets/images/btn2.png',
                          width: 75, height: 75),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => play(0),
                  child: Image.asset(
                    'assets/images/btn0.png',
                    width: 75,
                    height: 75,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
