import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citym/screens/search/widgets/search_top_section.dart';
import 'package:citym/screens/search/widgets/search_recently_searched_section.dart';
import 'package:citym/providers/bus_schedules_provider.dart';
import 'package:citym/models/locations.dart';
import 'package:citym/widgets/notifications/busbooking_snackbar.dart';

/// Search screen for finding bus tickets.
/// Allows users to:
/// - Search for bus routes by origin and destination
/// - Select travel dates and number of passengers
/// - View recently searched routes
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Location? _selectedOrigin;
  Location? _selectedDestination;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section with search form
                SearchTopSection(
                  selectedOrigin: _selectedOrigin,
                  selectedDestination: _selectedDestination,
                  selectedDate: _selectedDate,
                  onOriginChanged: (location) {
                    setState(() => _selectedOrigin = location);
                  },
                  onDestinationChanged: (location) {
                    setState(() => _selectedDestination = location);
                  },
                  onDateChanged: (date) {
                    setState(() => _selectedDate = date);
                  },
                 
                  onSearch: _handleSearch,
                ),
                
                // Recently searched section
                const SearchRecentlySearchedSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Handles search button press using the provider
  void _handleSearch() {
    if (_selectedOrigin == null || _selectedDestination == null || _selectedDate == null) {
      BusbookingSnackbar.showWarning(
        context,
        'Please fill in all fields',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    final busSchedulesProvider = context.read<BusSchedulesProvider>();
    
    Navigator.pushNamed(context, '/bus-result');
    
    // Fetch in background
    busSchedulesProvider.fetchBusSchedules(
      originId: _selectedOrigin!.id,
      destinationId: _selectedDestination!.id,
      date: _selectedDate!,
    );
  }
}
