
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_googel_map_app/core/response_status/google_map_response.dart';
import 'package:flutter_googel_map_app/presentation/bloc/google_map_bloc.dart';
import 'package:flutter_googel_map_app/presentation/bloc/google_map_event.dart';
import 'package:flutter_googel_map_app/presentation/bloc/google_map_state.dart';
import 'package:flutter_googel_map_app/presentation/pages/get_current_location.dart';
import 'package:flutter_googel_map_app/presentation/pages/custom_marker_window.dart';
import 'package:flutter_googel_map_app/presentation/pages/polygon_screen.dart';
import 'package:flutter_googel_map_app/presentation/pages/polyline_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapBloc _bloc;
  late CameraPosition cameraPosition;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _bloc = GoogleMapBloc(getMarkersUseCase: getIt());
    cameraPosition = const CameraPosition(target: LatLng(23.8103, 90.4125), zoom: 14);
    _bloc.add(LoadMarkerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          title: const Text("Google Map1"),
        
        actions: [
          PopupMenuButton<String>(
            onSelected: (value){
              if(value == 'Current Position'){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetCurrentLocation()));
              }
              else if(value == 'Custom Marker'){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomMarkerInfoWindow()));
              }

              else if(value == 'Polygon'){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PolygonScreen()));
              }
              else if(value == 'Polyline'){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PolylineScreen()));
              }
            },
              
              itemBuilder: (BuildContext context){
              return [
               const PopupMenuItem<String>(
                  value: 'Current Position',
                    child: Text("Current Position")),

               const PopupMenuItem<String>(
                    value: 'Custom Marker',
                    child: Text("Custom Marker")),

                const PopupMenuItem<String>(
                    value: 'Polygon',
                    child: Text("Polygon")),

                const PopupMenuItem<String>(
                    value: 'Polyline',
                    child: Text("Polyline")),
              ];
              })
        ],
      
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == Status.completed) {
              final markers = state.markers.data!.map((entity) {
                return Marker(
                  markerId: MarkerId(entity.id),
                  position: LatLng(entity.latitude, entity.longitude),
                  infoWindow: InfoWindow(title: entity.title),
                );
              }).toSet();

              return GoogleMap(
                initialCameraPosition: cameraPosition,
                mapType: MapType.normal,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(target: LatLng(23.9103, 90.3125), zoom: 14),
          ));
        },
        child: const Icon(Icons.location_disabled),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
