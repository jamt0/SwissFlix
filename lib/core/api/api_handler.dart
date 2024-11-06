import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:swissflix/core/failure.dart';

//TODO: configurar url

class ApiHandler {
  final String _baseUrl = "https://api.themoviedb.org/3";
  final Dio _dio = createDio();

  Future<Either<Failure, T>> post<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> data) mapper,
    required Map<String, dynamic> data,
    bool secured = false,
    FormData? formData,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl$endpoint',
        data: formData ?? data,
        options: await getRequestOptions(secured: secured),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> json = {"data": response.data};

        if (response.data is String) {
          json = jsonDecode(response.data);
        }
        return Right(mapper(json));
      } else {
        return const Left(Failure());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.runtimeType == DioException) {
        var dioException = e as DioException;

        var json = dioException.response?.data;

        return Left(Failure.fromJson(json));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, T>> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> data) mapper,
    Map<String, dynamic>? query,
    bool secured = false,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl$endpoint',
        queryParameters: query,
        options: await getRequestOptions(secured: secured),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> json = {"data": response.data};
        if (response.data is String) {
          json = jsonDecode(response.data);
        }
        return Right(mapper(json));
      } else {
        return const Left(Failure());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.runtimeType == DioException) {
        var dioException = e as DioException;

        var json = dioException.response?.data;

        return Left(Failure.fromJson(json));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Options> getRequestOptions({required bool secured}) async {
    var requestHeaders = HashMap<String, String>();

    if (secured) {
      //Get token
    }
    return Options(
      headers: requestHeaders,
      responseType: ResponseType.json,
    );
  }
}

Dio createDio() {
  final dio = Dio();
  return dio;
}
