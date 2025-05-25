import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
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
      child: NeumorphicApp(
        title: 'CARMORI - 자동차 피크닉 장소 추천',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: const NeumorphicThemeData(
          baseColor: Color(0xFFF0F0F0),
          lightSource: LightSource.topLeft,
          depth: 10,
          intensity: 0.5,
        ),
        darkTheme: const NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 6,
          intensity: 0.3,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
