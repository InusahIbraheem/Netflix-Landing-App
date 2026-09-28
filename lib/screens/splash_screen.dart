import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_landing_ui/core/theme/app_theme.dart';
import 'package:netflix_landing_ui/widgets/developer_footer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.go('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primary, AppTheme.secondary, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'hero_splash',
                child: Icon(Icons.play_circle_filled_rounded, size: 88, color: Colors.white),
              ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              Text(
                'StreamFlix',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Text(
                'Welcome to premium entertainment',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ).animate().fadeIn(delay: 500.ms),
              const Spacer(),
              const DeveloperFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
