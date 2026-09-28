import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:netflix_landing_ui/core/constants/app_constants.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/core/utils/responsive_utils.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/developer_footer.dart';
import 'package:netflix_landing_ui/widgets/glass_container.dart';
import 'package:netflix_landing_ui/widgets/hero_banner.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movieId});

  final String movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late bool _inMyList;

  @override
  void initState() {
    super.initState();
    _inMyList = MovieService.instance.isInMyList(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = MovieService.instance.getMovieById(widget.movieId);

    if (movie == null) {
      return Scaffold(
        appBar: const NetflixAppBar(showBack: true, title: 'Not Found'),
        body: const Column(
          children: [
            Expanded(
              child: Center(child: Text('Movie not found')),
            ),
            DeveloperFooter(),
          ],
        ),
      );
    }

    final related = MovieService.instance
        .getMoviesByCategory(movie.categoryId)
        .where((m) => m.id != movie.id)
        .toList();

    final bannerHeight = ResponsiveUtils.value(
      context: context,
      mobile: 240.0,
      tablet: 320.0,
      desktop: 400.0,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const NetflixAppBar(showBack: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: bannerHeight + kToolbarHeight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: 'movie-banner-${movie.id}',
                          child: CachedNetworkImage(
                            imageUrl: movie.bannerUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.background.withValues(alpha: 0.95),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -60),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.horizontalPadding(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Hero(
                                tag: 'movie-poster-${movie.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.cardBorderRadius,
                                  ),
                                  child: SizedBox(
                                    width: 120,
                                    height: 180,
                                    child: CachedNetworkImage(
                                      imageUrl: movie.posterUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(fontWeight: FontWeight.bold),
                                    ).animate().fadeIn(duration: 400.ms),
                                    const SizedBox(height: 8),
                                    GlassContainer(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text('${movie.rating} • ${movie.year}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              FilledButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Play'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.textPrimary,
                                  foregroundColor: AppColors.background,
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    MovieService.instance.toggleMyList(movie.id);
                                    _inMyList = !_inMyList;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        _inMyList
                                            ? 'Added to My List'
                                            : 'Removed from My List',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  _inMyList
                                      ? Icons.check
                                      : Icons.add,
                                ),
                                label: Text(
                                  _inMyList ? 'In My List' : 'My List',
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.textPrimary,
                                  side: const BorderSide(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            movie.genresLabel,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.netflixRed,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.duration,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            movie.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                          ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
                          if (related.isNotEmpty) ...[
                            const SizedBox(height: 32),
                            Text(
                              'More Like This',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            HorizontalMovieList(movies: related),
                          ],
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const DeveloperFooter(),
        ],
      ),
    );
  }
}
