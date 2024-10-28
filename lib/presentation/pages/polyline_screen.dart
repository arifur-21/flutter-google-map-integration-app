import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.762027291991203, 90.43478586114382),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final List<LatLng> _latLngPoints = [
    const LatLng(23.762027291991203, 90.43478586114382),
    const LatLng(23.72235012580188, 90.48134908838955),
    const LatLng(23.761739269998937, 90.42170667286534),
    const LatLng(23.770167282605165, 90.43269294807322),
    const LatLng(23.773230086731918, 90.41312486613425),
  ];

  @override
  void initState() {
    super.initState();

    _addMarkersAndPolyline();
  }

  void _addMarkersAndPolyline() {
    // Adding markers for each location
    for (int i = 0; i < _latLngPoints.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLngPoints[i],
          infoWindow: const InfoWindow(
            title: 'Really cool place',
            snippet: '5 star rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }

    // Adding the polyline that connects all markers
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('1'),
        points: _latLngPoints,
        color: Colors.deepOrange,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          polylines: _polylines,
          markers: _markers,
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}