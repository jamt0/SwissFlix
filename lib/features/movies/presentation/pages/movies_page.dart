import 'package:flutter/material.dart';
import 'package:swissflix/features/movies/presentation/components/list_movies.dart';
import 'package:swissflix/styles/custom_colors.dart';
import 'package:swissflix/styles/custom_text_styles.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: CustomTextStyle.title(CustomColors.primary),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ListMovies(),
            ListMovies(),
            ListMovies(),
          ],
        ),
      ),
    );
  }
}
