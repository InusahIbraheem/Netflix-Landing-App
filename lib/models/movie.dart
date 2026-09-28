class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.bannerUrl,
    required this.genres,
    required this.rating,
    required this.year,
    required this.duration,
    required this.isTrending,
    required this.categoryId,
  });

  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String bannerUrl;
  final List<String> genres;
  final double rating;
  final int year;
  final String duration;
  final bool isTrending;
  final String categoryId;

  String get genresLabel => genres.join(' • ');
}
