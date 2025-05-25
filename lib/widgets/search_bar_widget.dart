import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
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
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: -4,
        lightSource: LightSource.topLeft,
        color: NeumorphicTheme.baseColor(context),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          context.read<AppProvider>().setSearchQuery(value);
        },
                  decoration: InputDecoration(
            hintText: '장소명, 주소, 특징으로 검색...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: NeumorphicIcon(
              Icons.search,
              style: NeumorphicStyle(
                depth: 2,
                color: Colors.grey[600],
              ),
              size: 20,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? NeumorphicButton(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: const NeumorphicBoxShape.circle(),
                      depth: 2,
                    ),
                    padding: const EdgeInsets.all(8),
                    onPressed: () {
                      _controller.clear();
                      context.read<AppProvider>().setSearchQuery('');
                    },
                    child: Icon(Icons.clear, color: Colors.grey[600], size: 16),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
          ),
      ),
    );
  }
} 