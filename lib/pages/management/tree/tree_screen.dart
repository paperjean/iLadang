import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sawitcare_app/pages/management/tree/tree_list.dart';
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
  bool isLoading = true;
  Set<Polygon> existingPolygons = {
    // Placeholder for fake polygon. Remove this when fetching polygons current polygons exists.
    Polygon(
      polygonId: PolygonId('tree'),
      points: const [
        LatLng(5.099330401023339, 118.43106763435685),
        LatLng(5.099330401023339, 118.43106763435685),
        LatLng(5.099330401023339, 118.43106763435685),
      ],
      strokeWidth: 2,
      strokeColor: Colors.green,
      fillColor: Colors.green.withOpacity(0.5),
    ),
  };

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchTreeMapping();
    _fetchBlockList();
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
              IconButton(
                onPressed: () {
                  _fetchTreeMapping();
                  _fetchBlockList();
                },
                icon: const Icon(Icons.refresh_rounded),
              ),
              Visibility(
                visible: isLoading == false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/treelist');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TreeList(
                                    treeList: _treeMapping,
                                  )));
                    },
                    icon: const Icon(Icons.list_alt_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          GoogleMap(
            polygons: existingPolygons,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.satellite,
            onMapCreated: ((GoogleMapController controller) =>
                _mapController.complete(controller)),
            initialCameraPosition: CameraPosition(target: _pTree, zoom: 19),
            markers: _markers.values.toSet(),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ]),
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
          size: Size(5, 5),
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
    }
  }

  Future<void> _fetchTreeMapping() async {
    try {
      final data = await fetchTreeList(); // Call the service function
      if (mounted) {
        setState(() {
          _treeMapping = data ?? []; // Assign fetched data to _treeList
        });
      }
      isLoading = false;
      print(_treeMapping);
      _generateMarkers();
    } catch (e) {
      print(e);
    }
  }

  // Fetch Block List
  Future<void> _fetchBlockList() async {
    existingPolygons = {
      // Placeholder for fake polygon. Remove this when fetching polygons current polygons exists.
      Polygon(
        polygonId: PolygonId('tree'),
        points: const [
          LatLng(5.099330401023339, 118.43106763435685),
          LatLng(5.099330401023339, 118.43106763435685),
          LatLng(5.099330401023339, 118.43106763435685),
        ],
        strokeWidth: 2,
        strokeColor: Colors.green,
        fillColor: Colors.green.withOpacity(0.5),
      ),
    };
    final result = await fetchBlockCoordinates();
    if (result.isEmpty) {
      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No Blocks Available'),
          backgroundColor: Colors.red[400],
        ),
      );
    } else {
      // Process block data
      setState(() {
        for (var block in result) {
          final List<LatLng> cornerCoordinates = block['corner_coordinates'];
          // Create Polygon with appropriate colors (considering parsing results)
          existingPolygons.add(Polygon(
            polygonId: PolygonId(block['block_id']),
            points: cornerCoordinates,
            strokeWidth: 2,
            strokeColor: Color(block['color']),
            fillColor:
                Color(block['color']).withOpacity(0.5), // Default or fallback
          ));
        }
      });
    }
    print(result);
  }
}
