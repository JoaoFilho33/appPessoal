import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-5.088829908327693, -42.81126191734898);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 18.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId("01"),
          position: LatLng(-5.0888332,-42.8138367),
        ),
        Marker(
          markerId: MarkerId("02"),
          position: LatLng(-5.085447,-42.8013809),
        ),
        Marker(
          markerId: MarkerId("03"),
          position: LatLng(-5.0886577,-42.7388641),
        ),
      },
    );
  }
}
