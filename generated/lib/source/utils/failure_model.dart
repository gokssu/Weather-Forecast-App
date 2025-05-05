import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure_model.g.dart';

@JsonSerializable()
class Failure extends Equatable {
  const Failure({
    required this.message,
    this.errorCode,
    this.uri,
    required this.statusCode,
    this.errorSource,
    this.sourceMessage,
    this.helpUri,
    this.isShow = false,
  });

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);
  final String message;
  final dynamic errorCode;
  final String? uri;
  final int? statusCode;
  final String? errorSource;
  final String? sourceMessage;
  final String? helpUri;
  final bool isShow;

  Map<String, dynamic> toJson() => _$FailureToJson(this);

  @override
  List<Object?> get props => [
    message,
    errorCode,
    uri,
    statusCode,
    errorSource,
    sourceMessage,
    helpUri,
    isShow,
  ];

  @override
  bool get stringify => true;
}
