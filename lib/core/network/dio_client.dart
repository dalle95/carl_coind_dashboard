import 'package:carl_coind_dashboard/core/constants/api_url.dart';
import 'package:dio/dio.dart';

import 'interceptors.dart';

class DioClient {
  late final Dio _dio;
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiUrl.baseURL,
            headers: {},
            contentType: "application/vnd.api+json",
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            validateStatus: (status) {
              // Consente di accettare tutti i codici di stato
              return status != null && status < 500;
            },
          ),
        )..interceptors.addAll(
            [AuthorizationInterceptor() /*, LoggerInterceptor()*/],
          );

  // AUTH METHOD
  Future<Response> authentication(
    dynamic data,
  ) async {
    // Definisco il Content-Type specifico per la chiamata di autenticazione
    Options requestOptions = Options(
      contentType: Headers.formUrlEncodedContentType,
    );

    try {
      final Response response = await _dio.post(
        '${ApiUrl.authentication}?login=${data.username}&password=${data.password}&origin=ORIGIN',
        // queryParameters: {
        //   'login': data.username,
        //   'password': data.password,
        //   'origin': 'ORIGIN',
        // },
        options: requestOptions,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
