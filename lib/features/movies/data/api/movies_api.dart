import 'package:dartz/dartz.dart';
import 'package:swissflix/core/api/api_handler.dart';
import 'package:swissflix/core/failure.dart';
import 'package:swissflix/features/movies/data/models/request/movies_request.dart';
import 'package:swissflix/features/movies/data/models/responses/movies_responses.dart';

class PostApi {
  //TODO: Inyeccion de dependencias
  ApiHandler apiHandler = ApiHandler();

  Future<Either<Failure, GetMoviesResponse>> getMovies({
    required GetMoviesRequest getPostsRequest,
  }) {
    return apiHandler.get<GetMoviesResponse>(
      endpoint: "/movie/popular?language=en-US&page=${getPostsRequest.page}",
      //TODO: Verificar data
      mapper: (data) => GetMoviesResponse.fromJson({"movies": data["data"]}),
    );
  }
}
