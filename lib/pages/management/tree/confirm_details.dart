import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/services/user_validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TreeConfirmDetailsPage extends StatefulWidget {
  final LatLng treeLocation;

  // Required Parameters
  const TreeConfirmDetailsPage({required this.treeLocation, Key? key})
      : super(key: key);

  @override
  State<TreeConfirmDetailsPage> createState() => _TreeConfirmDetailsPageState();
}

class _TreeConfirmDetailsPageState extends State<TreeConfirmDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _treeNumberController = TextEditingController();
  bool _registerTreeLoading = false;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirm Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
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
                            color:
                                Colors.red, // Set the color of the error text
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
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                            color:
                                Colors.red, // Set the color of the error text
                            fontSize:
                                14.0, // Set the font size of the error text
                          ),
                        ),
                        controller: _treeNumberController,
                      ),
                    ),
                    _DatePickerItem(
                      children: [
                        Text('Date Planted', style: TextStyle(fontSize: 16)),
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(228, 234, 240, 0.88),
                                border: Border.all(
                                  color: Color.fromARGB(255, 212, 206, 206),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                '${date.month}-${date.day}-${date.year}',
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                    'latitude': widget.treeLocation.latitude.toString(),
                    'longitude': widget.treeLocation!.longitude.toString(),
                    'plantation_id': await getUserPlantationId(
                        supabase.auth.currentUser!.id),
                  });
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, '/treelist');
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
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF2B805A),
                  width: 0.5,
                ), // Set border color
                backgroundColor: const Color.fromRGBO(230, 252, 242, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: const Size(300, 50),
              ),
              child: const Text(
                'Register Tree',
                style: TextStyle(
                    color: Color.fromRGBO(43, 128, 90, 1),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(),
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
