import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/models/movie.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/hero_banner.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';
import 'package:netflix_landing_ui/widgets/search_bar_widget.dart';
import 'package:netflix_landing_ui/widgets/section_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Movie> _results = [];
  bool _searched = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _searched = query.isNotEmpty;
      _results = MovieService.instance.searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      appBar: const NetflixAppBar(showBack: true, title: 'Search'),
      body: ListView(
        children: [
          SearchBarWidget(
            controller: _controller,
            onChanged: _search,
            autofocus: true,
          ),
          const SizedBox(height: 24),
          if (!_searched) ...[
            const SectionHeader(title: 'Popular Searches'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Action', 'Sci-Fi', 'Drama', 'Comedy', 'Horror']
                  .map(
                    (term) => ActionChip(
                      label: Text(term),
                      onPressed: () {
                        _controller.text = term;
                        _search(term);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Trending Now'),
            HorizontalMovieList(
              movies: MovieService.instance.getTrendingMovies(),
            ),
          ] else if (_results.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 64, color: AppColors.textMuted),
                    SizedBox(height: 16),
                    Text('No results found'),
                  ],
                ),
              ),
            )
          else ...[
            SectionHeader(title: '${_results.length} Results'),
            MovieThumbnailGrid(movies: _results),
          ],
        ],
      ),
    );
  }
}
