import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:citym/screens/search/search_screen.dart';
import 'package:citym/screens/tickets/tickets_screen.dart';
import 'package:citym/screens/profile/profile_screen.dart';

/// Main navigation screen with bottom tab bar.
/// Allows users to:
/// - Search for bus tickets
/// - View ticket booking history
/// - Access user profile
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SearchScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.search,
                  label: 'Search',
                  index: 0,
                  isSelected: _currentIndex == 0,
                ),
                _buildNavItem(
                  icon: Icons.confirmation_number_outlined,
                  label: 'Tickets',
                  index: 1,
                  isSelected: _currentIndex == 1,
                ),
                _buildNavItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  index: 2,
                  isSelected: _currentIndex == 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a navigation item for the bottom bar
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected ? const Color(0xFF154CE4) : BusbookingColors.textPrimary,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: BusbookingTextStyles.label12SemiBold.copyWith(
              color: isSelected ? const Color(0xFF154CE4) : BusbookingColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
