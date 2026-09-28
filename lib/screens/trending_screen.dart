import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';
import 'package:netflix_landing_ui/widgets/section_header.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = MovieService.instance.getTrendingMovies();

    return ScreenScaffold(
      appBar: const NetflixAppBar(title: 'Trending'),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.netflixRed.withValues(alpha: 0.2),
                  AppColors.surfaceLight,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.trending_up, color: AppColors.netflixRed, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Top 10 This Week',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${movies.length} titles trending globally',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Trending Movies'),
          MovieThumbnailGrid(movies: movies),
        ],
      ),
    );
  }
}
