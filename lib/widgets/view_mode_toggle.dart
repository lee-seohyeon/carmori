import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ViewModeToggle extends StatelessWidget {
  const ViewModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
            depth: 6,
            lightSource: LightSource.topLeft,
            color: NeumorphicTheme.baseColor(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ViewModeButton(
                icon: Icons.list,
                isSelected: provider.viewMode == ViewMode.list,
                onTap: () => provider.setViewMode(ViewMode.list),
              ),
              _ViewModeButton(
                icon: Icons.map,
                isSelected: provider.viewMode == ViewMode.map,
                onTap: () => provider.setViewMode(ViewMode.map),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModeButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewModeButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: NeumorphicButton(
        onPressed: onTap,
        style: NeumorphicStyle(
          shape: isSelected ? NeumorphicShape.concave : NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          depth: isSelected ? -4 : 2,
          lightSource: LightSource.topLeft,
          color: isSelected ? NeumorphicTheme.accentColor(context) : NeumorphicTheme.baseColor(context),
        ),
        padding: const EdgeInsets.all(12),
        child: NeumorphicIcon(
          icon,
          style: NeumorphicStyle(
            depth: 2,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
          size: 20,
        ),
      ),
    );
  }
} 