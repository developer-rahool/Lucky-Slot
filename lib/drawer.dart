import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Lucky_Slot/calculations/calculation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aboutGame.dart';
import 'howtouse.dart';
import 'privacy_policy.dart';
import 'quiz.dart';
import 'slot_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int userCoins = 0;
  double heightPadding = 10;
  double radiusValue = 20;

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

  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                  // border: Border.all(color: Colors.amber, width: 2),
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
                            Shadow(color: Colors.purpleAccent, blurRadius: 5)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$userCoins',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          shadows: [
                            Shadow(color: Colors.purpleAccent, blurRadius: 10)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              HeightPadd(),
              Container(
                height: 4,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber),
              ),
              HeightPadd(),
              DrawerButton(
                onTap: userCoins >= 10
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  onCoinsChange: _handleCoinsChange)),
                        );
                      }
                    : _showNoCoinsDialog,
                text: "Play Slot Game",
              ),
              //
              // ElevatedButton(
              //   onPressed: userCoins >= 10
              //       ? () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) =>
              //                     MyHomePage(onCoinsChange: _handleCoinsChange)),
              //           );
              //         }
              //       : _showNoCoinsDialog,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.amber,
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 50, vertical: heightPadding),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(radiusValue)),
              //     elevation: 5,
              //   ),
              //   child: Text('Play Slot Game',
              //       style: TextStyle(fontSize: 22, color: Colors.black)),
              // ),
              HeightPadd(),
              DrawerButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizPage(onCoinsChange: _handleCoinsChange)),
                  );
                },
                text: "Play Quiz",
                shadowColor: Colors.greenAccent.withOpacity(0.5),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               QuizPage(onCoinsChange: _handleCoinsChange)),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.greenAccent,
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 50, vertical: heightPadding),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(radiusValue)),
              //     elevation: 5,
              //   ),
              //   child: Text('Play Quiz',
              //       style: TextStyle(fontSize: 22, color: Colors.black)),
              // ),
              HeightPadd(),
              DrawerButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalculationScreen()),
                  );
                },
                text: "Statistics & Probability",
                shadowColor: Colors.orangeAccent.withOpacity(0.5),
              ),
              HeightPadd(),
              DrawerButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HowToPlay()),
                  );
                },
                text: "How to play game",
                shadowColor: Colors.blueAccent.withOpacity(0.5),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => HowToPlay()),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blueAccent,
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 50, vertical: heightPadding),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(radiusValue)),
              //     elevation: 5,
              //   ),
              //   child: Text('How to play game',
              //       style: TextStyle(fontSize: 22, color: Colors.black)),
              // ),
              HeightPadd(),
              DrawerButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutGame()),
                  );
                },
                text: "About Game",
                shadowColor: Colors.green.withOpacity(0.5),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AboutGame()),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.green,
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 50, vertical: heightPadding),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(radiusValue)),
              //     elevation: 5,
              //   ),
              //   child: Text('About Game',
              //       style: TextStyle(fontSize: 22, color: Colors.black)),
              // ),
              HeightPadd(),
              DrawerButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                  );
                },
                text: "Privacy Policy",
                shadowColor: Colors.red.withOpacity(0.5),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 50, vertical: heightPadding),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(radiusValue)),
              //     elevation: 5,
              //   ),
              //   child: Text('Privacy Policy',
              //       style: TextStyle(fontSize: 22, color: Colors.black)),
              // ),
            ],
          ),
        ) //ListView
        );
  }
}

class HeightPadd extends StatelessWidget {
  const HeightPadd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 35);
  }
}

class DrawerButton extends StatelessWidget {
  String text;
  Color? shadowColor;
  Function() onTap;

  DrawerButton(
      {super.key, required this.text, required this.onTap, this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(color: Colors.amber, width: 2),
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.amber.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child:
              Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}
