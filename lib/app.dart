import 'package:flutter/material.dart';
import 'package:shopping_list_app/pages/home.page.dart';

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groceries',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 84, 177, 201),
          brightness: Brightness.light,
          surface: const Color.fromARGB(255, 163, 196, 187),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 209, 234, 234),
      ),
      home: const HomePage(),
    );
  }
}
