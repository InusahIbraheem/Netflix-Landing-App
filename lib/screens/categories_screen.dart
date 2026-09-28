import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/models/category.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/category_chip.dart';
import 'package:netflix_landing_ui/widgets/movie_card.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';
import 'package:netflix_landing_ui/widgets/section_header.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Category _selected = MovieService.categories.first;

  @override
  Widget build(BuildContext context) {
    final movies = MovieService.instance.getMoviesByCategory(_selected.id);

    return ScreenScaffold(
      appBar: const NetflixAppBar(showBack: true, title: 'Categories'),
      body: ListView(
        children: [
          const SectionHeader(title: 'Browse by Genre'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MovieService.categories.map((category) {
              return CategoryChip(
                category: category,
                isSelected: _selected.id == category.id,
                onTap: () => setState(() => _selected = category),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SectionHeader(title: '${_selected.name} Movies'),
          MovieThumbnailGrid(movies: movies),
        ],
      ),
    );
  }
}
