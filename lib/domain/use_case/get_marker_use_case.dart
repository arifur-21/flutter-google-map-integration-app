import 'package:flutter_googel_map_app/core/response_status/google_map_response.dart';
import 'package:flutter_googel_map_app/domain/repository/google_map_repository.dart';

import '../enitites/marker_entity.dart';

class GetMarkerUseCase {
  final GoogleMapRepository repository;

  GetMarkerUseCase(this.repository);

  Future<GoogleMapResponse<List<MarkerEntity>>> execute()async{
    return await repository.getMarkers();
  }
}
