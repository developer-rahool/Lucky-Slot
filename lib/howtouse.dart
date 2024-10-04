import 'package:flutter/material.dart';
import 'package:Lucky_Slot/main.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.amber,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'How to Play',
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
        body: CustomBackground(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.amber, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'How to Play',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Mystic Treasures Legends offers two exciting games: the Slot Game and the Quiz Challenge. Here\'s how you can play them:',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Slot Game',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '1. Tap "Play Slot Game" on the main screen.\n'
                        '2. Press the "Start" button to spin the reels.\n'
                        '3. If you match three symbols, you win coins.\n'
                        '4. Use your coins to keep playing and try to win more!',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Quiz Challenge',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '1. Tap "Play Quiz" on the main screen.\n'
                        '2. Select a category: Mythology, History, Science, or Literature.\n'
                        '3. Answer the questions correctly to earn coins.\n'
                        '4. Use the coins earned to play the Slot Game.',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Tips',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Play the quiz to earn more coins if you run out.\n'
                        '- Keep an eye on your coin balance to maximize your playtime.',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Enjoy your gaming experience with Mystic Treasures Legends!',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
