import 'package:citym/screens/main_navigation/main_navigation_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:citym/widgets/actions/busbooking_button.dart';
import 'package:citym/widgets/inputs/busbooking_text_input.dart';
import 'package:citym/widgets/notifications/busbooking_snackbar.dart';
import 'package:citym/screens/auth/login/signup_screen.dart';
import 'package:citym/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'example@gmail.com');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 71),
              Center(
                child: Image.asset(
                  'assets/login_illustration.png',
                  height: 234,
                  width: 246,
                ),
              ),
              const SizedBox(height: 29),
              
              Text(
                'Log In',
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF242E49),
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 19),

              BusbookingTextInput(
                label: 'Email',
                placeholder: 'Enter your email',
                controller: _emailController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 19),

              BusbookingTextInput(
                label: 'Password',
                placeholder: 'Enter your password',
                controller: _passwordController,
                isPassword: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 13),

              const SizedBox(height: 22),

              BusbookingButton(
                label: 'Login',
                onPressed: () {
                  _handleLogin();
                },
              ),
              const SizedBox(height: 40),

              _buildDividerWithText(),
              const SizedBox(height: 22),

              const SizedBox(height: 39),

              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF575757),
                          height: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3382EB),
                          height: 1.5,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _handleSignUp(context),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDividerWithText() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFD9D9D9),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or',
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF242E49),
              height: 1.0,
              letterSpacing: -0.12,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xFFD9D9D9),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    await authProvider.login(email, password);

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      BusbookingSnackbar.showSuccess(
        context,
        'Login successful 🎉',
        duration: const Duration(seconds: 2),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } else {
      final error = authProvider.loginValue?.error ?? 'Login failed';
      BusbookingSnackbar.showError(
        context,
        error.toString(),
      );
    }
  }

  void _handleSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}
