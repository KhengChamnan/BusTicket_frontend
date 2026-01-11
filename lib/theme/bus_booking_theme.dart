import 'package:flutter/material.dart';

///
/// Definition of Bus Booking colors.
///
class BusbookingColors {
  // Primary Colors
  static const Color blue500 = Color(0xFF154CE4);      // Primary blue from Figma
  static const Color blue400 = Color(0xFF3382EB);
  static const Color blue200 = Color(0xFF8AB7F4);
  static const Color blue100 = Color(0xFFEEF2FC);      // Light blue background
  static const Color blue50 = Color(0xFFE6EFFD);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF171F26);  // Primary dark text
  static const Color textSecondary = Color(0xFF65727F); // Secondary text/labels
  static const Color textTertiary = Color(0xFF757575);
  
  // Background Colors
  static const Color backgroundGrey = Color(0xFFF6F7F9); // Light grey background
  static const Color backgroundWhite = Color(0xFFFDFDFD);
  
  // Border/Background Colors
  static const Color borderLight = Color(0xFFEAECF1);  // Border color from design
  static const Color borderDark = Color(0xFFBEC5D2);
  
  // Badge/Number Colors
  static const Color badgeBackground = Color(0xFFF4F4F6); // Grey badge
  
  // Divider
  static const Color divider = Color(0xFFD9D9D9);

  // Getters for common use cases
  static Color get primary => blue500;
  
  static Color get backGroundColor => white;
  
  static Color get textNormal => textPrimary;
  
  static Color get textLight => textSecondary;
}

///
/// Definition of Bus Booking text styles.
///
class BusbookingTextStyles {
  // Heading Styles
  static const TextStyle heading24SemiBold = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
  );

  static TextStyle heading = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );

  // Title Styles
  static TextStyle title = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  // Body Styles
  static const TextStyle body16Regular = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3125,
    letterSpacing: 0,
  );

  static const TextStyle body14Regular = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static const TextStyle body14Medium = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0,
  );

  static TextStyle body = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // Label Styles
  static const TextStyle label12Medium = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0,
  );

  static const TextStyle label12SemiBold = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: -0.12,
  );

  static TextStyle label = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  // Button Styles
  static const TextStyle buttonSemiBold = TextStyle(
    fontFamily: 'Rubik',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
  );

  static TextStyle button = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

///
/// Definition of Bus Booking spacings, in pixels.
/// Basically extra small (xs), small (sm), medium (md), large (lg), extra large (xl), extra extra large (xxl)
///
class BusbookingSpacings {
  // Extra Small
  static const double xs = 4.0;
  
  // Small
  static const double sm = 8.0;
  static const double s = 12.0;
  
  // Medium
  static const double md = 12.0;
  static const double m = 16.0;
  
  // Large
  static const double lg = 16.0;
  static const double l = 24.0;
  
  // Extra Large
  static const double xl = 24.0;
  
  // 2XL
  static const double xxl = 32.0;
  
  // 3XL
  static const double xxxl = 48.0;

  // Border Radius
  static const double radius = 16.0;
  static const double radiusLarge = 24.0;
}

///
/// Definition of Bus Booking sizes.
///
class BusbookingSize {
  static const double icon = 24.0;
}

///
/// Definition of Bus Booking Theme.
///
ThemeData busBookingTheme = ThemeData(
  fontFamily: 'Rubik',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: BusbookingColors.blue500,
  colorScheme: ColorScheme.fromSeed(
    seedColor: BusbookingColors.blue500,
  ),
);
