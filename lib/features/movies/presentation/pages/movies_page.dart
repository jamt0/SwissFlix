import 'package:flutter/material.dart';
import 'package:swissflix/features/movies/data/models/movies.dart';
import 'package:swissflix/features/movies/presentation/components/list_movies.dart';
import 'package:swissflix/styles/custom_colors.dart';
import 'package:swissflix/styles/custom_text_styles.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'SwissFLix',
          style: CustomTextStyle.title(CustomColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: Text("Populares",
                  style: CustomTextStyle.title(CustomColors.text)),
            ),
            const ListMovies(
              category: MovieCategory.popular,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Text("Mejor Calificadas ",
                  style: CustomTextStyle.title(CustomColors.text)),
            ),
            const ListMovies(
              category: MovieCategory.top_rated,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
              ),
              child: Text("Próximas Estrenos",
                  style: CustomTextStyle.title(CustomColors.text)),
            ),
            const ListMovies(
              category: MovieCategory.upcoming,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 50)),
          ],
        ),
      ),
    );
  }
}
