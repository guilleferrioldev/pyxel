import 'package:flutter/material.dart';
import 'package:pokedex/config/theme/app_theme.dart';
import 'package:pokedex/presentation/screens/pokemons_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      home: PokemonScreen(),
    );
  }
}
