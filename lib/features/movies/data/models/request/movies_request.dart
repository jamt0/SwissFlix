class GetMoviesRequest {
  final String page;

  GetMoviesRequest({
    required this.page,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
      };
}
