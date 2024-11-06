import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:swissflix/core/utils/constants/enums.dart';
import 'package:swissflix/features/movies/data/models/movies.dart';
import 'package:swissflix/features/movies/data/models/request/movies_request.dart';
import 'package:swissflix/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:swissflix/features/movies/presentation/widgets/card_movie.dart';
import 'package:swissflix/styles/custom_colors.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({super.key});

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  final PagingController<int, Movie> pagingController =
      PagingController(firstPageKey: 1);

  final ScrollController scrollController = ScrollController();

  final pageSize = 10;
  late int pageNumber;

  void _scrollLeft(ScrollController controller) {
    controller.animateTo(
      controller.offset - 500,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight(ScrollController controller) {
    controller.animateTo(
      controller.offset + 500,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

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
    double screenWidth = MediaQuery.of(context).size.width;

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
      child: Row(
        children: [
          if (kIsWeb && screenWidth > 500)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: CustomColors.text,
                ),
                onPressed: () => _scrollLeft(scrollController),
              ),
            ),
          Expanded(
            child: SizedBox(
              height: kIsWeb && screenWidth > 500 ? 350 : 185,
              child: PagedListView<int, Movie>(
                pagingController: pagingController,
                scrollController: scrollController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  newPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: CustomColors.primary,
                        ),
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          color: CustomColors.primary,
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, item, index) => CardMovie(
                    movie: item,
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          if (kIsWeb && screenWidth > 500)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: CustomColors.text,
                ),
                onPressed: () => _scrollRight(scrollController),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
