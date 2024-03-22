import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sawitcare_app/services/tree.dart';

class BlockConfirmDetailPage extends StatefulWidget {
  final List<LatLng> cornerList;
  final Color color;

  // Required Parameters
  const BlockConfirmDetailPage(
      {required this.cornerList, required this.color, Key? key})
      : super(key: key);

  @override
  State<BlockConfirmDetailPage> createState() => _BlockConfirmDetailPageState();
}

class _BlockConfirmDetailPageState extends State<BlockConfirmDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _blockController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirm Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
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
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
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
                  setState(() {});
                  // Register Tree
                  final result = await postBlockData(
                    _blockController.text,
                    widget.color.value,
                    widget.cornerList,
                    null,
                  );
                  if (result != true) {
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Block Registered'),
                        backgroundColor: Colors.green[400],
                      ),
                    );
                  }
                  // Redirect to TreeAddPage with Latest Tree List
                  Navigator.pop(context, true);
                  // Navigator.pushNamed(context, '/treelist');
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
                  'Register Block',
                  style: TextStyle(
                      color: Color.fromRGBO(43, 128, 90, 1),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
