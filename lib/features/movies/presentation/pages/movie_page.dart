import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swissflix/core/utils/constants/enums.dart';
import 'package:swissflix/core/utils/constants/urls.dart';
import 'package:swissflix/features/movies/data/models/request/movies_request.dart';
import 'package:swissflix/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:swissflix/routes/router.dart';
import 'package:swissflix/styles/custom_colors.dart';
import 'package:swissflix/styles/custom_text_styles.dart';

class MoviePage extends StatefulWidget {
  final String movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    context.read<MoviesBloc>().add(
          GetMovieEvent(
            getMovieRequest: GetMovieRequest(
              movieId: int.parse(widget.movieId),
            ),
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        print(state.getMovieService.requestStatus);
        if (state.getMovieService.requestStatus == RequestStatus.initial) {
          return Container();
        }

        if (state.getMovieService.requestStatus == RequestStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        var movie = state.getMovieService.requestResponse?.movie;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Movie",
              style: CustomTextStyle.title(CustomColors.primary),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: CustomColors.primary,
              ),
              onPressed: () {
                //TODO: Fix error bucle navegacion
                if (router.canPop()) {
                  router.pop(context);
                } else {
                  router.replace(NamesRoustes.movies);
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage("$imgurl${movie?.posterPath}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, top: 18),
                    child: Text(movie?.title ?? "",
                        style: CustomTextStyle.title(Colors.black)),
                  ),
                  Text(
                    movie?.overview ?? "",
                    style: CustomTextStyle.body(Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
