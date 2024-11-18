import 'package:flutter/material.dart';
import 'package:guess_number/screens/game_screen.dart';


class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final TextEditingController _rangeController = TextEditingController();
  final TextEditingController _attemptsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки игры'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _rangeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Максммальное число (n)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _attemptsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Количество попыток (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final range = int.tryParse(_rangeController.text);
                final attempts = int.tryParse(_attemptsController.text);

                if (range != null && attempts != null && range > 0 && attempts > 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        maxRange: range,
                        maxAttempts: attempts,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Введите допустимое положительное число.'),
                    ),
                  );
                }
              },
              child: const Text('Начать игру'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rangeController.dispose();
    _attemptsController.dispose();
    super.dispose();
  }
}