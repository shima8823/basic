import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 108, 147, 10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'A  simple text',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                },
                child: const Text('Click me'),
              ),
            ],

        ),
      ),
    ),
    );
  }
}
