import 'package:dartz/dartz.dart';
import 'package:swissflix/core/api/api_handler.dart';
import 'package:swissflix/core/failure.dart';
import 'package:swissflix/features/movies/data/models/request/movies_request.dart';
import 'package:swissflix/features/movies/data/models/responses/movies_responses.dart';

class MoviesApi {
  //TODO: Inyeccion de dependencias
  ApiHandler apiHandler = ApiHandler();

  Future<Either<Failure, GetMoviesResponse>> getMovies({
    required GetMoviesRequest getMoviesRequest,
  }) {
    return apiHandler.get<GetMoviesResponse>(
      secured: true,
      endpoint: "/movie/popular?language=en-US&page=${getMoviesRequest.page}",
      mapper: (data) => GetMoviesResponse.fromJson(data["data"]),
    );
  }

  Future<Either<Failure, GetMovieResponse>> getMovie({
    required GetMovieRequest getMovieRequest,
  }) {
    return apiHandler.get<GetMovieResponse>(
      secured: true,
      endpoint: "/movie/${getMovieRequest.movieId}?language=en-US",
      mapper: (data) => GetMovieResponse.fromJson(data["data"]),
    );
  }
}
