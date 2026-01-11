import 'package:flutter/material.dart';
import 'package:citym/screens/search/widgets/search_form.dart';
import 'package:citym/models/locations.dart';
import 'package:citym/theme/bus_booking_theme.dart';

/// Top section of the search screen.
/// Contains the welcome title and the search form.
class SearchTopSection extends StatelessWidget {
  final Location? selectedOrigin;
  final Location? selectedDestination;
  final DateTime? selectedDate;
  final Function(Location) onOriginChanged;
  final Function(Location) onDestinationChanged;
  final Function(DateTime) onDateChanged;
  final VoidCallback onSearch;

  const SearchTopSection({
    super.key,
    required this.selectedOrigin,
    required this.selectedDestination,
    required this.selectedDate,
    required this.onOriginChanged,
    required this.onDestinationChanged,
    required this.onDateChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BusbookingColors.backgroundGrey,
        borderRadius: BorderRadius.circular(BusbookingSpacings.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Welcome to my Bus Booking App',
                    style: BusbookingTextStyles.heading24SemiBold.copyWith(
                      color: BusbookingColors.textPrimary,
                      letterSpacing: -0.48,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Search form
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: SearchForm(
              selectedOrigin: selectedOrigin,
              selectedDestination: selectedDestination,
              selectedDate: selectedDate,
              onOriginChanged: onOriginChanged,
              onDestinationChanged: onDestinationChanged,
              onDateChanged: onDateChanged,
              onSearch: onSearch,
            ),
          ),
        ],
      ),
    );
  }
}
