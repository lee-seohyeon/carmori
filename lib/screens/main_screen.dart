import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'home_screen.dart';
import 'empty_screen.dart';
import 'meal_calculator_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const EmptyScreen(),
    const MealCalculatorScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: HeroIcons.mapPin,
      activeIcon: HeroIcons.mapPin,
      label: '장소',
    ),
    NavigationItem(
      icon: HeroIcons.squares2x2,
      activeIcon: HeroIcons.squares2x2,
      label: '더보기',
    ),
    NavigationItem(
      icon: HeroIcons.calculator,
      activeIcon: HeroIcons.calculator,
      label: '계산기',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 84,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navigationItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = _currentIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.black.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: HeroIcon(
                            isSelected ? item.activeIcon : item.icon,
                            style: HeroIconStyle.outline,
                            size: 24,
                            color: isSelected ? Colors.black : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected ? Colors.black : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final HeroIcons icon;
  final HeroIcons activeIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
} 