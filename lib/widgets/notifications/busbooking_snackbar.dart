import 'package:flutter/material.dart';
import '../../theme/bus_booking_theme.dart';

class BusbookingSnackbar {
  BusbookingSnackbar._();

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? action,
    VoidCallback? onActionPressed,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: const Color(0xFF4CAF50),
      icon: Icons.check_circle,
      iconColor: Colors.white,
      duration: duration,
      action: action,
      onActionPressed: onActionPressed,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    String? action,
    VoidCallback? onActionPressed,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: const Color(0xFFE53935),
      icon: Icons.error,
      iconColor: Colors.white,
      duration: duration,
      action: action,
      onActionPressed: onActionPressed,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? action,
    VoidCallback? onActionPressed,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: const Color(0xFFFFA726),
      icon: Icons.warning,
      iconColor: Colors.white,
      duration: duration,
      action: action,
      onActionPressed: onActionPressed,
    );
  }

  static void _showSnackbar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Color iconColor,
    required Duration duration,
    String? action,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            SizedBox(width: BusbookingSpacings.s),
            Expanded(
              child: Text(
                message,
                style: BusbookingTextStyles.body14Medium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BusbookingSpacings.s),
        ),
        margin: EdgeInsets.all(BusbookingSpacings.m),
        padding: EdgeInsets.symmetric(
          horizontal: BusbookingSpacings.m,
          vertical: BusbookingSpacings.s,
        ),
        duration: duration,
        action: action != null && onActionPressed != null
            ? SnackBarAction(
                label: action,
                textColor: Colors.white,
                onPressed: onActionPressed,
              )
            : null,
      ),
    );
  }
}
