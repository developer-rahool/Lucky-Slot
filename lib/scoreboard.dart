import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'slot_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import this if you need access to the Assets class for the image constants

class ScoreBoard extends StatefulWidget {
  final Function(int) onCoinsChange;
  const ScoreBoard({Key? key, required this.onCoinsChange}) : super(key: key);

  @override
  ScoreBoardState createState() => ScoreBoardState();
}

class ScoreBoardState extends State<ScoreBoard> {
  int _score = 0;

  List<Map<String, dynamic>> items = [
    {
      "name": "Better Luck next time",
      "value": 0,
      "image": "https://media.giphy.com/media/RAquh63pTB2PerLhud/giphy.gif",
      "coupon": "No Coupon"
    },
    {
      "name": "10 Points",
      "value": 10,
      "image":
          "https://www.freepnglogos.com/uploads/flipkart-logo-hd-png-15.png",
      "coupon": "FLIPKART10"
    },
    {
      "name": "20 Points",
      "value": 20,
      "image":
          "https://www.freepnglogos.com/uploads/logo-myntra-png/myntra-logo-myntra-logo-images-10.png",
      "coupon": "MYNTRA20"
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void updateScore(List<String> images) {
    Map<String, int> imageCounts = {};
    for (String image in images) {
      imageCounts[image] = (imageCounts[image] ?? 0) + 1;
    }

    int points = imageCounts.values.any((count) => count == 3) ? 50 : 0;

    setState(() {
      _score += points;
    });

    widget.onCoinsChange(points);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  points == 0
                      ? 'assets/images/losing_animation.gif'
                      : 'assets/images/winning.gif',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  points == 0 ? 'Better luck next time!' : 'You Won!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: points == 0 ? Colors.red : Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  points == 0 ? items[0]['name'] : items[2]['name'],
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  points == 0 ? '-10' : '+$points',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: points == 0 ? Colors.red : Colors.green,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Play Again",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int calculatePoints(List<String> images) {
    Map<String, int> imageCounts = {};
    for (String image in images) {
      imageCounts[image] = (imageCounts[image] ?? 0) + 1;
    }

    int points = 0;
    if (imageCounts.values.any((count) => count == 3)) {
      points = 50;
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black,
        // borderRadius:const  BorderRadius.only(
        //   topLeft: Radius.circular(50.0),
        //   topRight: Radius.circular(50.0),
        // ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3.0,
          color: Colors.purpleAccent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent,
            blurRadius: 15.0,
            spreadRadius: 0.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Current Coins',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$_score',
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 235, 119),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
