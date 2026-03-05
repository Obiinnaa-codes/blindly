import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_input.dart';
import '../../core/widgets/logo_text.dart';
import 'providers/auth_provider.dart';

/// Screen where users can create a new account.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Controllers for handling user input
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the common auth state
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 48.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Branding Logo
                const LogoText(),
                const SizedBox(height: 48),

                // Welcome Header
                Text(
                  'Join Blindly',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create an account to start connecting',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),

                // Error message display
                if (authState.error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    authState.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
                const SizedBox(height: 32),

                // Name field
                AppInput(
                  label: 'Full Name',
                  controller: _nameController,
                  hintText: 'Enter your full name',
                ),
                const SizedBox(height: 20),

                // Email field
                AppInput(
                  label: 'Email Address',
                  controller: _emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Row for Age and Gender
                Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        label: 'Age',
                        controller: _ageController,
                        hintText: 'e.g. 25',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppInput(
                        label: 'Gender',
                        controller: _genderController,
                        hintText: 'e.g. Male',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Password field
                AppInput(
                  label: 'Password',
                  controller: _passwordController,
                  hintText: 'Create a password',
                  obscureText: true,
                ),
                const SizedBox(height: 40),

                // Reusable Branded Button
                AppButton(
                  text: 'CREATE ACCOUNT',
                  isLoading: authState.isLoading,
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    final age = int.tryParse(_ageController.text) ?? 18;
                    final gender = _genderController.text.trim();

                    if (name.isNotEmpty &&
                        email.isNotEmpty &&
                        password.isNotEmpty) {
                      try {
                        await ref
                            .read(authProvider.notifier)
                            .signUp(
                              email: email,
                              password: password,
                              name: name,
                              age: age,
                              gender: gender,
                            );

                        // Check for errors before navigating
                        if (ref.read(authProvider).error == null &&
                            context.mounted) {
                          context.go('/home');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Unexpected error: ${e.toString()}',
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.primaryRed,
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Redirect to Login
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: GoogleFonts.poppins(
                            color: AppColors.textMain,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
