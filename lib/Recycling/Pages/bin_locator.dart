import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const BinLocator());
}

class BinLocator extends StatefulWidget {
  const BinLocator({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BinLocatorState createState() => _BinLocatorState();

}

class _BinLocatorState extends State<BinLocator> {

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(1.296568, 103.852119);

  // Setting the controller:
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          onMapCreated: _onMapCreated,
        ),
        bottomNavigationBar: const BottomBar(),
      );
  }
}