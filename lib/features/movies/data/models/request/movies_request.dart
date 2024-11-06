class GetMoviesRequest {
  final String page;

  GetMoviesRequest({
    required this.page,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
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
