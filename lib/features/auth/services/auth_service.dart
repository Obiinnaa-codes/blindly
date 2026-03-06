import 'package:supabase_flutter/supabase_flutter.dart';

/// A service that handles all authentication-related tasks using Supabase.
class AuthService {
  final _supabase = Supabase.instance.client;

  /// Returns the current session if it exists.
  Session? get currentSession => _supabase.auth.currentSession;

  /// Returns the current user if it exists.
  User? get currentUser => _supabase.auth.currentUser;

  /// Sign up a new user with email and password.
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': name, 'age': age, 'gender': gender},
    );
  }

  /// Sign in an existing user with email and password.
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Send a password reset email.
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
}
