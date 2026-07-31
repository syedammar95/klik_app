import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Screens/Auth/email section/provider/email_authProvider.dart';

/// **Session Manager - Monitors user activity and manages session timeouts**
class SessionManager extends StatefulWidget {
  final Widget child;

  const SessionManager({
    super.key,
    required this.child,
  });

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager>
    with WidgetsBindingObserver {
  Timer? _sessionTimer;
  Timer? _warningTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startSessionMonitoring();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sessionTimer?.cancel();
    _warningTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _onUserActivity();
        break;
      case AppLifecycleState.paused:
        // App is paused, but don't clear session immediately
        break;
      case AppLifecycleState.inactive:
        // App is inactive, but user might return
        break;
      case AppLifecycleState.detached:
        // App is being terminated
        break;
      case AppLifecycleState.hidden:
        // App is hidden
        break;
    }
  }

  void _startSessionMonitoring() {
    // Check session every 5 minutes
    _sessionTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _checkSessionStatus();
    });

    // Check for session warnings every minute
    _warningTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkSessionWarning();
    });
  }

  void _onUserActivity() {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
    authProvider.updateLastActivity();
  }

  void _checkSessionStatus() {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);

    if (authProvider.isLoggedIn) {
      // Validate session periodically
      authProvider.validateUserSession();
    }
  }

  void _checkSessionWarning() {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);

    if (authProvider.isLoggedIn && authProvider.shouldShowSessionWarning()) {
      _showSessionWarning();
    }
  }

  void _showSessionWarning() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Session Warning'),
        content: const Text(
          'Your session will expire soon. Would you like to extend it?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _extendSession();
            },
            child: const Text('Extend Session'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _logoutUser();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _extendSession() {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
    authProvider.updateLastActivity();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Session extended successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _logoutUser() {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
    authProvider.logout();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Session expired. Please login again.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onUserActivity,
      onPanDown: (_) => _onUserActivity(),
      onScaleStart: (_) => _onUserActivity(),
      child: widget.child,
    );
  }
}

/// **Session Activity Tracker - Tracks user interactions**
class SessionActivityTracker extends StatelessWidget {
  final Widget child;
  final VoidCallback? onActivity;

  const SessionActivityTracker({
    super.key,
    required this.child,
    this.onActivity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onActivity?.call();
        _updateSessionActivity(context);
      },
      onPanDown: (_) => _updateSessionActivity(context),
      onScaleStart: (_) => _updateSessionActivity(context),
      child: child,
    );
  }

  void _updateSessionActivity(BuildContext context) {
    final authProvider = Provider.of<EmailAuthProvider>(context, listen: false);
    if (authProvider.isLoggedIn) {
      authProvider.updateLastActivity();
    }
  }
}
