part of 'movies_bloc.dart';

class MoviesEvent {}

class GetMoviesEvent extends MoviesEvent {
  final GetMoviesRequest getMoviesRequest;
  GetMoviesEvent({required this.getMoviesRequest});
}
