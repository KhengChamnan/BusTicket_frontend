import 'package:citym/screens/bus_result/widgets/bus_schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citym/providers/bus_schedules_provider.dart';
import 'package:citym/providers/asyncvalue.dart';
import 'package:citym/models/bus_schedules.dart';

/// Section displaying upcoming journeys.
/// Shows a list of upcoming bus schedules.
class UpcomingJourneySection extends StatelessWidget {
  const UpcomingJourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 32, 22, 16),
          child: Text(
            'Upcoming Journey',
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF171F26),
              letterSpacing: -0.48,
            ),
          ),
        ),
        
        // List of upcoming bus schedules
        Consumer<BusSchedulesProvider>(
          builder: (context, provider, child) {
            final busSchedulesValue = provider.busSchedulesValue;
            
            // Show message if no schedules
            if (busSchedulesValue == null || 
                busSchedulesValue.state != AsyncValueState.success) {
              return Padding(
                padding: const EdgeInsets.all(22),
                child: Center(
                  child: Text(
                    'No upcoming journeys',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              );
            }
            
            final schedules = busSchedulesValue.data ?? [];
            
            if (schedules.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(22),
                child: Center(
                  child: Text(
                    'No upcoming journeys',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              );
            }
            
            return Column(
              children: schedules.map((schedule) {
                return BusScheduleCard(
                  schedule: schedule as BusSchedules,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

