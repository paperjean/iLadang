import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/management/tree/confirm_details.dart';
import 'package:sawitcare_app/services/tree.dart';
import 'package:sawitcare_app/services/user_validation.dart';

class TreeAddPage extends StatefulWidget {
  final List? treeList;

  const TreeAddPage({
    Key? key,
    required this.treeList,
  }) : super(key: key);

  @override
  State<TreeAddPage> createState() => _TreeAddPageState();
}

class _TreeAddPageState extends State<TreeAddPage> {
  // Controller

  // Location Picker Variables
  LatLng? destLocation = LatLng(5.098148982414278, 118.43477932281274);
  Location location = Location();
  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _generateMarkers(widget.treeList!);
  }

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Place Tree Location'),
        actions: [
          IconButton(
            onPressed: () async {
              // Refresh Map
              final List? latestTreeList = await fetchTreeList();

              // generate new marker
              _generateMarkers(latestTreeList!);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
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
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TreeConfirmDetailsPage(
                treeLocation: destLocation!,
                treeList: widget.treeList,
              ),
            ),
          );
          if (result == true) {
            final List? latestTreeList = await fetchTreeList();
            _generateMarkers(latestTreeList!);
          }
        },
        label: const Text(
          'Confirm Location',
          style: TextStyle(fontSize: 20, color: Color.fromRGBO(43, 128, 90, 1)),
        ),
        icon: const Icon(
          Icons.check,
          color: Color.fromRGBO(
            43,
            128,
            90,
            1,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _generateMarkers(List treeList) async {
    if (treeList.isEmpty) {
      return;
    } else {
      for (int i = 0; i < treeList.length; i++) {
        BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
            size: Size(10, 10),
          ),
          'assets/tree_marker_green.png',
        );
        _markers[i.toString()] = Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(treeList[i]['latitude'], treeList[i]['longitude']),
            icon: markerIcon,
            infoWindow: InfoWindow(
                title:
                    'Tree ${treeList[i]['block']}${treeList[i]['tree_number']}'));
        setState(() {});
      }
    }
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
    controller?.animateCamera(
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
}
