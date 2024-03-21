import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:sawitcare_app/pages/management/tree/confirm_block_details.dart';
import 'package:sawitcare_app/pages/management/tree/confirm_details.dart';
import 'package:sawitcare_app/services/tree.dart';

class TreeSegmenter extends StatefulWidget {
  final List? treeList;

  const TreeSegmenter({
    Key? key,
    required this.treeList,
  }) : super(key: key);

  @override
  State<TreeSegmenter> createState() => _TreeSegmenterState();
}

class _TreeSegmenterState extends State<TreeSegmenter> {
  LatLng? destLocation = LatLng(5.098148982414278, 118.43477932281274);
  Location location = Location();
  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  // Hold Existing Polygons
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
  List<LatLng> cornerList = [];

  @override
  void initState() {
    super.initState();
    _fetchBlockList();
    _generateMarkers(widget.treeList!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pick Block Corners'),
        actions: [
          IconButton(
            onPressed: () async {
              // Refresh Map
              final List? latestTreeList = await fetchTreeList();

              // generate new marker
              _generateMarkers(latestTreeList!);
              // Refresh Map
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            // Choose Location Button
            GoogleMap(
              polygons: existingPolygons,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: destLocation!,
                zoom: 20,
              ),
              onCameraMove: (CameraPosition? position) {
                if (destLocation != position!.target) {
                  setState(() {
                    destLocation = position.target;
                  });
                }
              },
              onCameraIdle: () {
                print('Camera Idle');
                // Show the latitude and longitude
                print(destLocation);
              },
              onTap: (latLng) {
                print(latLng);
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers.values.toSet(),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 35.0),
                child: Image.asset(
                  'assets/tree_pointer.png',
                  height: 45,
                  width: 45,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Reset CornerList
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: () {
                  _resetTreeSegmenter();
                  print(existingPolygons);
                  // Remove
                },
                backgroundColor: Colors.white,
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Color.fromRGBO(
                      43,
                      128,
                      90,
                      1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'location',
                onPressed: () async {
                  _dropMarker();
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color.fromRGBO(
                    43,
                    128,
                    90,
                    1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'confirm',
                onPressed: () async {
                  _confirmBlockDetails();
                },
                child: const Icon(
                  Icons.check,
                  color: Color.fromRGBO(
                    43,
                    128,
                    90,
                    1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _resetTreeSegmenter() async {
    setState(() {
      cornerList = [];

      // Clear markers bnased on the length of the markers
      _markers.removeWhere((key, value) => key != '0');
      // Remove the polygon you just created
      existingPolygons
          .removeWhere((polygon) => polygon.polygonId.value == 'block');
    });
  }

  _dropMarker() async {
    // Check if location is available
    if (destLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You must have a location first'),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }
    // Update the append corner list
    setState(() {
      cornerList.add(destLocation!);
      // Add Marker with New
      _markers.addAll({
        cornerList.length.toString(): Marker(
          markerId: MarkerId(cornerList.length.toString()),
          position: destLocation!,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Corner ${cornerList.length}',
          ),
        ),
      });

      if (cornerList.length > 3) {
        existingPolygons.add(Polygon(
          polygonId: PolygonId('block'),
          points: cornerList,
          strokeWidth: 2,
          strokeColor: Colors.green,
          fillColor: Colors.green.withOpacity(0.5),
        ));
      }
    });
  }

  Future<void> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController controller = await _controller.future;

    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    } else {
      return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location
          .requestPermission(); // Problem Source : https://stackoverflow.com/questions/53885189/granting-location-permission-with-flutter-at-ios
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final LocationData currentLocation = await location.getLocation();

    // Camera Positioning
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 19,
        ),
      ),
    );
    setState(() {
      destLocation =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  _generateMarkers(List treeList) async {
    if (treeList.isEmpty) {
      return;
    } else {
      if (mounted) {
        setState(() async {
          for (int i = 0; i < treeList.length; i++) {
            BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(
                size: Size(10, 10),
              ),
              'assets/tree_marker_green.png',
            );
            _markers[i.toString()] = Marker(
                markerId: MarkerId(i.toString()),
                position:
                    LatLng(treeList[i]['latitude'], treeList[i]['longitude']),
                icon: markerIcon,
                infoWindow: InfoWindow(
                    title:
                        'Tree ${treeList[i]['block']}${treeList[i]['tree_number']}'));
          }
        });
      }
    }
  }

  _confirmBlockDetails() async {
// Check if corners is atleast 4 to proceed, if not show snackbar
    if (cornerList.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You must atleast have 4 corners'),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }
    // Confirm location
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlockConfirmDetailPage(
          cornerList: cornerList,
        ),
      ),
    );
    if (result != true) {
      throw 'Error Confirming Block';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Block Confirmed'),
          backgroundColor: Colors.green[400],
        ),
      );
      // Reset the corner list
      _resetTreeSegmenter();
      _fetchBlockList();
    }
  }

  // Fetch Block List
  Future<void> _fetchBlockList() async {
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
      // For each block, append a polygon to the existingPolygons
      print(result);
      setState(() {
        for (var block in result) {
          final List<LatLng> cornerCoordinates = block['corner_coordinates'];
          existingPolygons.add(Polygon(
            polygonId: PolygonId(block['block_id']),
            points: cornerCoordinates,
            strokeWidth: 2,
            strokeColor: Colors.green,
            fillColor: Colors.green.withOpacity(0.5),
          ));
        }
      });
    }
    print(result);
  }
}
