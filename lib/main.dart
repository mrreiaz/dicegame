import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

var number = Random();

void main() {
  runApp(const Dice());
}

class Dice extends StatelessWidget {
  const Dice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
          title: const Text('Dice App'),
        ),
        body: const DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  late ConfettiController _confettiController;
  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<void> playSound() async {
    const String soundPath = "diceroll.mp3";
    await _audioPlayer.play(AssetSource(soundPath));
  }

  Future<void> wineSound() async {
    const String soundPath =
        "match.mp3"; // Update with your actual sound file path
    await _audioPlayer.play(AssetSource(soundPath));
  }

  Future<void> lostSound() async {
    const String soundPath =
        "tryagainthisgame.m4a"; // Update with your actual sound file path
    await _audioPlayer.play(AssetSource(soundPath));
  }

  Future<void> startgame() async {
    const String soundPath = "startthegame.m4a";
    await _audioPlayer.play(AssetSource(soundPath));
  }

  Future<void> resetthagame() async {
    const String soundPath =
        "resetthegame.m4a"; // Update with your actual sound file path
    await _audioPlayer.play(AssetSource(soundPath));
  }

  int dic1 = 1;
  int dic2 = 1;
  int targetScore = 0;
  int maxTry = 0;

  void setTarget() {
    setState(() {
      targetScore = number.nextInt(12) + 1;
      maxTry = 3;
    });
  }

  void resetGame() {
    setState(() {
      dic1 = 1;
      dic2 = 1;
      targetScore = 0;
      maxTry = 0;
      resetthagame();
    });
  }

  void play() {
    setState(() {
      dic1 = number.nextInt(6) + 1;
      dic2 = number.nextInt(6) + 1;
      maxTry--;
    });

    if (targetScore == (dic1 + dic2)) {
      _confettiController.play();
      wineSound();
      //resetGame();
    }

    if (maxTry == -1) {
      resetGame();
    }

    if (maxTry == 0) {
      lostSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Throw Dice and Make Score $targetScore !',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
              ),
            ),
          ],
        ),

        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Your Try remaining $maxTry',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset('assets/imgs/$dic1.png'),
                    //
                    // image: AssetImage('images/dice$diceNumberSecond.gif'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset('assets/imgs/$dic2.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
          children: [
            ElevatedButton(
              onPressed: () {
                startgame();
                setTarget();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                textStyle: const TextStyle(color: Colors.black),
                shape: RoundedRectangleBorder(
                  // Shape of the button
                  borderRadius: BorderRadius.circular(2), // Rounded corners
                  side:
                      const BorderSide(color: Colors.black, width: 2), // Border
                ),
              ),
              child: const Text('Start'),
            ),
            ElevatedButton(
              onPressed: () {
                //AudioPlayer().play(AssetSource('diceroll.mp3'));
                playSound();
                play();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                textStyle: const TextStyle(color: Colors.black),
                shape: RoundedRectangleBorder(
                  // Shape of the button
                  borderRadius: BorderRadius.circular(2), // Rounded corners
                  side:
                      const BorderSide(color: Colors.black, width: 2), // Border
                ),
              ),
              child: const Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                startgame();
                resetGame();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                textStyle: const TextStyle(color: Colors.black),
                shape: RoundedRectangleBorder(
                  // Shape of the button
                  borderRadius: BorderRadius.circular(2), // Rounded corners
                  side:
                      const BorderSide(color: Colors.black, width: 2), // Border
                ),
              ),
              child: const Text('Reset'),
            ),
          ],
        ),
        SizedBox(
          height: 140,
        ),

        // Expanded(
        //   flex: 4,
        //   child: Container(
        //     child: TextButton(
        //       onPressed: () {
        //         dicface();
        //       },
        //       child: const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: Text(
        //           'Click',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //             backgroundColor: Colors.black,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
