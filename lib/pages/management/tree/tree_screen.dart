import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class Tree extends StatefulWidget {
  const Tree({super.key});

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  Location _locationController = new Location();
  static const LatLng _pTree = LatLng(5.098148982414278, 118.43477932281274);
  static const LatLng _pApplePark = LatLng(37.334606, -122.009102);
  LatLng? _currentP = null;
  final Map<String, Marker> _markers = {};

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    // TODO: implement initState
    _generateMarkers();
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: AppBar(
            elevation: 0,
            title: const Text(
              "Tree",
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_rounded),
                ),
              ),
            ],
          ),
        ),
        body: GoogleMap(
          mapType: _currentMapType,
          onMapCreated: ((GoogleMapController controller) =>
              _mapController.complete(controller)),
          initialCameraPosition: CameraPosition(target: _pTree, zoom: 19),
          markers: _markers.values.toSet(),
        ),
        floatingActionButton: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.gps_fixed),
                onPressed: () {
                  getLocationUpdates();
                },
                heroTag: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.layers),
                onPressed: () => {
                  setState(() {
                    _currentMapType = (_currentMapType == MapType.normal)
                        ? MapType.satellite
                        : MapType.normal;
                  })
                },
                heroTag: null,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat);
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 19,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController
          .requestPermission(); // Problem Source : https://stackoverflow.com/questions/53885189/granting-location-permission-with-flutter-at-ios
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final LocationData currentLocation =
        await _locationController.getLocation();

    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      setState(() {
        _currentP =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _cameraToPosition(_currentP!);
      });
    }
  }

  _generateMarkers() async {
    for (int i = 0; i < data.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(10, 10),
        ),
        data[i]['assetPath'],
      );
      _markers[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position: data[i]['position'],
          icon: markerIcon,
          infoWindow: InfoWindow(title: 'This is a tree'));
      setState(() {});
    }
  }
}

List<Map<String, dynamic>> data = [
  {
    'id': '1',
    'position': LatLng(5.098148982414278, 118.43477932281274),
    'assetPath': 'assets/tree_marker_green.png'
  },
  {
    'id': '2',
    'position': LatLng(5.098148982414278, 118.43487932281274),
    'assetPath': 'assets/tree_marker_grey.png'
  },
  {
    'id': '3',
    'position': LatLng(5.098148982414278, 118.43497932281274),
    'assetPath': 'assets/tree_marker_yellow.png'
  },
];
