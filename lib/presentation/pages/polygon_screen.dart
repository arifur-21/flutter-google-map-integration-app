import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
  CameraPosition(target: LatLng(23.8103, 90.4125), zoom: 14);

  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = HashSet<Polygon>();

  final List<LatLng> points = [
    const LatLng(23.762027291991203, 90.43478586114382),
    const LatLng(23.72235012580188, 90.48134908838955),
    const LatLng(23.761739269998937, 90.42170667286534),
    const LatLng(23.770167282605165, 90.43269294807322),
    const LatLng(23.773230086731918, 90.41312486613425),
    const LatLng(23.762027291991203, 90.43478586114382),
  ];

  @override
  void initState() {
    super.initState();
    _polygons.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.2),
        strokeWidth: 4,
        geodesic: true,
        strokeColor: Colors.deepOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          polygons: _polygons,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}