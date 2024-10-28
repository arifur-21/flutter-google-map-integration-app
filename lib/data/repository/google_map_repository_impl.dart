import 'package:flutter_googel_map_app/core/markers/list_of_marker.dart';
import 'package:flutter_googel_map_app/domain/enitites/marker_entity.dart';
import 'package:flutter_googel_map_app/domain/repository/google_map_repository.dart';

import '../../core/response_status/google_map_response.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  @override
  Future<GoogleMapResponse<List<MarkerEntity>>> getMarkers() async {
    try {
      return GoogleMapResponse.completed(ListOfMarker.getMarkers());
    } catch (e) {
      return GoogleMapResponse.error('Failed to fetch markers: $e');
    }
  }
}
