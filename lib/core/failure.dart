class Failure {
  const Failure({this.message});

  final String? message;

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      message: json["message"],
    );
  }
}
