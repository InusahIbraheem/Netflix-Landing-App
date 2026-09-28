import 'package:netflix_landing_ui/models/category.dart';
import 'package:netflix_landing_ui/models/continue_watching_item.dart';
import 'package:netflix_landing_ui/models/movie.dart';
import 'package:netflix_landing_ui/models/user_profile.dart';

class MovieService {
  MovieService._();
  static final MovieService instance = MovieService._();

  final List<String> _myListIds = ['1', '3', '7', '12'];

  static const List<Category> categories = [
    Category(id: 'action', name: 'Action', iconName: 'explosion'),
    Category(id: 'drama', name: 'Drama', iconName: 'theater'),
    Category(id: 'comedy', name: 'Comedy', iconName: 'mood'),
    Category(id: 'scifi', name: 'Sci-Fi', iconName: 'rocket'),
    Category(id: 'horror', name: 'Horror', iconName: 'nightlight'),
    Category(id: 'documentary', name: 'Documentary', iconName: 'menu_book'),
    Category(id: 'romance', name: 'Romance', iconName: 'favorite'),
    Category(id: 'thriller', name: 'Thriller', iconName: 'psychology'),
  ];

  static const UserProfile profile = UserProfile(
    name: 'Inusah Ibraheem',
    email: 'inusah.ibraheem@example.com',
    avatarUrl: 'https://picsum.photos/seed/netflix-profile/200/200',
    plan: 'Premium',
    memberSince: 'January 2022',
  );

  static final List<Movie> _movies = [
    _movie(
      '1',
      'Shadow Protocol',
      'A covert operative uncovers a global conspiracy that threatens to collapse world governments.',
      'action',
      8.7,
      2024,
      '2h 18m',
      true,
    ),
    _movie(
      '2',
      'Midnight Echoes',
      'In a city that never sleeps, a detective hunts a serial killer who leaves cryptic messages.',
      'thriller',
      8.2,
      2023,
      '1h 52m',
      true,
    ),
    _movie(
      '3',
      'Starfall Horizon',
      'Humanity\'s last colony ship encounters an ancient alien civilization at the edge of the galaxy.',
      'scifi',
      9.1,
      2025,
      '2h 34m',
      true,
    ),
    _movie(
      '4',
      'Laugh Track',
      'A struggling comedian finds fame overnight after a viral stand-up routine goes global.',
      'comedy',
      7.8,
      2022,
      '1h 45m',
      false,
    ),
    _movie(
      '5',
      'The Last Garden',
      'Two estranged siblings inherit a vineyard and must reconcile before it is sold to developers.',
      'drama',
      8.5,
      2023,
      '2h 05m',
      false,
    ),
    _movie(
      '6',
      'Whispers in the Dark',
      'A family moves into a remote farmhouse only to discover it was built on cursed land.',
      'horror',
      7.4,
      2021,
      '1h 38m',
      false,
    ),
    _movie(
      '7',
      'Ocean\'s Depth',
      'Marine biologists document the discovery of a bioluminescent ecosystem miles beneath the sea.',
      'documentary',
      8.9,
      2024,
      '1h 28m',
      true,
    ),
    _movie(
      '8',
      'Paper Hearts',
      'Two writers fall in love while collaborating on a bestselling romance novel.',
      'romance',
      7.6,
      2022,
      '1h 56m',
      false,
    ),
    _movie(
      '9',
      'Iron Vanguard',
      'An elite military unit is sent to neutralize a rogue AI controlling autonomous weapons.',
      'action',
      8.0,
      2025,
      '2h 12m',
      true,
    ),
    _movie(
      '10',
      'Neon Dreams',
      'A cyberpunk hacker races against time to expose a megacorporation\'s dark experiments.',
      'scifi',
      8.3,
      2024,
      '2h 01m',
      true,
    ),
    _movie(
      '11',
      'Silent Witness',
      'A forensic analyst reopens a cold case that hits closer to home than she expected.',
      'drama',
      8.1,
      2023,
      '1h 49m',
      false,
    ),
    _movie(
      '12',
      'Crimson Tide Rising',
      'Naval officers must prevent a geopolitical crisis after a submarine goes missing.',
      'thriller',
      7.9,
      2024,
      '2h 22m',
      true,
    ),
  ];

  static Movie _movie(
    String id,
    String title,
    String description,
    String categoryId,
    double rating,
    int year,
    String duration,
    bool isTrending,
  ) {
    return Movie(
      id: id,
      title: title,
      description: description,
      posterUrl: 'https://picsum.photos/seed/netflix-poster-$id/300/450',
      bannerUrl: 'https://picsum.photos/seed/netflix-banner-$id/1200/600',
      genres: _genresForCategory(categoryId),
      rating: rating,
      year: year,
      duration: duration,
      isTrending: isTrending,
      categoryId: categoryId,
    );
  }

  static List<String> _genresForCategory(String categoryId) {
    final category = categories.firstWhere((c) => c.id == categoryId);
    return [category.name, 'Featured'];
  }

  List<Movie> getAllMovies() => List.unmodifiable(_movies);

  List<Movie> getTrendingMovies() =>
      _movies.where((m) => m.isTrending).toList();

  List<Movie> getMoviesByCategory(String categoryId) =>
      _movies.where((m) => m.categoryId == categoryId).toList();

  Movie? getMovieById(String id) {
    try {
      return _movies.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Movie> searchMovies(String query) {
    if (query.trim().isEmpty) return [];
    final lower = query.toLowerCase();
    return _movies
        .where(
          (m) =>
              m.title.toLowerCase().contains(lower) ||
              m.genres.any((g) => g.toLowerCase().contains(lower)),
        )
        .toList();
  }

  List<ContinueWatchingItem> getContinueWatching() {
    return [
      ContinueWatchingItem(
        movie: _movies[0],
        progress: 0.72,
        lastWatched: '2 days ago',
      ),
      ContinueWatchingItem(
        movie: _movies[2],
        progress: 0.45,
        lastWatched: 'Yesterday',
      ),
      ContinueWatchingItem(
        movie: _movies[6],
        progress: 0.18,
        lastWatched: '3 hours ago',
      ),
      ContinueWatchingItem(
        movie: _movies[9],
        progress: 0.91,
        lastWatched: '1 week ago',
      ),
    ];
  }

  List<Movie> getMyList() =>
      _movies.where((m) => _myListIds.contains(m.id)).toList();

  bool isInMyList(String movieId) => _myListIds.contains(movieId);

  void toggleMyList(String movieId) {
    if (_myListIds.contains(movieId)) {
      _myListIds.remove(movieId);
    } else {
      _myListIds.add(movieId);
    }
  }

  Movie getFeaturedMovie() => _movies.first;
}
