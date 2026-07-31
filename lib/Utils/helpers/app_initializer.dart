import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Screens/Auth/email section/provider/email_authProvider.dart';
import '../../Screens/Auth/signIn_widget.dart';
import '../../Screens/Dashboard/dashboard_page.dart';
import 'session_manager.dart';

/// **App Initializer - Handles Session Management and App Startup**
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    // Initialize app using EmailAuthProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider =
          Provider.of<EmailAuthProvider>(context, listen: false);
      // Force initialization for hot restarts
      authProvider.forceInitialization();
      authProvider.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailAuthProvider>(
      builder: (context, authProvider, child) {
        // Show loading screen while initializing
        if (authProvider.isAppInitializing) {
          return _buildLoadingScreen(authProvider);
        }

        // Show main app with session management
        return SessionManager(
          child: Consumer<EmailAuthProvider>(
            builder: (context, authProvider, child) {
              // Check if user is logged in
              if (authProvider.isLoggedIn) {
                return const DashboardPage();
              } else {
                return const SignInWidget();
              }
            },
          ),
        );
      },
    );
  }

  /// **Build Loading Screen**
  Widget _buildLoadingScreen(EmailAuthProvider authProvider) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.shopping_cart,
                size: 40,
                color: Colors.blue.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // App Name
            Text(
              'Klik',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade600,
              ),
            ),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'Your Shopping Partner',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 40),

            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
            ),

            const SizedBox(height: 16),

            // Status Text
            Text(
              authProvider.initializationStatus,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 8),

            // Loading Dots Animation
            _buildLoadingDots(),
          ],
        ),
      ),
    );
  }

  /// **Build Loading Dots Animation**
  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 600 + (index * 200)),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.blue.shade600,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

/// **App Initializer with Custom Theme**
class ThemedAppInitializer extends StatelessWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final String appName;
  final String tagline;
  final Widget? logo;

  const ThemedAppInitializer({
    super.key,
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.appName = 'Klik',
    this.tagline = 'Your Shopping Partner',
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
      ),
      child: const AppInitializer(),
    );
  }
}
