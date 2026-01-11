import 'package:flutter/material.dart';
import 'package:citym/widgets/actions/busbooking_button.dart';
import 'package:citym/models/locations.dart';
import 'package:citym/data/dummydata/locations_dummy_data.dart';
import 'package:citym/theme/bus_booking_theme.dart';

/// Search form widget containing all input fields for bus route search.
/// Allows users to select origin, destination, date, and number of passengers.
class SearchForm extends StatelessWidget {
  final Location? selectedOrigin;
  final Location? selectedDestination;
  final DateTime? selectedDate;
  final Function(Location) onOriginChanged;
  final Function(Location) onDestinationChanged;
  final Function(DateTime) onDateChanged;
  final VoidCallback onSearch;

  const SearchForm({
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
        color: BusbookingColors.white,
        borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Leaving from field
          _buildLocationDropdown(
            label: 'Leaving from',
            hint: 'Select origin',
            icon: Icons.location_on_outlined,
            value: selectedOrigin,
            onChanged: onOriginChanged,
          ),
          const SizedBox(height: 16),
          
          // Going to field
          _buildLocationDropdown(
            label: 'Going to',
            hint: 'Select destination',
            icon: Icons.location_on,
            value: selectedDestination,
            onChanged: onDestinationChanged,
          ),
          const SizedBox(height: 16),
          
          // Date and Passengers row
          Row(
            children: [
              Expanded(
                child: _buildDateField(context),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 16),
          
          // Search button
          BusbookingButton(
            label: 'Search',
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }

  /// Builds a location dropdown field
  Widget _buildLocationDropdown({
    required String label,
    required String hint,
    required IconData icon,
    required Location? value,
    required Function(Location) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BusbookingTextStyles.label12Medium.copyWith(
            color: BusbookingColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: BusbookingColors.borderLight,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: BusbookingColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<Location>(
                  value: value,
                  hint: Text(
                    hint,
                    style: BusbookingTextStyles.body14Regular.copyWith(
                      color: BusbookingColors.textSecondary,
                    ),
                  ),
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: dummyLocations.map((location) {
                    return DropdownMenuItem<Location>(
                      value: location,
                      child: Text(
                        location.name,
                        style: BusbookingTextStyles.body14Regular.copyWith(
                          color: BusbookingColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (Location? newValue) {
                    if (newValue != null) {
                      onChanged(newValue);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the date field
  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: BusbookingTextStyles.label12Medium.copyWith(
            color: BusbookingColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: BusbookingColors.borderLight,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: BusbookingColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      onDateChanged(pickedDate);
                    }
                  },
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : 'Select date',
                    style: BusbookingTextStyles.body14Regular.copyWith(
                      color: selectedDate != null
                          ? BusbookingColors.textPrimary
                          : BusbookingColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  
}
