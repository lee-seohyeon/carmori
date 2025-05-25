import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF007AFF),
                ),
              );
            }

            return Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar with Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'CARMORI',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1C1C1E),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const ViewModeToggle(),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Search Bar
                      const SearchBarWidget(),
                      const SizedBox(height: 20),
                      
                      // Filter Chips
                      const FilterChips(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                
                // Content
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: provider.viewMode == ViewMode.list
                          ? const SpotListView()
                          : const SpotMapView(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
} 