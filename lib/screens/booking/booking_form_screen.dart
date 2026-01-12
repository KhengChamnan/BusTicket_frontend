import 'package:citym/models/bus_schedules.dart';
import 'package:citym/providers/bus_booking_provider.dart';
import 'package:citym/providers/user_profile_provider.dart';
import 'package:citym/screens/booking/widgets/seat_stepper.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:citym/widgets/actions/busbooking_button.dart';
import 'package:citym/widgets/display/bus_loading_animation.dart';
import 'package:citym/widgets/inputs/busbooking_text_input.dart';
import 'package:citym/widgets/notifications/busbooking_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingFormScreen extends StatefulWidget {
  final BusSchedules schedule;

  const BookingFormScreen({super.key, required this.schedule});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  int _numberOfSeats = 1;
  bool _isSubmitting = false;

  static final _dateFormat = DateFormat('MMM dd, yyyy');
  static final _timeFormat = DateFormat('hh:mm a');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  double get _totalPrice => widget.schedule.seatPrice * _numberOfSeats;

  bool _validateForm() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      BusbookingSnackbar.showWarning(context, 'Please enter passenger name');
      return false;
    }

    if (email.isEmpty) {
      BusbookingSnackbar.showWarning(context, 'Please enter email address');
      return false;
    }

    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      BusbookingSnackbar.showWarning(context, 'Please enter a valid email address');
      return false;
    }

    if (phone.isEmpty) {
      BusbookingSnackbar.showWarning(context, 'Please enter phone number');
      return false;
    }

    

    if (_numberOfSeats < 1 || _numberOfSeats > widget.schedule.availableSeats) {
      BusbookingSnackbar.showWarning(
        context,
        'Number of seats must be between 1 and ${widget.schedule.availableSeats}',
      );
      return false;
    }

    return true;
  }

  Future<void> _submitBooking() async {
    if (!_validateForm()) return;

    setState(() {
      _isSubmitting = true;
    });

    final provider = Provider.of<BusBookingProvider>(context, listen: false);
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);

    try {
      final result = await provider.createBooking(
        busScheduleId: widget.schedule.id,
        passengerName: _nameController.text.trim(),
        passengerEmail: _emailController.text.trim(),
        numberOfSeats: _numberOfSeats,
        passengerPhoneNumber: _phoneController.text.trim(),
      );

      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        if (result['success'] == true) {
          // Refresh user profile to update credit balance
          await userProfileProvider.getUserProfile();
          
          BusbookingSnackbar.showSuccess(
            context,
            'Booking created successfully!',
          );
          Navigator.pop(context);
        } else {
          BusbookingSnackbar.showError(
            context,
            result['message'] ?? 'Failed to create booking',
          );
        }
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        BusbookingSnackbar.showError(
          context,
          'Failed to create booking: ${error.toString()}',
        );
      }
    }
  }

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
          'Book Ticket',
          style: BusbookingTextStyles.heading24SemiBold.copyWith(
            fontSize: 18,
            color: BusbookingColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: _isSubmitting
          ? const Center(
              child: BusLoadingAnimation(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(BusbookingSpacings.lg),
                child: Column(
                  children: [
                    _buildRouteInfoSection(),
                    const SizedBox(height: BusbookingSpacings.lg),
                    _buildPassengerInfoSection(),
                    const SizedBox(height: BusbookingSpacings.lg),
                    _buildSeatsSection(),
                    const SizedBox(height: BusbookingSpacings.xl),
                    BusbookingButton(
                      label: 'Confirm Booking',
                      onPressed: _submitBooking,
                    ),
                    const SizedBox(height: BusbookingSpacings.lg),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildRouteInfoSection() {
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
            Icons.location_on_outlined,
            'From',
            widget.schedule.route.origin,
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.location_on_outlined,
            'To',
            widget.schedule.route.destination,
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.calendar_today,
            'Departure',
            '${_dateFormat.format(widget.schedule.departureTime)} at ${_timeFormat.format(widget.schedule.departureTime)}',
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.directions_bus_outlined,
            'Bus',
            widget.schedule.bus.plateNumber,
          ),
          const SizedBox(height: BusbookingSpacings.md),
          _buildInfoRow(
            Icons.event_seat_outlined,
            'Available Seats',
            '${widget.schedule.availableSeats}',
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
          const SizedBox(height: BusbookingSpacings.lg),
          BusbookingTextInput(
            label: 'Full Name',
            placeholder: 'Enter passenger name',
            controller: _nameController,
          ),
          const SizedBox(height: BusbookingSpacings.md),
          BusbookingTextInput(
            label: 'Email Address',
            placeholder: 'Enter email address',
            controller: _emailController,
          ),
          const SizedBox(height: BusbookingSpacings.md),
          BusbookingTextInput(
            label: 'Phone Number',
            placeholder: 'Enter phone number',
            controller: _phoneController,
          ),
        ],
      ),
    );
  }

  Widget _buildSeatsSection() {
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
            'Number of Seats',
            style: BusbookingTextStyles.body16Regular.copyWith(
              fontWeight: FontWeight.w600,
              color: BusbookingColors.textPrimary,
            ),
          ),
          const SizedBox(height: BusbookingSpacings.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select seats',
                style: BusbookingTextStyles.body14Regular.copyWith(
                  color: BusbookingColors.textSecondary,
                ),
              ),
              SeatStepper(
                value: _numberOfSeats,
                minValue: 1,
                maxValue: widget.schedule.availableSeats,
                onChanged: (value) {
                  setState(() {
                    _numberOfSeats = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: BusbookingSpacings.lg),
          Container(
            padding: const EdgeInsets.all(BusbookingSpacings.md),
            decoration: BoxDecoration(
              color: BusbookingColors.backgroundGrey,
              borderRadius: BorderRadius.circular(BusbookingSpacings.xs + 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price per seat',
                      style: BusbookingTextStyles.label12Medium.copyWith(
                        color: BusbookingColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${widget.schedule.seatPrice.toStringAsFixed(2)}',
                      style: BusbookingTextStyles.body14Medium.copyWith(
                        color: BusbookingColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total Amount',
                      style: BusbookingTextStyles.label12Medium.copyWith(
                        color: BusbookingColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${_totalPrice.toStringAsFixed(2)}',
                      style: BusbookingTextStyles.heading24SemiBold.copyWith(
                        fontSize: 20,
                        color: BusbookingColors.blue500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
}
