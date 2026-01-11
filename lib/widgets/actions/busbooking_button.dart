import 'package:flutter/material.dart';

/// Bus Booking button widgets.
class BusbookingButton extends StatelessWidget {
  /// The label text displayed on the button.
  final String label;

  /// The callback function when the button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button is enabled or disabled.
  final bool enabled;

  /// The width of the button. If null, the button takes full width.
  final double? width;

  /// Constructor for BusbookingButton.
  const BusbookingButton({
    required this.label,
    this.onPressed,
    this.enabled = true,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0063E6),
          disabledBackgroundColor: const Color(0xFF0063E6).withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
