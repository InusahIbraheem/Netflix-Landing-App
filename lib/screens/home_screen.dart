import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_landing_ui/core/constants/route_constants.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/hero_banner.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';
import 'package:netflix_landing_ui/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = MovieService.instance;
    final featured = service.getFeaturedMovie();
    final trending = service.getTrendingMovies();
    final continueWatching = service.getContinueWatching();

    return ScreenScaffold(
      appBar: const NetflixAppBar(),
      body: ListView(
        children: [
          HeroBanner(movie: featured),
          const SizedBox(height: 24),
          SectionHeader(
            title: 'Continue Watching',
            actionLabel: 'See All',
            onAction: () => context.push(RouteConstants.continueWatching),
          ),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: continueWatching.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = continueWatching[index];
                return SizedBox(
                  width: 280,
                  child: VideoCard(
                    movie: item.movie,
                    progress: item.progress,
                    subtitle: item.lastWatched,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Trending Now'),
          HorizontalMovieList(movies: trending),
          const SizedBox(height: 24),
          SectionHeader(
            title: 'Browse Categories',
            actionLabel: 'View All',
            onAction: () => context.push(RouteConstants.categories),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MovieService.categories.take(4).map((category) {
              return ActionChip(
                avatar: const Icon(Icons.category, size: 16),
                label: Text(category.name),
                onPressed: () => context.push(RouteConstants.categories),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Recommended For You'),
          MovieThumbnailGrid(movies: service.getAllMovies()),
        ],
      ),
    );
  }
}
