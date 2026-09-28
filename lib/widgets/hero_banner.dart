import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_landing_ui/core/constants/app_constants.dart';
import 'package:netflix_landing_ui/core/constants/route_constants.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/core/utils/responsive_utils.dart';
import 'package:netflix_landing_ui/models/movie.dart';
import 'package:netflix_landing_ui/widgets/glass_container.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveUtils.value(
      context: context,
      mobile: 220.0,
      tablet: 320.0,
      desktop: 420.0,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.heroBorderRadius),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'movie-banner-${movie.id}',
              child: CachedNetworkImage(
                imageUrl: movie.bannerUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.surfaceLight),
                errorWidget: (_, _, _) =>
                    Container(color: AppColors.surfaceLight),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.3),
                    AppColors.background.withValues(alpha: 0.95),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.8),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${movie.genresLabel} • ${movie.year} • ${movie.duration}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: () =>
                            context.push(RouteConstants.movieDetailsPath(movie.id)),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.textPrimary,
                          foregroundColor: AppColors.background,
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () =>
                            context.push(RouteConstants.movieDetailsPath(movie.id)),
                        icon: const Icon(Icons.info_outline),
                        label: const Text('More Info'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
          begin: const Offset(0.98, 0.98),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class HorizontalMovieList extends StatelessWidget {
  const HorizontalMovieList({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveUtils.value(
        context: context,
        mobile: 210,
        tablet: 230,
        desktop: 250,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return MovieCard(
            movie: movies[index],
            animationDelay: Duration(milliseconds: 60 * index),
          );
        },
      ),
    );
  }
}
