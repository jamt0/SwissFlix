import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swissflix/core/failure.dart';
import 'package:swissflix/core/service.dart';
import 'package:swissflix/core/utils/constants/enums.dart';
import 'package:swissflix/features/movies/data/api/movies_api.dart';
import 'package:swissflix/features/movies/data/models/request/movies_request.dart';
import 'package:swissflix/features/movies/data/models/responses/movies_responses.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  //TODO: Inyecccion de dependecias
  final moviesApi = MoviesApi();

  MoviesBloc() : super(MoviesState()) {
    on<GetMoviesEvent>(getMovies);
  }

  FutureOr<void> getMovies(
    GetMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    emit(
      state.copyWith(
        getMoviesService: state.getMoviesService.copyWith(
          requestStatus: RequestStatus.loading,
        ),
      ),
    );
    await moviesApi
        .getMovies(getMoviesRequest: event.getMoviesRequest)
        .then((either) async {
      either.fold(
        (failure) {
          emit(
            state.copyWith(
              getMoviesService: state.getMoviesService.copyWith(
                requestStatus: RequestStatus.failed,
                failure: failure,
              ),
            ),
          );
        },
        (response) async {
          emit(
            state.copyWith(
              getMoviesService: state.getMoviesService.copyWith(
                requestStatus: RequestStatus.success,
                requestResponse: response,
              ),
            ),
          );
        },
      );
    }).catchError(
      (error) {
        emit(state.copyWith(
          getMoviesService: state.getMoviesService.copyWith(
            requestStatus: RequestStatus.failed,
            failure: Failure(message: error.toString()),
          ),
        ));
      },
    );
  }
}
