import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the state of the authentication process.
class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});

  /// Creates a copy of the current state with optional field updates.
  AuthState copyWith({bool? isLoading, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Notifier that manages the [AuthState] and handles login logic.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  /// Simulates a login request.
  /// In a real app, this would call an AuthRepository or API.
  Future<void> login(String email, String password) async {
    // Start loading and clear any previous errors
    state = state.copyWith(isLoading: true, error: null);

    // Simulate network latency
    await Future.delayed(const Duration(seconds: 2));

    // Dummy validation logic
    if (email == "test@test.com" && password == "password") {
      state = state.copyWith(isLoading: false);
      // Here you would typically navigate to home or save a session token
    } else {
      // Set error message if validation fails
      state = state.copyWith(isLoading: false, error: "Invalid credentials");
    }
  }
}

/// Provider that allows the UI to listen to and interact with the Auth state.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
