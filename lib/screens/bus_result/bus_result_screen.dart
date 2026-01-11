import 'package:citym/screens/bus_result/widgets/bus_schedule_card.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/bus_schedules.dart';
import '../../providers/bus_schedules_provider.dart';
import '../../providers/asyncvalue.dart';
import '../../widgets/display/bus_loading_animation.dart';

class BusResultScreen extends StatelessWidget {
  const BusResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Consumer<BusSchedulesProvider>(
        builder: (context, provider, child) {
          final busSchedulesValue = provider.busSchedulesValue;

          // Handle loading state
          if (busSchedulesValue?.state == AsyncValueState.loading) {
            return const Center(
              child: BusLoadingAnimation(),
            );
          }

          // Handle error state
          if (busSchedulesValue?.state == AsyncValueState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${busSchedulesValue?.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          // Handle success state
          if (busSchedulesValue?.state == AsyncValueState.success) {
            final schedules = busSchedulesValue?.data ?? [];

            if (schedules.isEmpty) {
              return const Center(
                child: Text('No buses found for your search'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: BusbookingSpacings.xs,
                vertical: BusbookingSpacings.xs,
              ),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return BusScheduleCard(
                  schedule: schedules[index] as BusSchedules,
                );
              },
            );
          }

          return const Center(
            child: Text('Unknown state'),
          );
        },
      ),
    );
  }
}

