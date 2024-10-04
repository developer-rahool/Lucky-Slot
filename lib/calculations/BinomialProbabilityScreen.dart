import 'package:flutter/material.dart';
import 'dart:math'; // Importing the math library

class BinomialProbabilityScreen extends StatefulWidget {
  @override
  _BinomialProbabilityScreenState createState() =>
      _BinomialProbabilityScreenState();
}

class _BinomialProbabilityScreenState extends State<BinomialProbabilityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _trialsController = TextEditingController();
  final _successesController = TextEditingController();
  final _probabilityController = TextEditingController();
  String _result = '';

  void _calculateBinomialProbability() {
    if (_formKey.currentState!.validate()) {
      int numberOfTrials = int.tryParse(_trialsController.text) ?? 0;
      int numberOfSuccesses = int.tryParse(_successesController.text) ?? 0;
      double probabilityOfSuccess =
          double.tryParse(_probabilityController.text) ?? 0.0;

      double result = calculateBinomialProbability(
          numberOfTrials, numberOfSuccesses, probabilityOfSuccess);
      setState(() {
        _result = 'Binomial Probability: $result';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _trialsController,
              decoration: InputDecoration(labelText: 'Number of Trials'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter number of trials';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _successesController,
              decoration: InputDecoration(labelText: 'Number of Successes'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter number of successes';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _probabilityController,
              decoration: InputDecoration(labelText: 'Probability of Success'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter probability of success';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBinomialProbability,
              child: Text('Calculate Binomial Probability'),
            ),
            SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
