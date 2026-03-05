import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/router.dart';
import 'core/constants/supabase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.url,
    anonKey: SupabaseConstants.anonKey,
  );

  runApp(
    // ProviderScope is required for Riverpod to manage state across the app
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router is used to integrate GoRouter for navigation
    return MaterialApp.router(
      title: 'Blindly',
      debugShowCheckedModeBanner: false,
      // Apply the custom light theme (Poppins font and Primary Red palette)
      theme: AppTheme.lightTheme,
      // Pass the router configuration
      routerConfig: appRouter,
    );
  }
}
