import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/services/user_validation.dart';

class TreeAddPage extends StatefulWidget {
  const TreeAddPage({super.key});

  @override
  State<TreeAddPage> createState() => _TreeAddPageState();
}

class _TreeAddPageState extends State<TreeAddPage> {
  DateTime date = DateTime.now();
  // Controller
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _treeNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _registerTreeLoading = false;

  // Location Picker Variables
  LatLng? destLocation = LatLng(5.098148982414278, 118.43477932281274);
  Location location = Location();
  final Completer<GoogleMapController> _controller = Completer();

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Place Tree Location'),
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
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 35.0),
                child: Image.asset(
                  'assets/tree_marker_grey.png',
                  height: 45,
                  width: 45,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show dialog
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Details'),
                    content: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Block',
                                  errorStyle: TextStyle(
                                    color: Colors
                                        .red, // Set the color of the error text
                                    fontSize:
                                        14.0, // Set the font size of the error text
                                  ),
                                ),
                                controller: _blockController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tree Number',
                                  errorStyle: TextStyle(
                                    color: Colors
                                        .red, // Set the color of the error text
                                    fontSize:
                                        14.0, // Set the font size of the error text
                                  ),
                                ),
                                controller: _treeNumberController,
                              ),
                            ),
                            _DatePickerItem(
                              children: [
                                Text('Date'),
                                CupertinoButton(
                                  // Display a CupertinoDatePicker in date picker mode.
                                  onPressed: () => _showDialog(
                                    CupertinoDatePicker(
                                      initialDateTime: date,
                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: true,
                                      // This shows day of week alongside day of month
                                      showDayOfWeek: true,
                                      // This is called when the user changes the date.
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() => date = newDate);
                                      },
                                    ),
                                  ),
                                  // In this example, the date is formatted manually. You can
                                  // use the intl package to format the value based on the
                                  // user's locale settings.
                                  child: Text(
                                    '${date.month}-${date.day}-${date.year}',
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final isValid = _formKey.currentState?.validate();
                          if (isValid != true) {
                            return;
                          }
                          setState(() {
                            _registerTreeLoading = true;
                          });
                          try {
                            // Register Tree
                            await supabase.from('tree').insert({
                              'block': _blockController.text,
                              'tree_number': _treeNumberController.text,
                              'date_planted': date.toString(),
                              'latitude': destLocation!.latitude.toString(),
                              'longitude': destLocation!.longitude.toString(),
                              'plantation_id': await getUserPlantationId(
                                  supabase.auth.currentUser!.id),
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Tree Registered'),
                                backgroundColor: Colors.green[400],
                              ),
                            );
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Error Registering Tree'),
                                backgroundColor: Colors.red[400],
                              ),
                            );
                          }
                        },
                        child: Text('Register Tree',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ));
        },
        label: const Text('Confirm Location',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
