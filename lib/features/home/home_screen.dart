import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../auth/providers/auth_provider.dart';
import '../../core/theme/colors.dart';

import '../../core/widgets/logo_text.dart';

/// The main application landing page after a successful login.
/// Uses [ConsumerStatefulWidget] to integrate with Riverpod for auth state.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Tracks the current active tab in the bottom navigation bar
  int _selectedIndex = 0;

  // Updates the UI when a user taps a navigation item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // The branded logo centered in the header
        title: const LogoText(fontSize: 32),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          // Logout button to clear Supabase session
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textMain),
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      // IndexedStack keeps all "pages" alive in memory but only shows one
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildExploreSection(),
          _buildPage('Your Profile', Icons.person_outline),
        ],
      ),
      bottomNavigationBar: Container(
        // Extra bottom padding for modern notch/gesture-based phones
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primaryRed,
          unselectedItemColor: AppColors.textSecondary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined, size: 28),
              activeIcon: Icon(Icons.grid_view, size: 28),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the thematic chat rooms grid shown in the design
  Widget _buildExploreSection() {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          shrinkWrap:
              true, // Centers vertically if content is smaller than screen
          physics:
              const NeverScrollableScrollPhysics(), // Scroll handled by SingleChildScrollView
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio:
              0.72, // Smaller number makes the cards taller/bigger
          children: const [
            RoomCard(
              title: 'GLOBAL CHAT',
              onlineCount: '15.2k online',
              icon: Icons.public,
              color: AppColors.globalChat,
            ),
            RoomCard(
              title: 'LOVE VIBES',
              onlineCount: '9.8k online',
              icon: Icons.favorite,
              color: AppColors.loveVibes,
            ),
            RoomCard(
              title: 'ADVENTURE',
              onlineCount: '11k online',
              icon: Icons.terrain,
              color: AppColors.adventure,
            ),
            RoomCard(
              title: 'CASUAL',
              onlineCount: '14k online',
              icon: Icons.chat_bubble,
              color: AppColors.casual,
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder for secondary screens like the Profile tab
  Widget _buildPage(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textMain,
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom stylized card representing a thematic chat room.
class RoomCard extends StatelessWidget {
  final String title;
  final String onlineCount;
  final IconData icon;
  final Color color;

  const RoomCard({
    super.key,
    required this.title,
    required this.onlineCount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top circular icon hub
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 36), // Increased icon size
          ),

          const SizedBox(height: 16),

          // Room Titles and Stats
          Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18, // Increased font size
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                onlineCount,
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 13, // Increased font size
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bottom row showing dummy avatars of users currently in the room
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Align(
                widthFactor: 0.6, // Creates the overlapping/stacked effect
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 14, // Increased avatar size
                    backgroundColor: Colors.white24,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=${title.length + index}',
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
