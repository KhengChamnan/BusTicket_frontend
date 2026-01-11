import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';

/// Tickets history screen showing booking history.
/// Allows users to:
/// - View their past ticket bookings
/// - Access ticket details
/// - Reuse previous bookings
class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Tickets',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF171F26),
            letterSpacing: -0.48,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.confirmation_number_outlined,
                size: 80,
                color: BusbookingColors.borderLight,
              ),
              const SizedBox(height: 24),
              Text(
                'No tickets yet',
                style: BusbookingTextStyles.heading24SemiBold.copyWith(
                  color: BusbookingColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your ticket booking history will appear here',
                style: BusbookingTextStyles.body14Regular.copyWith(
                  color: BusbookingColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
