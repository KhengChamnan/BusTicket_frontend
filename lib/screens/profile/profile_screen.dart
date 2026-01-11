import 'package:citym/providers/auth_provider.dart';
import 'package:citym/screens/auth/login/login_screen.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BusbookingColors.white,
      appBar: AppBar(
        backgroundColor: BusbookingColors.white,
        elevation: 0,
        title: Text('Profile', style: BusbookingTextStyles.heading24SemiBold),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(BusbookingSpacings.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: BusbookingColors.backgroundGrey,
                child: Icon(Icons.person_outline, size: 40, color: BusbookingColors.textSecondary),
              ),
              SizedBox(height: BusbookingSpacings.xl),
              Text('Your Profile', style: BusbookingTextStyles.heading24SemiBold),
              SizedBox(height: BusbookingSpacings.s),
              Text(
                'Manage your account settings and preferences',
                style: BusbookingTextStyles.body14Regular.copyWith(color: BusbookingColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: BusbookingSpacings.xxl),
              _buildOption(Icons.settings_outlined, 'Settings', () {}),
              SizedBox(height: BusbookingSpacings.s),
              _buildOption(Icons.help_outline, 'Help & Support', () {}),
              SizedBox(height: BusbookingSpacings.s),
              _buildOption(Icons.logout, 'Logout', () => _handleLogout(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(BusbookingSpacings.s),
      child: Container(
        padding: EdgeInsets.all(BusbookingSpacings.m),
        decoration: BoxDecoration(
          border: Border.all(color: BusbookingColors.borderLight),
          borderRadius: BorderRadius.circular(BusbookingSpacings.s),
        ),
        child: Row(
          children: [
            Icon(icon, color: BusbookingColors.textPrimary),
            SizedBox(width: BusbookingSpacings.m),
            Expanded(child: Text(title, style: BusbookingTextStyles.body16Regular)),
            Icon(Icons.chevron_right, color: BusbookingColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    }
  }
}
