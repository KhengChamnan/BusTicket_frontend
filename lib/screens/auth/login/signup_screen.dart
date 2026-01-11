import 'package:citym/providers/asyncvalue.dart';
import 'package:citym/theme/bus_booking_theme.dart';
import 'package:flutter/material.dart';
import 'package:citym/widgets/actions/busbooking_button.dart';
import 'package:citym/widgets/inputs/busbooking_text_input.dart';
import 'package:citym/widgets/notifications/busbooking_snackbar.dart';
import 'package:citym/providers/auth_provider.dart';
import 'package:citym/screens/auth/auth_wrapper.dart';
import 'package:provider/provider.dart';

/// The signup screen allows users to create a new account.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;  
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

    void _handleSignUp() async {
      final name = _fullNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        if (!mounted) return;
        BusbookingSnackbar.showWarning(
          context,
          'Please fill in all fields',
        );
        return;
      }
      final authProvider = context.read<AuthProvider>();      
      await authProvider.register(name, email, password);     
      final registerValue = authProvider.registerValue;      
      if(registerValue?.state == AsyncValueState.success){
        if (!mounted) return;
        
        // Success pop up dialog
        BusbookingSnackbar.showSuccess(
          context,
          'Account created successfully 🎉',
          duration: const Duration(seconds: 2),
        );

        // Small delay so user sees the snackbar
        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;
        
        // Navigate to AuthWrapper, which will redirect to MainNavigationScreen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
          (route) => false,
        );
      } else if (registerValue?.state == AsyncValueState.error){
        if (!mounted) return;
        BusbookingSnackbar.showError(
          context,
          registerValue!.error.toString(),
        );
      } 
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status bar placeholder
            Container(
              height: 44,
              color: Colors.white,
            ),
            // Back button and header area
            Container(
              height: 44,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
            // Illustration/Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: BusbookingSpacings.xxl),
              child: Center(
                child: Image.asset(
                  'assets/sign_up_illustration.png',
                  height: 234,
                  width: 258,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Sign Up Title
            Padding(
              padding: const EdgeInsets.only(
                left: BusbookingSpacings.lg,
                bottom: BusbookingSpacings.xl,
              ),
              child: Text(
                'Sign Up',
                style: BusbookingTextStyles.heading24SemiBold.copyWith(
                  color: BusbookingColors.black,
                ),
              ),
            ),
            // Form Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BusbookingSpacings.lg),
              child: Column(
                children: [
                  // First Name Field
                  BusbookingTextInput(
                    label: 'Full Name',
                    placeholder: 'Enter your full name',
                    controller: _fullNameController,
                  ),
                  const SizedBox(height: BusbookingSpacings.xl),
                  // Email Field
                  BusbookingTextInput(
                    label: 'EMAIL',
                    placeholder: 'Enter your email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: BusbookingSpacings.xl),
                  // Password Field
                  BusbookingTextInput(
                    label: 'PASSWORD',
                    placeholder: 'Enter your password',
                    controller: _passwordController,
                    isPassword: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: BusbookingSpacings.xxxl),
            // Create Account Button and Sign In Link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BusbookingSpacings.lg),
              child: Column(
                children: [
                  BusbookingButton(
                    label: 'Create Account',
                    onPressed: () {
                      _handleSignUp();
                    },
                  ),
                  const SizedBox(height: BusbookingSpacings.xl),
                  // Sign In Link
                  Column(
                    children: [
                      Text(
                        'Already have an account?',
                        style: BusbookingTextStyles.body16Regular.copyWith(
                          color: const Color(0xFF696F77),
                        ),
                      ),
                      const SizedBox(height: BusbookingSpacings.sm),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Sign In',
                          style: BusbookingTextStyles.body14Medium.copyWith(
                            color: BusbookingColors.blue500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: BusbookingSpacings.xxxl),
          ],
        ),
      ),
    );
  }
}
