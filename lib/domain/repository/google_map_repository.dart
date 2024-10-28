import 'package:flutter_googel_map_app/core/response_status/google_map_response.dart';

import '../enitites/marker_entity.dart';

abstract class GoogleMapRepository {

  Future <GoogleMapResponse<List<MarkerEntity>>> getMarkers();
}