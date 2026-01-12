import 'package:citym/models/bus_booking.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketDetailsScreen extends StatelessWidget {
  final BusBooking booking;

  const TicketDetailsScreen({super.key, required this.booking});

  static final _dateFormat = DateFormat('MMM dd, yyyy');
  static final _timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BusbookingColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: BusbookingColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: BusbookingColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ticket Details',
          style: BusbookingTextStyles.heading24SemiBold.copyWith(
            fontSize: 18,
            color: BusbookingColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BusbookingSpacings.lg),
          child: Column(
            children: [
              _buildHeaderSection(),
              const SizedBox(height: BusbookingSpacings.lg),
              _buildPassengerInfoSection(),
              const SizedBox(height: BusbookingSpacings.lg),
              _buildRouteDetailsSection(),
              const SizedBox(height: BusbookingSpacings.lg),
              _buildPaymentSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BusbookingColors.white,
        border: Border.all(color: BusbookingColors.borderLight),
        borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
      ),
      padding: const EdgeInsets.all(BusbookingSpacings.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking #${booking.id}',
                style: BusbookingTextStyles.heading24SemiBold.copyWith(
                  fontSize: 20,
                  color: BusbookingColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BusbookingSpacings.md,
                  vertical: BusbookingSpacings.xs + 2,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(booking.status),
                  borderRadius: BorderRadius.circular(BusbookingSpacings.xs),
                ),
                child: Text(
                  (booking.status ?? 'Pending').toUpperCase(),
                  style: BusbookingTextStyles.label12Medium.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: BusbookingColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BusbookingSpacings.md),
          Container(
            padding: const EdgeInsets.all(BusbookingSpacings.md),
            decoration: BoxDecoration(
              color: BusbookingColors.backgroundGrey,
              borderRadius: BorderRadius.circular(BusbookingSpacings.xs + 2),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: BusbookingSize.icon - 4,
                  color: BusbookingColors.blue500,
                ),
                const SizedBox(width: BusbookingSpacings.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.departureTime != null
                            ? _dateFormat.format(booking.departureTime!)
                            : 'N/A',
                        style: BusbookingTextStyles.body14Medium.copyWith(
                          color: BusbookingColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        booking.departureTime != null
                            ? _timeFormat.format(booking.departureTime!)
                            : 'N/A',
                        style: BusbookingTextStyles.label12Medium.copyWith(
                          color: BusbookingColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerInfoSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BusbookingColors.white,
        border: Border.all(color: BusbookingColors.borderLight),
        borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
      ),
      padding: const EdgeInsets.all(BusbookingSpacings.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Passenger Information',
            style: BusbookingTextStyles.body16Regular.copyWith(
              fontWeight: FontWeight.w600,
              color: BusbookingColors.textPrimary,
            ),
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.person_outline,
            'Passenger Name',
            booking.passengerName ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.email_outlined,
            'Email',
            booking.passengerEmail ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.phone_outlined,
            'Phone Number',
            booking.passengerPhoneNumber ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.event_seat_outlined,
            'Number of Seats',
            '${booking.numberOfSeats ?? 'N/A'}',
          ),
        ],
      ),
    );
  }

  Widget _buildRouteDetailsSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BusbookingColors.white,
        border: Border.all(color: BusbookingColors.borderLight),
        borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
      ),
      padding: const EdgeInsets.all(BusbookingSpacings.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Route Details',
            style: BusbookingTextStyles.body16Regular.copyWith(
              fontWeight: FontWeight.w600,
              color: BusbookingColors.textPrimary,
            ),
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.trip_origin,
            'Origin',
            booking.origin ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.location_on_outlined,
            'Destination',
            booking.destination ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.directions_bus_outlined,
            'Bus',
            booking.bus ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BusbookingColors.white,
        border: Border.all(color: BusbookingColors.borderLight),
        borderRadius: BorderRadius.circular(BusbookingSpacings.radius),
      ),
      padding: const EdgeInsets.all(BusbookingSpacings.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Information',
            style: BusbookingTextStyles.body16Regular.copyWith(
              fontWeight: FontWeight.w600,
              color: BusbookingColors.textPrimary,
            ),
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.payment_outlined,
            'Payment Method',
            booking.paymentMethod ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.attach_money,
            'Amount',
            booking.paymentAmount ?? 'N/A',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.check_circle_outline,
            'Payment Status',
            booking.paymentStatus ?? 'N/A',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: BusbookingSize.icon - 4,
          color: BusbookingColors.textSecondary,
        ),
        const SizedBox(width: BusbookingSpacings.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: BusbookingTextStyles.label12Medium.copyWith(
                  color: BusbookingColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: BusbookingTextStyles.body14Medium.copyWith(
                  color: BusbookingColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
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
