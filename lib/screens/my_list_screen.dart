import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';
import 'package:netflix_landing_ui/widgets/section_header.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = MovieService.instance.getMyList();

    return ScreenScaffold(
      appBar: const NetflixAppBar(title: 'My List'),
      body: movies.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  Text(
                    'Your list is empty',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add movies and shows to watch later',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                SectionHeader(title: '${movies.length} Saved Titles'),
                MovieThumbnailGrid(movies: movies),
              ],
            ),
    );
  }
}
