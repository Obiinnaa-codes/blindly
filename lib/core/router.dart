import 'package:go_router/go_router.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/sign_up_screen.dart';
import '../features/home/home_screen.dart';

/// Main router configuration for the application using [GoRouter].
final appRouter = GoRouter(
  // The first screen the user sees
  initialLocation: '/login',
  routes: [
    /// Login page route
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

    /// Sign up page route
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),

    /// Home page route
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);
