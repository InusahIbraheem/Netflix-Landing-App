import 'package:netflix_landing_ui/models/movie.dart';

class ContinueWatchingItem {
  const ContinueWatchingItem({
    required this.movie,
    required this.progress,
    required this.lastWatched,
  });

  final Movie movie;
  final double progress;
  final String lastWatched;
}
