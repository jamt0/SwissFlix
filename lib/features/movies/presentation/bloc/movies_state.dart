part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final Map<String, Service<GetMoviesResponse>> getMoviesServices;
  final Service<GetMovieResponse> getMovieService;

  MoviesState({
    Map<String, Service<GetMoviesResponse>>? getMoviesServices,
    Service<GetMovieResponse>? getMovieService,
  })  : getMoviesServices =
            getMoviesServices ?? <String, Service<GetMoviesResponse>>{},
        getMovieService = getMovieService ?? Service<GetMovieResponse>();

  MoviesState copyWith({
    Map<String, Service<GetMoviesResponse>>? getMoviesServices,
    Service<GetMovieResponse>? getMovieService,
  }) {
    return MoviesState(
      getMoviesServices: getMoviesServices ?? this.getMoviesServices,
      getMovieService: getMovieService ?? this.getMovieService,
    );
  }

  @override
  List<Object?> get props => [
        getMoviesServices,
        getMovieService,
      ];
}
