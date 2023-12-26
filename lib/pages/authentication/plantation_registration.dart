import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';
import 'package:sawitcare_app/pages/management/homepage_management.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlantationRegistration extends StatefulWidget {
  const PlantationRegistration({super.key});

  @override
  State<PlantationRegistration> createState() => _PlantationRegistrationState();
}

class _PlantationRegistrationState extends State<PlantationRegistration> {
  final _numberOfTrees = TextEditingController();
  final _location = TextEditingController();
  final _landSize = TextEditingController();
  final _plantationName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _signUpLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/rolebackground.jpg',
                ),
              ),
            ),
          ),
          Container(
            height: 500.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black87.withOpacity(0.8)
                ],
                    stops: const [
                  0.0,
                  1.0
                ])),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(247, 247, 247, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            margin: const EdgeInsets.only(top: 300.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Create Your Plantation',
                    style: TextStyle(
                        color: Colors.black, // Set the desired text color
                        fontSize: 25.0, // Set the desired font size
                        decoration: TextDecoration.none, // Remove underline
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text(
                      'Let us know more about your plantation.\n Don’t worry, your data is safe with us ! ',
                      style: TextStyle(
                          color: Colors.black, // Set the desired text color
                          fontSize: 14.0, // Set the desired font size
                          decoration: TextDecoration.none, // Remove underline
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Textfield
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: _plantationName,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Plantation Name', // Updated label text
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.red, // Set the color of the error text
                          fontSize: 14.0, // Set the font size of the error text
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      controller: _location,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Location | Optional',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.location_on_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow((RegExp("[.0-9]"))),
                      ],
                      controller: _landSize,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Land Size | Optional',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: _numberOfTrees,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Number of Trees | Optional',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState?.validate();
                      if (isValid != true) {
                        return;
                      }
                      setState(() {
                        _signUpLoading = true;
                      });
                      try {
                        await supabase.from('plantation').insert({
                          // 'master_manager_id': supabase.auth.currentUser!.id,
                          'company_name': _plantationName.text,
                          'location': _location.text,
                          'land_size':
                              _landSize.text.isNotEmpty ? _landSize.text : null,
                          'no_of_trees': _numberOfTrees.text.isNotEmpty
                              ? _numberOfTrees.text
                              : null,
                        });

                        final plantationId = await supabase
                            .from('plantation')
                            .select('plantation_id')
                            .eq('master_manager_id',
                                supabase.auth.currentUser!.id)
                            .single();
                        print(plantationId);
                        final id = plantationId.entries.first.value;
                        print(id);
                        await supabase.from('user_profile').update({
                          'role': 'owner',
                          'plantation_id': id.toString()
                        }).eq('id', supabase.auth.currentUser!.id.toString());

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Your plantation have succesfully been created'),
                            backgroundColor: Colors.green[400],
                          ),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()),
                        );
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Plantation creation failed'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                      setState(() {
                        _signUpLoading = false;
                      });
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
                      'Create',
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
          Positioned(
            top: 50.0,
            right: 30.0,
            child: FloatingActionButton(
              onPressed: () {
                _signOut();
              },
              child: Icon(Icons.logout_rounded, color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
                    Positioned(
            top: 50.0,
            left: 30.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/role');
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StartPage()));
      }
    }
  }
}
