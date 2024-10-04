import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Lucky_Slot/calculations/app_textfieldformfield.dart';
import '../main.dart';

class CalculationScreen extends StatefulWidget {
  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  final _formKeyMean = GlobalKey<FormState>();
  final _formKeyMedian = GlobalKey<FormState>();
  final _formKeyBinomialProbability = GlobalKey<FormState>();

  final _numbersControllerMean = TextEditingController();
  final _numbersControllerMedian = TextEditingController();

  String _resultMean = '';
  String _resultMedian = '';
  String _resultBinomialProbability = '';
  //
  final _trialsController = TextEditingController();
  final _successesController = TextEditingController();
  final _probabilityController = TextEditingController();

  void _calculateMean() {
    List<double> numbers = _numbersControllerMean.text
        .split(',')
        .map((e) => double.tryParse(e.trim()) ?? 0.0)
        .toList();
    double mean = calculateMean(numbers);
    setState(() {
      _resultMean = 'Mean: $mean';
    });
  }

  // Define other calculation methods here...

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
          'Statistics & Probability',
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
          padding: EdgeInsets.all(20.0),
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
                    Form(
                      key: _formKeyMean,
                      child: Column(
                        children: <Widget>[
                          AppTextFormField(
                            appController: _numbersControllerMean,
                            radius: 15,
                            hintText: 'e.g: 1,2,3,... ',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some numbers';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //shadowColor: Colors.white,
                              // elevation: 5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                            onPressed: () {
                              if (_formKeyMean.currentState!.validate()) {
                                _calculateMean();
                                // _numbersController.clear();
                              }
                            },
                            child: const Text('Calculate Mean',
                                style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          // Add more buttons for other calculations...
                          SizedBox(height: 20),
                          Text(
                            _resultMean,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 4,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.amber),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //Median
                    Form(
                      key: _formKeyMedian,
                      child: Column(
                        children: <Widget>[
                          AppTextFormField(
                            appController: _numbersControllerMedian,
                            radius: 15,
                            hintText: 'e.g: 1,2,3,... ',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some numbers';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //shadowColor: Colors.white,
                              // elevation: 5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                            onPressed: _calculateMedian,
                            child: Text('Calculate Median',
                                style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          SizedBox(height: 20),
                          Text(
                            _resultMedian,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    //Bio
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 4,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.amber),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKeyBinomialProbability,
                      child: Column(
                        children: <Widget>[
                          AppTextFormField(
                            appController: _trialsController,
                            radius: 15,
                            hintText: 'Number of Trials',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter number of trials';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppTextFormField(
                            appController: _successesController,
                            radius: 15,
                            hintText: 'Number of Success',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter number of Success';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppTextFormField(
                            appController: _probabilityController,
                            radius: 15,
                            hintText: 'Probability of Success',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter probability of Success';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //shadowColor: Colors.white,
                              // elevation: 5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                            onPressed: _calculateBinomialProbability,
                            child: Text('Calculate Binomial Probability',
                                style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          SizedBox(height: 20),
                          Text(
                            _resultBinomialProbability,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Mean
  double calculateMean(List<double> numbers) {
    double sum = numbers.reduce((a, b) => a + b);
    return sum / numbers.length;
  }

  //Median
  void _calculateMedian() {
    if (_formKeyMedian.currentState!.validate()) {
      List<double> numbers = _numbersControllerMedian.text
          .split(',')
          .map((e) => double.tryParse(e.trim()) ?? 0.0)
          .toList();
      double median = calculateMedian(numbers);
      setState(() {
        _resultMedian = 'Median: $median';
      });
    }
  }

  double calculateMedian(List<double> numbers) {
    numbers.sort();
    int middleIndex = numbers.length ~/ 2;

    if (numbers.length % 2 == 1) {
      return numbers[middleIndex];
    } else {
      return (numbers[middleIndex - 1] + numbers[middleIndex]) / 2;
    }
  }

  //BinomialProbability
  void _calculateBinomialProbability() {
    if (_formKeyBinomialProbability.currentState!.validate()) {
      int numberOfTrials = int.tryParse(_trialsController.text) ?? 0;
      int numberOfSuccesses = int.tryParse(_successesController.text) ?? 0;
      double probabilityOfSuccess =
          double.tryParse(_probabilityController.text) ?? 0.0;

      double result = calculateBinomialProbability(
          numberOfTrials, numberOfSuccesses, probabilityOfSuccess);
      setState(() {
        _resultBinomialProbability = 'Binomial Probability: $result';
      });
    }
  }

  calculateBinomialProbability(
      int numberOfTrials, int numberOfSuccesses, double probabilityOfSuccess) {
    int binomialCoefficient(int n, int k) {
      if (k == 0 || k == n) return 1;
      if (k > n - k) k = n - k;
      int c = 1;
      for (int i = 0; i < k; i++) {
        c = c * (n - i) ~/ (i + 1);
      }
      return c;
    }

    num probability = binomialCoefficient(numberOfTrials, numberOfSuccesses) *
        pow(probabilityOfSuccess, numberOfSuccesses) *
        pow(1 - probabilityOfSuccess, numberOfTrials - numberOfSuccesses);

    return probability;
  }
}
