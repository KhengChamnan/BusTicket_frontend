import 'package:citym/models/bus_booking.dart';
import 'package:citym/screens/tickets/ticket_details_screen.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:citym/utils/animation_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketCard extends StatelessWidget {
  final BusBooking booking;

  const TicketCard({super.key, required this.booking});

  static final _dateFormat = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          AnimationUtils.createBottomToTopRoute(
            TicketDetailsScreen(booking: booking),
          ),
        );
      },
      borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: BusbookingSpacings.xs + 2,
          vertical: BusbookingSpacings.xs,
        ),
        decoration: BoxDecoration(
          color: BusbookingColors.white,
          border: Border.all(color: BusbookingColors.borderLight),
          borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
        ),
        padding: const EdgeInsets.all(BusbookingSpacings.xs),
        child: Column(
          children: [
            _buildHeaderSection(),
            const SizedBox(height: BusbookingSpacings.xs),
            _buildDetailsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      decoration: BoxDecoration(
        color: BusbookingColors.backgroundGrey,
        borderRadius: BorderRadius.circular(BusbookingSpacings.md),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: BusbookingSpacings.lg,
        vertical: BusbookingSpacings.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking #${booking.id}',
                style: BusbookingTextStyles.label12SemiBold.copyWith(
                  color: BusbookingColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                booking.departureTime != null
                    ? _dateFormat.format(booking.departureTime!)
                    : 'Date not set',
                style: BusbookingTextStyles.label12Medium.copyWith(
                  fontSize: 10,
                  color: BusbookingColors.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BusbookingSpacings.md,
              vertical: BusbookingSpacings.xs,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(booking.status),
              borderRadius: BorderRadius.circular(BusbookingSpacings.xs),
            ),
            child: Text(
              (booking.status ?? 'Pending').toUpperCase(),
              style: BusbookingTextStyles.label12Medium.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: BusbookingColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

 

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BusbookingSpacings.lg,
        vertical: BusbookingSpacings.md,
      ),
      child: Column(
        children: [
          // Location route
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: BusbookingSize.icon,
                color: BusbookingColors.textSecondary,
              ),
              const SizedBox(width: BusbookingSpacings.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.origin ?? 'Origin not set',
                      style: BusbookingTextStyles.label12SemiBold.copyWith(
                        color: BusbookingColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Start location',
                      style: BusbookingTextStyles.label12Medium.copyWith(
                        fontSize: 10,
                        color: BusbookingColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: BusbookingSize.icon,
                color: BusbookingColors.textSecondary,
              ),
              const SizedBox(width: BusbookingSpacings.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      booking.destination ?? 'Destination not set',
                      style: BusbookingTextStyles.label12SemiBold.copyWith(
                        color: BusbookingColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Stop location',
                      style: BusbookingTextStyles.label12Medium.copyWith(
                        fontSize: 10,
                        color: BusbookingColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BusbookingSpacings.md),
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: BusbookingSize.icon,
                color: BusbookingColors.textSecondary,
              ),
              const SizedBox(width: BusbookingSpacings.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.passengerName ?? 'Guest',
                      style: BusbookingTextStyles.label12SemiBold.copyWith(
                        color: BusbookingColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${booking.numberOfSeats ?? 1} seat${(booking.numberOfSeats ?? 1) > 1 ? 's' : ''} • ${booking.bus ?? 'N/A'}',
                      style: BusbookingTextStyles.label12Medium.copyWith(
                        fontSize: 10,
                        color: BusbookingColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return BusbookingColors.textSecondary;
    
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'completed':
        return BusbookingColors.blue500;
      case 'pending':
        return BusbookingColors.textSecondary;
      case 'cancelled':
        return BusbookingColors.textSecondary.withOpacity(0.5);
      default:
        return BusbookingColors.textSecondary;
    }
  }
}


