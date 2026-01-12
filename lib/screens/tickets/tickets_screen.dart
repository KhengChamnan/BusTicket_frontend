import 'package:citym/screens/tickets/widgets/ticket_card.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:citym/providers/bus_booking_provider.dart';
import 'package:citym/providers/asyncvalue.dart';
import 'package:citym/widgets/display/bus_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Tickets history screen showing booking history.
/// Allows users to:
/// - View their past ticket bookings
/// - Access ticket details
/// - Reuse previous bookings
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BusBookingProvider>().getBookings();
    });
  }

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
      body: Consumer<BusBookingProvider>(
        builder: (context, provider, child) {
          final bookingsListValue = provider.bookingsListValue;

          // Handle loading state
          if (bookingsListValue?.state == AsyncValueState.loading) {
            return const Center(
              child: BusLoadingAnimation(),
            );
          }

          // Handle error state
          if (bookingsListValue?.state == AsyncValueState.error) {
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
                    'Error: ${bookingsListValue?.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.getBookings(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Handle success state
          if (bookingsListValue?.state == AsyncValueState.success) {
            final bookings = bookingsListValue?.data ?? [];

            if (bookings.isEmpty) {
              return Center(
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
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: BusbookingSpacings.xs,
                vertical: BusbookingSpacings.xs,
              ),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return TicketCard(booking: bookings[index]);
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
