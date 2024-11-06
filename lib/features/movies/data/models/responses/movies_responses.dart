import 'package:swissflix/core/utils/helpers/list_from_json.dart';
import 'package:swissflix/features/movies/data/models/movies.dart';

class GetMoviesResponse {
  final List<Movie> movies;

  GetMoviesResponse({
    required this.movies,
  });

  factory GetMoviesResponse.fromJson(Map<String, dynamic> json) {
    return GetMoviesResponse(
      movies: listFromJson<Movie>(json["results"], Movie.fromJson),
    );
  }
}

class GetMovieResponse {
  final MovieById movie;

  GetMovieResponse({
    required this.movie,
  });

  factory GetMovieResponse.fromJson(Map<String, dynamic> json) {
    return GetMovieResponse(
      movie: MovieById.fromJson(json),
    );
  }
}
