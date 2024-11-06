import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:swissflix/core/utils/constants/enums.dart';
import 'package:swissflix/features/movies/data/models/movies.dart';
import 'package:swissflix/features/movies/data/models/request/movies_request.dart';
import 'package:swissflix/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:swissflix/features/movies/presentation/widgets/card_movie.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({super.key});

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 1);

  final pageSize = 10;
  late int pageNumber;

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      pageNumber = pageKey;

      context.read<MoviesBloc>().add(
            GetMoviesEvent(
              getMoviesRequest: GetMoviesRequest(
                page: (pageKey).toString(),
              ),
            ),
          );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesBloc, MoviesState>(
      listenWhen: (previous, current) =>
          previous.getMoviesService.requestStatus == RequestStatus.loading &&
          current.getMoviesService.requestStatus == RequestStatus.success,
      listener: (context, state) {
        if (state.getMoviesService.requestStatus == RequestStatus.success) {
          if ((state.getMoviesService.requestResponse?.movies ?? []).length <
              pageSize) {
            pagingController.appendLastPage(
                state.getMoviesService.requestResponse?.movies ?? []);
          } else {
            pageNumber = pageNumber + 1;

            pagingController.appendPage(
                state.getMoviesService.requestResponse?.movies ?? [],
                pageNumber);
          }
        }

        if (state.getMoviesService.requestStatus == RequestStatus.failed) {
          pagingController.error =
              (state.getMoviesService.failure?.message ?? "Error");
        }
      },
      child: PagedSliverList<int, Movie>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          itemBuilder: (context, item, index) => CardMovie(
            movie: item,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
