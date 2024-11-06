import 'package:swissflix/features/movies/data/models/movies.dart';

class GetMoviesRequest {
  final String page;
  final MovieCategory category;

  GetMoviesRequest({
    required this.page,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'type': category,
      };
}

class GetMovieRequest {
  final int movieId;

  GetMovieRequest({
    required this.movieId,
  });

  Map<String, dynamic> toJson() => {
        'movie_id': movieId,
      };
}
