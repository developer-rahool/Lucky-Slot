import 'package:flutter/material.dart';
import 'package:Lucky_Slot/aboutGame.dart';
import 'package:Lucky_Slot/howtouse.dart';
import 'package:Lucky_Slot/main.dart';
import 'package:Lucky_Slot/privacy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Lucky_Slot/quiz.dart';
import 'package:Lucky_Slot/slot_screen.dart';

// import 'package:slot_game/quiz_page.dart';
// import 'package:slot_game/slot_game_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int userCoins = 0;

  @override
  void initState() {
    super.initState();
    _initializeCoins();
  }

  void _initializeCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins = prefs.getInt('userCoins') ??
          100; // Default to 100 coins on first launch
    });
  }

  void _updateCoins(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCoins += amount;
      prefs.setInt('userCoins', userCoins);
    });
  }

  void _handleCoinsChange(int coins) {
    _updateCoins(coins);
  }

  void _showNoCoinsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not Enough Coins'),
          content: Text(
              'You need more coins to play. Please play the quiz to earn more coins.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          QuizPage(onCoinsChange: _handleCoinsChange)),
                );
              },
              child: Text('Play Quiz'),
            ),
          ],
        );
      },
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/mystical_background.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Mystic Treasures Legends',
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
                  SizedBox(
                    height: 50,
                  ),
                  Container(
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Total Remaining Coins',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.purpleAccent, blurRadius: 5)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '$userCoins',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                              shadows: [
                                Shadow(
                                    color: Colors.purpleAccent, blurRadius: 10)
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: userCoins >= 10
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                      onCoinsChange: _handleCoinsChange)),
                            );
                          }
                        : _showNoCoinsDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: Text('Play Slot Game',
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(onCoinsChange: _handleCoinsChange)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: Text('Play Quiz',
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HowToPlay()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: Text('How to play game',
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutGame()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: Text('About Game',
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: Text('Privacy Policy',
                        style: TextStyle(fontSize: 22, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
