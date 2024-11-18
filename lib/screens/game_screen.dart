import 'package:flutter/material.dart';
import 'dart:math';
import 'package:guess_number/screens/result_screen.dart';

class GameScreen extends StatefulWidget {
  final int maxRange;
  final int maxAttempts;

  const GameScreen({
    super.key,
    required this.maxRange,
    required this.maxAttempts,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int _targetNumber;
  late int _remainingAttempts;
  final TextEditingController _guessController = TextEditingController();
  String? _feedback;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final random = Random();
    _targetNumber = random.nextInt(widget.maxRange) + 1;
    _remainingAttempts = widget.maxAttempts;
    _feedback = null;
    _guessController.clear();
  }

  void _handleGuess() {
    final guess = int.tryParse(_guessController.text);
    if (guess == null || guess < 1 || guess > widget.maxRange) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Введите число от 1 до ${widget.maxRange}'),
        ),
      );
      return;
    }

    setState(() {
      _remainingAttempts--;

      if (guess == _targetNumber) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              won: true,
              targetNumber: _targetNumber,
              maxRange: widget.maxRange,
              maxAttempts: widget.maxAttempts,
            ),
          ),
        );
      } else if (_remainingAttempts <= 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              won: false,
              targetNumber: _targetNumber,
              maxRange: widget.maxRange,
              maxAttempts: widget.maxAttempts,
            ),
          ),
        );
      } else {
        _feedback = guess < _targetNumber ? 'Слишком низко!' : 'Слишком высоко!';
        _guessController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Угадай число'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Осталось попыток: $_remainingAttempts',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            if (_feedback != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _feedback!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            TextField(
              controller: _guessController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Введите свое предположение',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleGuess,
              child: const Text('Отправить'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _guessController.dispose();
    super.dispose();
  }
}