import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sawitcare_app/services/tree.dart';

class Tree extends StatefulWidget {
  const Tree({super.key});

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  Location _locationController = new Location();
  static const LatLng _pTree = LatLng(5.098148982414278, 118.43477932281274);
  LatLng? _currentP;
  final Map<String, Marker> _markers = {};
  List<Map<String, dynamic>> _treeMapping = [];

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchTreeMapping();

    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: AppBar(
            centerTitle: true,
            elevation: 0,
            title: const Text(
              "Tree",
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/treelist');
                  },
                  icon: const Icon(Icons.list_alt_rounded),
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

    if (currentLocation.latitude != null &&
        currentLocation.longitude != null &&
        mounted) {
      setState(() {
        _currentP =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _cameraToPosition(_currentP!);
      });
    }
  }

  _generateMarkers() async {
    for (int i = 0; i < _treeMapping.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(10, 10),
        ),
        'assets/tree_marker_green.png',
      );
      _markers[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position:
              LatLng(_treeMapping[i]['latitude'], _treeMapping[i]['longitude']),
          icon: markerIcon,
          infoWindow: InfoWindow(
              title:
                  'Tree ${_treeMapping[i]['block']}${_treeMapping[i]['tree_number']}'));
      setState(() {});
    }
  }

  Future<void> _fetchTreeMapping() async {
    try {
      final data = await fetchTreeMapping(); // Call the service function
      if (mounted) {
        setState(() {
          _treeMapping = data ?? []; // Assign fetched data to _treeList
        });
      }
      print(_treeMapping);
      _generateMarkers();
    } catch (e) {
      print(e);
    }
  }
}
