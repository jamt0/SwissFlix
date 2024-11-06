import 'package:swissflix/core/failure.dart';
import 'package:swissflix/core/utils/constants/enums.dart';

class Service<T> {
  final RequestStatus requestStatus;
  final T? requestResponse;
  final Failure? failure;

  Service({
    this.requestStatus = RequestStatus.initial,
    this.requestResponse,
    this.failure,
  });

  Service<T> copyWith({
    RequestStatus? requestStatus,
    T? requestResponse,
    Failure? failure,
  }) {
    return Service<T>(
      requestStatus: requestStatus ?? this.requestStatus,
      requestResponse: requestResponse ?? this.requestResponse,
      failure: failure ?? this.failure,
    );
  }
}
