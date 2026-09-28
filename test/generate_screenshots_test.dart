import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:netflix_landing_ui/core/theme/app_theme.dart';
import 'package:netflix_landing_ui/screens/welcome_screen.dart';
import 'package:netflix_landing_ui/screens/home_screen.dart';
import 'package:netflix_landing_ui/screens/trending_screen.dart';
import 'package:netflix_landing_ui/screens/movie_details_screen.dart';
import 'package:netflix_landing_ui/screens/categories_screen.dart';
import 'package:netflix_landing_ui/screens/continue_watching_screen.dart';
import 'package:netflix_landing_ui/screens/my_list_screen.dart';
import 'package:netflix_landing_ui/screens/search_screen.dart';
import 'package:netflix_landing_ui/screens/profile_screen.dart';
import 'package:netflix_landing_ui/screens/settings_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Generate high-res screenshots for Netflix Landing UI App', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    final screens = <String, Widget>{
      '01_welcome': const WelcomeScreen(),
      '02_home': const HomeScreen(),
      '03_trending': const TrendingScreen(),
      '04_movie_details': const MovieDetailsScreen(movieId: '1'),
      '05_categories': const CategoriesScreen(),
      '06_continue_watching': const ContinueWatchingScreen(),
      '07_my_list': const MyListScreen(),
      '08_search': const SearchScreen(),
      '09_profile': const ProfileScreen(),
      '10_settings': const SettingsScreen(),
    };

    final dir = Directory('screenshots');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    for (final entry in screens.entries) {
      final repaintBoundaryKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: RepaintBoundary(
            key: repaintBoundaryKey,
            child: entry.value,
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final boundary = repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 2.0);
          final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            final pngBytes = byteData.buffer.asUint8List();
            final file = File('screenshots/${entry.key}.png');
            await file.writeAsBytes(pngBytes);
            // ignore: avoid_print
            print('Saved screenshot: screenshots/${entry.key}.png (${pngBytes.length} bytes)');
          }
        });
      }
    }
  });
}
