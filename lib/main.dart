import 'package:flutter/material.dart';
import 'package:metronome_app/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
        colorScheme: const ColorScheme(
          background: Colors.black,
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 182, 21, 152),
          onPrimary: Color(0xFFF4EDDB),
          secondary: Color.fromARGB(255, 49, 70, 177),
          onSecondary: Color(0xFFF4EDDB),
          error: Color(0xFFE7626C),
          onError: Color(0xFFF4EDDB),
          onBackground: Color(0xFFF4EDDB),
          surface: Color(0xFFF4EDDB),
          onSurface: Color(0xFFF4EDDB),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
