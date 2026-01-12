
import 'package:citym/models/bus_schedules.dart';
import 'package:citym/screens/booking/booking_form_screen.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BusScheduleCard extends StatelessWidget {
  final BusSchedules schedule;

  const BusScheduleCard({super.key, required this.schedule});

  static final _timeFormat = DateFormat('h:mm a');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingFormScreen(schedule: schedule),
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
            _buildRouteSection(),
            _buildDetailsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteSection() {
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
        children: [
          _LocationTime(
            location: schedule.route.origin,
            time: _timeFormat.format(schedule.departureTime),
            align: TextAlign.left,
          ),
          const SizedBox(width: BusbookingSpacings.lg),
          Expanded(child: _buildRouteIndicator()),
          const SizedBox(width: BusbookingSpacings.lg),
          _LocationTime(
            location: schedule.route.destination,
            time: _timeFormat.format(schedule.arrivalTime),
            align: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildRouteIndicator() {
    final line = Expanded(
      child: Container(
        height: 2,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: BusbookingColors.borderLight,
              width: 2,
            ),
          ),
        ),
      ),
    );

    return Row(
      children: [
        line,
        const SizedBox(width: 7.72),
        Container(
          width: 25,
          height: 20,
          decoration: BoxDecoration(
            color: BusbookingColors.blue500,
            borderRadius: BorderRadius.circular(BusbookingSpacings.xs),
          ),
          child: SvgPicture.asset(
            'assets/bus.svg',
            width: BusbookingSize.icon * 0.58,
            height: BusbookingSize.icon * 0.58,
            colorFilter: const ColorFilter.mode(
              BusbookingColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 7.72),
        line,
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BusbookingSpacings.lg,
        vertical: BusbookingSpacings.md,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: BusbookingColors.backgroundGrey,
            child: SvgPicture.asset(
              'assets/bus.svg',
              width: BusbookingSize.icon,
              height: BusbookingSize.icon,
              colorFilter: ColorFilter.mode(
                BusbookingColors.textPrimary.withOpacity(0.6),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: BusbookingSpacings.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule.bus.plateNumber,
                  style: BusbookingTextStyles.label12SemiBold.copyWith(
                    color: BusbookingColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Bus • ${schedule.availableSeats} seats',
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
          const SizedBox(width: BusbookingSpacings.xl),
          Text(
            '\$${schedule.seatPrice.toStringAsFixed(2)}',
            style: BusbookingTextStyles.body16Regular.copyWith(
              fontWeight: FontWeight.w600,
              color: BusbookingColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationTime extends StatelessWidget {
  final String location;
  final String time;
  final TextAlign align;

  const _LocationTime({
    required this.location,
    required this.time,
    required this.align,
  });

  @override
  Widget build(BuildContext context) {
    final crossAlign = align == TextAlign.left
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.end;

    return SizedBox(
      width: 96,
      child: Column(
        crossAxisAlignment: crossAlign,
        children: [
          Text(
            location,
            style: BusbookingTextStyles.label12Medium.copyWith(
              color: BusbookingColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: align,
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: BusbookingTextStyles.body14Medium.copyWith(
              color: BusbookingColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: align,
          ),
        ],
      ),
    );
  }
}