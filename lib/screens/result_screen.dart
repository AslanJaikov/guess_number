import 'package:flutter/material.dart';
import 'package:guess_number/screens/game_screen.dart';
import 'package:guess_number/screens/configuration_screen.dart';

class ResultScreen extends StatelessWidget {
  final bool won;
  final int targetNumber;
  final int maxRange;
  final int maxAttempts;

  const ResultScreen({
    super.key,
    required this.won,
    required this.targetNumber,
    required this.maxRange,
    required this.maxAttempts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: won ? Colors.green.shade50 : Colors.red.shade50,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                won ? Icons.celebration : Icons.sentiment_dissatisfied,
                size: 80,
                color: won ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                won ? 'Поздравляю!' : 'Игра окончена',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: won ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                won
                    ? 'Вы угадали!'
                    : 'Загаданное число: $targetNumber',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        maxRange: maxRange,
                        maxAttempts: maxAttempts,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: won ? Colors.green : Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Сыграть еще'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfigurationScreen(),
                    ),
                  );
                },
                child: const Text('Поменять настройки'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}