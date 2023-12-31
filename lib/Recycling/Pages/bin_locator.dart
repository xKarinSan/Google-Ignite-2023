import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleignite2023/General/app_bar.dart';
import '../../FirebaseFeatures/recycle_model.dart';
import 'package:localstorage/localstorage.dart';
import '../../General/bottom_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:fluttertoast/fluttertoast.dart";
// Importing the geolocator package:
import 'package:geolocator/geolocator.dart';
// Importing the polylines package:
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class BinLocator extends StatefulWidget {
  const BinLocator({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BinLocatorState createState() => _BinLocatorState();
}

class _BinLocatorState extends State<BinLocator> {
  // for the bottom bar
  final LocalStorage bottom_bar = LocalStorage('bottom_bar_state');
  final LocalStorage currentUser = LocalStorage('current_user');
  String userId = "";

  // Boolean values for design purposes:
  bool isLocationEnabled = false;
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(1.296568, 103.852119);

  // Setting the controller:
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // A variable to store the user's location whenever we get it:
  Position? _currentPosition;

  // We need a variable to store the polylines:
  final Map<PolylineId, Polyline> _polylines = {};

  // Method to retrieve the user's current location:
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _currentPosition = position;
      isLocationEnabled = !isLocationEnabled;
      isLocationEnabled
          ? mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 17.0,
                ),
              ),
            )
          : mapController.animateCamera(
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
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied by the user');
      }
    }
    // Now we return:
    return await Geolocator.getCurrentPosition();
  }

  // We need markers for the bins:
  final Set<Marker> _markers = {
    // Bin 1:
    // We need to add a button to the info window to get directions to the bin:
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
  void initState() {
    userId = currentUser.getItem("userId");
    // print("userId $userId");
    super.initState();
    _getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottom_bar.setItem("index", 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(
          title: "Bin Locator", automaticallyImplyLeading: false),

      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 17.0,
        ),
        onMapCreated: _onMapCreated,
        markers: // Everytime a marker is tapped, we need to draw the polyline:
            Set<Marker>.of(
          _markers.map(
            (Marker marker) {
              return Marker(
                markerId: marker.markerId,
                position: marker.position,
                infoWindow: marker.infoWindow,
                icon: marker.icon,
                onTap: () async {
                  // We need to get the directions:
                  List<LatLng> polylineCoordinates =
                      await _getDirections(marker.position);
                  // Now we draw the polyline:
                  _drawPolyline(polylineCoordinates);
                  // Now we check if the bin is within the blue circle:
                  if (_isWithinCircle(marker.position)) {
                    // If it is, we make a dialog box pop up:
                    // ignore: use_build_context_synchronously
                    _dialog(context);
                  }
                },
              );
            },
          ),
        ),
        // We need to draw the polyline:
        polylines: Set<Polyline>.of(_polylines.values),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        // Adding a radius around the user's location only if we have it:
        circles: _currentPosition != null
            ? <Circle>{
                Circle(
                  circleId: const CircleId('user'),
                  center: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  radius: 25,
                  fillColor: Colors.blueAccent.withOpacity(0.4),
                  // No border:
                  strokeColor: Colors.transparent,
                ),
              }
            : <Circle>{},
      ),
      // We need a floating action button to retrieve the user's location: also need to it's opacity lower if the user's location is not enabled:
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Get Location',
        backgroundColor: Colors.white,
        child: Icon(
          Icons.location_on,
          color: isLocationEnabled ? Colors.green : Colors.grey,
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Future<dynamic> _dialog(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    Future<bool?> recycleItem() async {
      print("itemName: ${itemNameController.text}");
      print("quantity: ${quantityController.text}");
      if (quantityController.text == "" || itemNameController.text == "") {
        // print("points: $points");
        return Fluttertoast.showToast(
            msg: "Fields cannot be empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        int qty = int.parse(quantityController.text.split(' ')[0]);
        if (qty <= 0) {
          return Fluttertoast.showToast(
              msg: "Quantity cannot be less than 0",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        await RecycleMethods().createRecycle(userId: userId);
        Navigator.pop(context);
        return Fluttertoast.showToast(
            msg: "Recycled!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color.fromARGB(255, 3, 136, 8),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
                controller: itemNameController,
                onChanged: (value) {
                  // print("Item Name: $value");
                  // Do something with the user's input
                },
              ),
              const SizedBox(height: 16), // Add some spacing
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
// for version 2 and greater youcan also use this
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: quantityController,
                onChanged: (value) {
                  // Do something with the user's input
                },
              ),
              const SizedBox(height: 16), // Add some spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Do something when the green button is pressed

                      recycleItem();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                    ),
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Do something when the red button is pressed
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // Text color
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Now that we have the directions API and polyline package, we need to provide the routes to the bins when the user clicks on the info window:
  // We need a method to get the directions:
  Future<List<LatLng>> _getDirections(LatLng destination) async {
    // Instantiation:
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    // First we get the user's location again:
    Position position = await _determinePosition();

    // Now we get the directions from the user's location to the destination:
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      const String.fromEnvironment('MAPS_API_KEY'), // Google Maps API Key
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
    );

    // Now we need to parse the result:
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      // ignore: avoid_print
      print(result.errorMessage);
    }
    // Now we return the coordinates:
    return polylineCoordinates;
  }

  // Now that we have the directions, we need to draw the polyline:
  void _drawPolyline(List<LatLng> polylineCoordinates) async {
    // We make the polygon visible:
    PolylineId id = const PolylineId('direction');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 7,
    );
    // Now we set state:
    setState(() {
      // We add the polyline to the map:
      _polylines[id] = polyline;
    });
  }

  // If bin is within the blue circle, then we need to navigate to another page to scan image:
  // If bin is not within the blue circle, then we only need to draw the polyline:
  // We need a method to check if the bin is within the blue circle:
  bool _isWithinCircle(LatLng bin) {
    if (_currentPosition == null) {
      return false;
    }
    // Get user's location again:
    Position position = _currentPosition!;
    // Get the distance between the user's location and the bin:
    double distanceBetween = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      bin.latitude,
      bin.longitude,
    );
    // If the distance is less than 50m, then the bin is within the circle:
    if (distanceBetween < 50) {
      return true;
    } else {
      return false;
    }
  }
}
