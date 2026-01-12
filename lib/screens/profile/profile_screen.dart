import 'package:citym/providers/auth_provider.dart';
import 'package:citym/providers/asyncvalue.dart';
import 'package:citym/providers/user_profile_provider.dart';
import 'package:citym/screens/auth/login/login_screen.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:citym/widgets/display/bus_loading_animation.dart';
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
      body: Consumer<UserProfileProvider>(
        builder: (context, provider, child) {
          final userProfileValue = provider.userProfileValue;

          // Trigger data fetch if not loaded yet
          if (userProfileValue == null || 
              (userProfileValue.state != AsyncValueState.loading && 
               userProfileValue.state != AsyncValueState.error && 
               userProfileValue.data == null)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.getUserProfile();
            });
          }

          // Loading state
          if (userProfileValue?.state == AsyncValueState.loading) {
            return const Center(child: BusLoadingAnimation());
          }

          // Error state
          if (userProfileValue?.state == AsyncValueState.error) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(BusbookingSpacings.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: BusbookingColors.textSecondary),
                    SizedBox(height: BusbookingSpacings.l),
                    Text(
                      'Failed to load profile',
                      style: BusbookingTextStyles.heading24SemiBold,
                    ),
                    SizedBox(height: BusbookingSpacings.s),
                    Text(
                      '${userProfileValue?.error}',
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

          // Success state - show user data
          final user = userProfileValue?.data;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(BusbookingSpacings.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar with user initial or image
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: BusbookingColors.backgroundGrey,
                    backgroundImage: user?.avatarImage != null
                        ? NetworkImage(user!.avatarImage!)
                        : null,
                    child: user?.avatarImage == null
                        ? Text(
                            user?.fullname.isNotEmpty == true
                                ? user!.fullname[0].toUpperCase()
                                : 'U',
                            style: BusbookingTextStyles.heading24SemiBold.copyWith(
                              color: BusbookingColors.textSecondary,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(height: BusbookingSpacings.xl),
                  Text(
                    user?.fullname ?? 'User',
                    style: BusbookingTextStyles.heading24SemiBold,
                  ),
                  SizedBox(height: BusbookingSpacings.s),
                  Text(
                    user?.email ?? '',
                    style: BusbookingTextStyles.body14Regular.copyWith(
                      color: BusbookingColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: BusbookingSpacings.xxl),
                  // User info tiles
                  _buildInfoTile(Icons.person_outline, 'Full Name', user?.fullname ?? 'N/A'),
                  SizedBox(height: BusbookingSpacings.s),
                  _buildInfoTile(Icons.email_outlined, 'Email', user?.email ?? 'N/A'),
                  SizedBox(height: BusbookingSpacings.s),
                  _buildInfoTile(Icons.account_balance_wallet_outlined, 'Credit', user?.credit ?? '0'),
                  SizedBox(height: BusbookingSpacings.s),
                  _buildOption(Icons.logout, 'Logout', () => _handleLogout(context)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(BusbookingSpacings.m),
      decoration: BoxDecoration(
        border: Border.all(color: BusbookingColors.borderLight),
        borderRadius: BorderRadius.circular(BusbookingSpacings.s),
      ),
      child: Row(
        children: [
          Icon(icon, color: BusbookingColors.textPrimary),
          SizedBox(width: BusbookingSpacings.m),
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
                SizedBox(height: BusbookingSpacings.xs),
                Text(
                  value,
                  style: BusbookingTextStyles.body16Regular,
                ),
              ],
            ),
          ),
        ],
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

  void _handleLogout(BuildContext context) async {
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
