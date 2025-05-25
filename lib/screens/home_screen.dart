import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_chips.dart';
import '../widgets/view_mode_toggle.dart';
import '../widgets/spot_list_view.dart';
import '../widgets/spot_map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Consumer<AppProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  // Header
                  Neumorphic(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                      depth: 8,
                      lightSource: LightSource.topLeft,
                      color: NeumorphicTheme.baseColor(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NeumorphicText(
                                    'CARMORI',
                                    style: NeumorphicStyle(
                                      depth: 4,
                                      color: NeumorphicTheme.baseColor(context),
                                    ),
                                    textStyle: NeumorphicTextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '자동차 피크닉 장소 추천',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const ViewModeToggle(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const SearchBarWidget(),
                        const SizedBox(height: 16),
                        const FilterChips(),
                      ],
                    ),
                  ),
                  
                  // Content
                  Expanded(
                    child: provider.viewMode == ViewMode.list
                        ? const SpotListView()
                        : const SpotMapView(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
} 