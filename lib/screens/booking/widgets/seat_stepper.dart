import 'package:flutter/material.dart';
import '../../../theme/bus_booking_theme.dart';

class SeatStepper extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const SeatStepper({
    super.key,
    required this.value,
    this.minValue = 1,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: BusbookingColors.borderLight),
        borderRadius: BorderRadius.circular(BusbookingSpacings.xs + 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onPressed: value > minValue
                ? () => onChanged(value - 1)
                : null,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BusbookingSpacings.lg + 4,
            ),
            child: Text(
              '$value',
              style: BusbookingTextStyles.body16Regular.copyWith(
                fontWeight: FontWeight.w600,
                color: BusbookingColors.textPrimary,
              ),
            ),
          ),
          _buildButton(
            icon: Icons.add,
            onPressed: value < maxValue
                ? () => onChanged(value + 1)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(BusbookingSpacings.xs),
        child: Container(
          padding: const EdgeInsets.all(BusbookingSpacings.md),
          child: Icon(
            icon,
            size: BusbookingSize.icon - 4,
            color: onPressed != null
                ? BusbookingColors.blue500
                : BusbookingColors.textSecondary.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
