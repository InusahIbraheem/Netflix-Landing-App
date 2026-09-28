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

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    this.width,
    this.showTitle = true,
    this.animationDelay = Duration.zero,
  });

  final Movie movie;
  final double? width;
  final bool showTitle;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ??
        ResponsiveUtils.value(
          context: context,
          mobile: 130,
          tablet: 150,
          desktop: 170,
        );

    return GestureDetector(
      onTap: () => context.push(RouteConstants.movieDetailsPath(movie.id)),
      child: Hero(
        tag: 'movie-poster-${movie.id}',
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppConstants.cardBorderRadius),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: CachedNetworkImage(
                      imageUrl: movie.posterUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        color: AppColors.surfaceLight,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.netflixRed,
                          ),
                        ),
                      ),
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.surfaceLight,
                        child: const Icon(Icons.movie, color: AppColors.textMuted),
                      ),
                    ),
                  ),
                ),
                if (showTitle) ...[
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '${movie.year} • ${movie.rating}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: animationDelay)
        .scale(
          begin: const Offset(0.92, 0.92),
          end: const Offset(1, 1),
          duration: 400.ms,
          delay: animationDelay,
          curve: Curves.easeOutCubic,
        );
  }
}

class MovieThumbnailGrid extends StatelessWidget {
  const MovieThumbnailGrid({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveUtils.gridCrossAxisCount(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: movies[index],
          width: double.infinity,
          animationDelay: Duration(milliseconds: 50 * index),
        );
      },
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.movie,
    required this.progress,
    this.subtitle,
  });

  final Movie movie;
  final double progress;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteConstants.movieDetailsPath(movie.id)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: movie.bannerUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.surfaceLight),
                errorWidget: (_, _, _) =>
                    Container(color: AppColors.surfaceLight),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.cardOverlay,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 3,
                backgroundColor: AppColors.surfaceLight,
                color: AppColors.netflixRed,
              ),
            ),
            Center(
              child: GlassContainer(
                borderRadius: 40,
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .scale(begin: const Offset(0.95, 0.95), duration: 500.ms);
  }
}
