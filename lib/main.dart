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
            displayMedium: TextStyle(
              color: Color(0xFF232B55),
            ),
            displaySmall: TextStyle(
              color: Color(0xFF232B55),
            ),
            headlineSmall: TextStyle(
              color: Color(0xFF232B55),
            )),
        cardColor: Colors.black,
        colorScheme: const ColorScheme(
          background: Colors.white,
          brightness: Brightness.light,
          primary: Color(0xFFD38E94),
          onPrimary: Color(0xFFF4EDDB),
          secondary: Colors.black,
          onSecondary: Colors.brown,
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
