part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final Service<GetMoviesResponse> getMoviesService;

  MoviesState({
    Service<GetMoviesResponse>? getMoviesService,
  }) : getMoviesService = getMoviesService ?? Service<GetMoviesResponse>();

  MoviesState copyWith({
    Service<GetMoviesResponse>? getMoviesService,
  }) {
    return MoviesState(
      getMoviesService: getMoviesService ?? this.getMoviesService,
    );
  }

  @override
  List<Object?> get props => [
        getMoviesService,
      ];
}
