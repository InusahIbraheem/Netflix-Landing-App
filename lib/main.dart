import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/theme/app_theme.dart';
import 'package:netflix_landing_ui/core/utils/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NetflixApp());
}

class NetflixApp extends StatelessWidget {
  const NetflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Netflix Landing UI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
    );
  }
}
