import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:generated/source/utils/failure_model.dart';

part 'network_failure.freezed.dart';

@freezed
abstract class NetworkFailure with _$NetworkFailure {
  const factory NetworkFailure.requestCancelled() = RequestCancelled;

  const factory NetworkFailure.unauthorizedRequest(
    String reason,
    int code,
    String id,
  ) = UnauthorizedRequest;

  const factory NetworkFailure.badRequest() = BadRequest;

  const factory NetworkFailure.notFound(String reason) = NotFound;

  const factory NetworkFailure.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkFailure.notAcceptable() = NotAcceptable;

  const factory NetworkFailure.requestTimeout() = RequestTimeout;

  const factory NetworkFailure.sendTimeout() = SendTimeout;

  const factory NetworkFailure.conflict() = Conflict;

  const factory NetworkFailure.internalServerError() = InternalServerError;

  const factory NetworkFailure.notImplemented() = NotImplemented;

  const factory NetworkFailure.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkFailure.noInternetConnection() = NoInternetConnection;

  const factory NetworkFailure.formatException() = FormatException;

  const factory NetworkFailure.unableToProcess() = UnableToProcess;

  const factory NetworkFailure.defaultError(String error, int code) =
      DefaultError;

  const factory NetworkFailure.unexpectedError() = UnexpectedError;

  static Failure process(error) => getErrorMessage(_createError(error));

  static NetworkFailure _createError(error) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return const NetworkFailure.requestCancelled();
          case DioExceptionType.connectionTimeout:
            return const NetworkFailure.requestTimeout();
          case DioExceptionType.connectionError:
            return const NetworkFailure.noInternetConnection();
          case DioExceptionType.receiveTimeout:
            return const NetworkFailure.sendTimeout();
          case DioExceptionType.unknown:
            return _handleResponse(
              Failure(
                statusCode: error.response?.statusCode,
                message: error.response?.statusMessage ?? '',
              ),
            );
          case DioExceptionType.sendTimeout:
            return const NetworkFailure.sendTimeout();
          case DioExceptionType.badCertificate:
            return const NetworkFailure.unexpectedError();
          case DioExceptionType.badResponse:
            return const NetworkFailure.unexpectedError();
        }
      } else if (error is SocketException) {
        return const NetworkFailure.noInternetConnection();
      } else {
        return const NetworkFailure.unexpectedError();
      }
    } on FormatException {
      return const NetworkFailure.formatException();
    } catch (e) {
      return const NetworkFailure.unexpectedError();
    }
  }

  static Failure getErrorMessage(NetworkFailure networkFailure) {
    var errorMessage = '';
    var code = 0;
    networkFailure.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method not allowed';
      },
      badRequest: () {
        errorMessage = 'Bad request';
      },
      unauthorizedRequest: (String error, int codeNew, String id) {
        errorMessage = error;
        code = codeNew;
      },
      unexpectedError: () {
        errorMessage = 'Unexpected error occurred';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      noInternetConnection: () {
        errorMessage = 'No internet connection';
      },
      conflict: () {
        errorMessage = 'Error due to a conflict';
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error, int codeNew) {
        errorMessage = error;
        code = codeNew;
      },
      formatException: () {
        errorMessage = 'Incorrect format';
      },
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
    );
    return Failure(message: errorMessage, statusCode: code);
  }

  static NetworkFailure _handleResponse(Failure response) {
    final statusCode = response.statusCode ?? 0;
    var statusMessage = '';
    const id = '';

    if (response.message.isNotEmpty) {
      if (response.message.runtimeType == String) {
        statusMessage = response.message;
      } else {
        statusMessage = response.message;
      }
    }

    switch (statusCode) {
      case 400:
        return const NetworkFailure.badRequest();
      case 401:
        return NetworkFailure.unauthorizedRequest(
          statusMessage,
          statusCode,
          id,
        );
      case 403:
        return NetworkFailure.unauthorizedRequest(
          statusMessage,
          statusCode,
          id,
        );
      case 404:
        return NetworkFailure.notFound(statusMessage);
      case 409:
        return const NetworkFailure.conflict();
      case 408:
        return const NetworkFailure.requestTimeout();
      case 500:
        return const NetworkFailure.internalServerError();
      case 503:
        return const NetworkFailure.serviceUnavailable();
      default:
        return NetworkFailure.defaultError('Unauthorized user', statusCode);
    }
  }
}
