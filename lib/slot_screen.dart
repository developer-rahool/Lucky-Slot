import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Lucky_Slot/drawer.dart';
import 'package:Lucky_Slot/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Lucky_Slot/roll_slot.dart';
import 'package:Lucky_Slot/roll_slot_controller.dart';
import 'package:Lucky_Slot/scoreboard.dart';
import 'package:audioplayers/audioplayers.dart';

// class Assetss {
//   static const seventhIc = 'assets/images/777_updated.svg';
//   static const cherryIc = 'assets/images/cherry_cleaned.svg';
//   static const appleIc = 'assets/images/apple_cleaned.svg';
//   static const barIc = 'assets/images/bar_cleaned.svg';
//   static const coinIc = 'assets/images/coin_updated.svg';
//   static const crownIc = 'assets/images/crown_cleaned.svg';
//   static const lemonIc = 'assets/images/lemon_cleaned.svg';
//   static const watermelonIc = 'assets/images/watermelon_cleaned.svg';
// }

// class Assets1 {
//   static const seventhIc = 'assets/images/777.svg';
//   static const cherryIc = 'assets/images/cherry.svg';
//   static const appleIc = 'assets/images/apple.svg';
//   static const barIc = 'assets/images/bar.svg';
//   static const coinIc = 'assets/images/coin.svg';
//   static const crownIc = 'assets/images/crown.svg';
//   static const lemonIc = 'assets/images/lemon.svg';
//   static const watermelonIc = 'assets/images/watermelon.svg';
// }

class Assets {
  static const seventhIc = 'assets/images/777.png';
  static const cherryIc = 'assets/images/cherry.png';
  static const appleIc = 'assets/images/apple.png';
  static const barIc = 'assets/images/bar.png';
  static const coinIc = 'assets/images/coin.png';
  static const crownIc = 'assets/images/crown.png';
  static const lemonIc = 'assets/images/lemon.png';
  static const watermelonIc = 'assets/images/watermelon.png';
}

class Assets2 {
  static const seventhIc = 'assets/slotIcons/7.png';
  static const cherryIc = 'assets/slotIcons/cherry.png';
  static const appleIc = 'assets/slotIcons/apple.png';
  static const cocktailIc = 'assets/slotIcons/cocktail.png';
  static const dollarIc = 'assets/slotIcons/dollar.png';
  static const kingIc = 'assets/slotIcons/king.png';
  static const bananaIc = 'assets/slotIcons/banana.png';
  static const aladinIc = 'assets/slotIcons/aladin.png';
  static const butterflyIc = 'assets/slotIcons/butterfly.png';
}

class MyHomePage extends StatefulWidget {
  final Function(int) onCoinsChange;

  const MyHomePage({super.key, required this.onCoinsChange});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _rollSlotController = RollSlotController();
  final _rollSlotController1 = RollSlotController();
  final _rollSlotController2 = RollSlotController();
  final _scoreBoardKey = GlobalKey<ScoreBoardState>();
  final List<String> prizesList = [
    Assets2.seventhIc,
    Assets2.cherryIc,
    Assets2.appleIc,
    Assets2.cocktailIc,
    Assets2.dollarIc,
    Assets2.kingIc,
    Assets2.bananaIc,
    Assets2.butterflyIc,
    Assets2.aladinIc,
  ];

  int spinCounter = 0;
  final Random _random = Random();
  int userCoins = 0;

  //
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _initializeCoins();
  }

  //
  // @override
  // void dispose() {
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }

  void _initializeCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins = prefs.getInt('userCoins') ??
          100; // Default to 100 coins on first launch
    });
  }

  void _updateScore() async {
    final centerImages = [
      prizesList[_rollSlotController.centerIndex],
      prizesList[_rollSlotController1.centerIndex],
      prizesList[_rollSlotController2.centerIndex],
    ];

    _scoreBoardKey.currentState?.updateScore(centerImages);

    // Fetch the reward points
    int points =
        _scoreBoardKey.currentState?.calculatePoints(centerImages) ?? 0;

    // Update the user's coin count
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins += points;
      prefs.setInt('userCoins', userCoins);
    });

    widget.onCoinsChange(points); // Notify the parent widget of the coin change

    if (spinCounter == 2) {
      spinCounter = 0; // Reset the counter after specific spins
    } else {
      spinCounter++;
    }
  }

  void _spinAllSlots() async {
    if (userCoins < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Not enough coins to spin!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      userCoins -= 10; // Deduct coins for each spin
    });

    widget.onCoinsChange(-10); // Update coins on parent widget

    int index = _random.nextInt(prizesList.length);
    bool shouldMatch = spinCounter == 2;

    _rollSlotController.animateRandomly(
      topIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
      centerIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
      bottomIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
    );
    _rollSlotController1.animateRandomly(
      topIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
      centerIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
      bottomIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
    );
    _rollSlotController2.animateRandomly(
      topIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
      centerIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
      bottomIndex: shouldMatch ? index : _random.nextInt(prizesList.length),
    );

    String audioPath = 'sound/trigger.wav';
    await audioPlayer.play(AssetSource(audioPath));

    Timer(const Duration(seconds: 3), () {
      _rollSlotController.stop();
      _rollSlotController1.stop();
      _rollSlotController2.stop();
      Future.delayed(const Duration(seconds: 3), () {
        _updateScore();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.amber,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Expanded(
          child: Text(
            'Slot Game',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              shadows: [
                Shadow(color: Colors.purpleAccent, blurRadius: 15),
              ],
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: CustomBackground(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.transparent, width: 0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 250,
                            child: ScoreBoard(
                                key: _scoreBoardKey,
                                onCoinsChange: widget.onCoinsChange),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 3,
                                color: Colors.purpleAccent,
                              ),
                            ),
                            height: 200,
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RollSlotWidget(
                                    prizesList: prizesList,
                                    rollSlotController: _rollSlotController),
                                RollSlotWidget(
                                    prizesList: prizesList,
                                    rollSlotController: _rollSlotController1),
                                RollSlotWidget(
                                    prizesList: prizesList,
                                    rollSlotController: _rollSlotController2),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Coins: $userCoins',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _spinAllSlots,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadowColor: Colors.white,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                            ),
                            child: const Text('SPIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RollSlotWidget extends StatelessWidget {
  final List<String> prizesList;
  final RollSlotController rollSlotController;

  const RollSlotWidget(
      {super.key, required this.prizesList, required this.rollSlotController});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: RollSlot(
              itemExtend: 115,
              rollSlotController: rollSlotController,
              children: prizesList.map((e) => BuildItem(asset: e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  final String asset;

  const BuildItem({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 11, 26, 28).withOpacity(.2),
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: const Color(0xff2f5d62).withOpacity(.2),
            offset: const Offset(-5, -5),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xff2f5d62)),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        asset,
        key: Key(asset),
        width: 230,
        height: 230,
      ),
    );
  }
}
