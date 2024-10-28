import '../../domain/enitites/marker_entity.dart';

class ListOfMarker{

  static List<MarkerEntity> getMarkers(){
    return [
      MarkerEntity(id: '1', latitude: 23.8103, longitude: 90.4125, title: 'My Current Position'),
      MarkerEntity(id: '2', latitude: 23.8118, longitude: 90.4139, title: 'My Position'),
      MarkerEntity(id: '3', latitude: 23.8228, longitude: 90.4259, title: 'Kuril'),
      MarkerEntity(id: '4', latitude: 23.9103, longitude: 90.3125, title: 'Kuril'),
    ];
    
  }
}