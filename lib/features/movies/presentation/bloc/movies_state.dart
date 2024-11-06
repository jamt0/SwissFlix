part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final Service<GetMoviesResponse> getMoviesService;
  final Service<GetMovieResponse> getMovieService;

  MoviesState({
    Service<GetMoviesResponse>? getMoviesService,
    Service<GetMovieResponse>? getMovieService,
  })  : getMoviesService = getMoviesService ?? Service<GetMoviesResponse>(),
        getMovieService = getMovieService ?? Service<GetMovieResponse>();

  MoviesState copyWith({
    Service<GetMoviesResponse>? getMoviesService,
    Service<GetMovieResponse>? getMovieService,
  }) {
    return MoviesState(
      getMoviesService: getMoviesService ?? this.getMoviesService,
      getMovieService: getMovieService ?? this.getMovieService,
    );
  }

  @override
  List<Object?> get props => [
        getMoviesService,
        getMovieService,
      ];
}
