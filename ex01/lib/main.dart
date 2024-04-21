import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainAppState extends ChangeNotifier {
  static const initialText = 'A  simple text';
  static const changedText = 'Hello World!';
  var labelText = initialText;
  var _isInitialText = true;

  void toggleText() {
    _isInitialText = !_isInitialText;
    if (_isInitialText) {
      labelText = changedText;
    } else {
      labelText = initialText;
    }
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp(
        title: 'Button App',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MainAppState>();
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
                child: Text(
                  appState.labelText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  appState.toggleText();
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
