import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CarmoriApp());
}

class CarmoriApp extends StatelessWidget {
  const CarmoriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'CARMORI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            secondary: Colors.black,
            surface: Colors.white,
            background: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
