import 'package:flutter_googel_map_app/core/enum/google_map_status.dart';


enum Status { loading, completed, error }

// lib/core/google_map_response.dart
class GoogleMapResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  GoogleMapResponse({required this.status, this.data, this.message});

  factory GoogleMapResponse.loading() => GoogleMapResponse(status: Status.loading);
  factory GoogleMapResponse.completed(T data) => GoogleMapResponse(status: Status.completed, data: data);
  factory GoogleMapResponse.error([String? message]) => GoogleMapResponse(status: Status.error, message: message);
}