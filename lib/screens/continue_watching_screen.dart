import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';

class ContinueWatchingScreen extends StatelessWidget {
  const ContinueWatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = MovieService.instance.getContinueWatching();

    return ScreenScaffold(
      appBar: const NetflixAppBar(showBack: true, title: 'Continue Watching'),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return VideoCard(
            movie: item.movie,
            progress: item.progress,
            subtitle: '${item.lastWatched} • ${(item.progress * 100).round()}% complete',
          );
        },
      ),
    );
  }
}
