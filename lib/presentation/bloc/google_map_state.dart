import 'package:flutter_googel_map_app/core/response_status/google_map_response.dart';

import '../../domain/enitites/marker_entity.dart';

class GoogleMapState {
  final GoogleMapResponse<List<MarkerEntity>> markers;
  final Status status;

  GoogleMapState({
    required this.markers,
    this.status = Status.loading,
  });

  GoogleMapState copyWith({
    GoogleMapResponse<List<MarkerEntity>>? markers,
    Status? status,
  }) {
    return GoogleMapState(
      markers: markers ?? this.markers,
      status: status ?? this.status,
    );
  }
}
