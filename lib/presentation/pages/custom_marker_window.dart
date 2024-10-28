import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final CustomInfoWindowController _windowController = CustomInfoWindowController();

  final List<Marker> _markers = [];
  final List<LatLng> _latLngList = [
    LatLng(23.762027291991203, 90.43478586114382),
    LatLng(23.761739269998937, 90.42170667286534),
    LatLng(23.770167282605165, 90.43269294807322),
    LatLng(23.773230086731918, 90.41312486613425),
    LatLng(23.780698884957687, 90.42714674556531),
    LatLng(23.72235012580188, 90.48134908838955),
  ];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    for (int i = 0; i < _latLngList.length; i++) {
      final marker = Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.defaultMarker,
        position: _latLngList[i],
        onTap: () {
          _windowController.addInfoWindow!(
            _buildInfoWindowContent(i),
            _latLngList[i],
          );
        },
      );
      _markers.add(marker);
    }
    setState(() {}); // Call setState once after all markers are added.
  }

  Widget _buildInfoWindowContent(int index) {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.green : Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: index % 2 == 0
          ? const Center(child: CircleAvatar(radius: 30, backgroundColor: Colors.blue))
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg'),
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.red,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    "Bref Tecas",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
                const Spacer(),
                const Text("sfsf sfkljsjf "),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _windowController.dispose(); // Dispose of the controller to free up resources.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(23.762027291991203, 90.43478586114382),
              zoom: 14,
            ),
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _windowController.hideInfoWindow?.call();
            },
            onCameraMove: (position) {
              _windowController.onCameraMove?.call();
            },
            onMapCreated: (GoogleMapController controller) {
              _windowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _windowController,
            height: 100,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}