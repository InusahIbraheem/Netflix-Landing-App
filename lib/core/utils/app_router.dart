import 'package:go_router/go_router.dart';
import 'package:netflix_landing_ui/core/constants/route_constants.dart';
import 'package:netflix_landing_ui/screens/categories_screen.dart';
import 'package:netflix_landing_ui/screens/continue_watching_screen.dart';
import 'package:netflix_landing_ui/screens/home_screen.dart';
import 'package:netflix_landing_ui/screens/movie_details_screen.dart';
import 'package:netflix_landing_ui/screens/my_list_screen.dart';
import 'package:netflix_landing_ui/screens/profile_screen.dart';
import 'package:netflix_landing_ui/screens/search_screen.dart';
import 'package:netflix_landing_ui/screens/settings_screen.dart';
import 'package:netflix_landing_ui/screens/splash_screen.dart';
import 'package:netflix_landing_ui/screens/trending_screen.dart';
import 'package:netflix_landing_ui/screens/welcome_screen.dart';
import 'package:netflix_landing_ui/widgets/main_shell.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.trending,
                builder: (context, state) => const TrendingScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.myList,
                builder: (context, state) => const MyListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteConstants.continueWatching,
        builder: (context, state) => const ContinueWatchingScreen(),
      ),
      GoRoute(
        path: RouteConstants.movieDetails,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MovieDetailsScreen(movieId: id);
        },
      ),
      GoRoute(
        path: RouteConstants.categories,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: RouteConstants.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: RouteConstants.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
