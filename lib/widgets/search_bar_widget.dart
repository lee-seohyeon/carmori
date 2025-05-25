import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {
          context.read<AppProvider>().setSearchQuery(value);
        },
        decoration: InputDecoration(
          hintText: '장소를 검색해보세요',
          hintStyle: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: HeroIcon(
              HeroIcons.magnifyingGlass,
              style: HeroIconStyle.outline,
              color: Colors.black,
              size: 20,
            ),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _controller.clear();
                    context.read<AppProvider>().setSearchQuery('');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: HeroIcon(
                      HeroIcons.xMark,
                      style: HeroIconStyle.outline,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
} 