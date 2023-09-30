import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Importing the geolocator package:
import 'package:geolocator/geolocator.dart';

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
  // Boolean values for design purposes:
  bool isLocationEnabled = false;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(1.296568, 103.852119);

  // Setting the controller:
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  // Method to retrieve the user's current location:
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      isLocationEnabled = !isLocationEnabled;
      isLocationEnabled ? mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17.0,
          ),
        ),
      ) : mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
        ),
      );
    });
  }

  // We need a method to deal with permissions:
  Future<Position> _determinePosition() async {

    // First we check the permissions:
    LocationPermission permission = await Geolocator.checkPermission();

    // If the permissions are denied, we ask for them:
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // If they still refuse we return an error:
      if(permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied by the user');
      }
    }
    // Now we return:
    return await Geolocator.getCurrentPosition();
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
    Marker(
      markerId: const MarkerId('bin2'),
      position: const LatLng(1.298193, 103.848488),
      infoWindow: const InfoWindow(
        title: 'Bin 2 - Electronics',
        snippet: 'Please deposit electronic waste here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ),
    // Bin 3:
    Marker(
      markerId: const MarkerId('bin3'),
      position: const LatLng(1.294968, 103.850231),
      infoWindow: const InfoWindow(
        title: 'Bin 3 - Plastic/Electronics',
        snippet: 'Please deposit plastic or electronic waste here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ),
    // Bin 4:
    Marker(
      markerId: const MarkerId('bin4'),
      position: const LatLng(1.294469, 103.848641),
      infoWindow: const InfoWindow(
        title: 'Bin 4 - Miscellaneous',
        snippet: 'Please deposit recyclable waste here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ),
    // Bin 5:
    Marker(
      markerId: const MarkerId('bin5'),
      position: const LatLng(1.296644, 103.850376),
      infoWindow: const InfoWindow(
        title: 'Bin 5 - Miscellaneous',
        snippet: 'Please deposit recyclable waste here',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin Locator'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
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
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          ),
      // We need a floating action button to retrieve the user's location:
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Get Location',
        child: isLocationEnabled ? const Icon(Icons.location_on) : const Icon(Icons.location_off),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
