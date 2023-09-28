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

  // We need markers for the bins:
  final Set<Marker> _markers = {
    // Bin 1:
    Marker(
      markerId: const MarkerId('bin1'),
      position: const LatLng(1.296568, 103.852119),
      infoWindow: const InfoWindow(
        title: 'Bin 1 - Paper',
        snippet: 'Please deposit paper waste here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ),
    // Bin 2:
    // Bin 3:
    // Bin 4:
    // Bin 5:
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bin Locator'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
          onMapCreated: _onMapCreated,
          markers: {
            for (final marker in _markers)
              Marker(
                markerId: MarkerId(marker.markerId.value),
                position: marker.position,
                infoWindow: InfoWindow(
                  title: marker.infoWindow.title,
                  snippet: marker.infoWindow.snippet,
                ),
              ),
          }
        ),
        bottomNavigationBar: const BottomBar(),
      );
  }
}