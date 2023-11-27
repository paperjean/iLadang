import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';
import 'package:sawitcare_app/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeRegistration extends StatefulWidget {
  const EmployeeRegistration({super.key});

  @override
  State<EmployeeRegistration> createState() => _EmployeeRegistrationState();
}

class _EmployeeRegistrationState extends State<EmployeeRegistration> {
  final _plantationKey = TextEditingController();
  bool _signUpLoading = false;
  final _formKey = GlobalKey<FormState>();

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
            margin: const EdgeInsets.only(top: 500.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Join existing plantation',
                    style: TextStyle(
                        color: Colors.black, // Set the desired text colorDWA
                        fontSize: 25.0, // Set the desired font size
                        decoration: TextDecoration.none, // Remove underline
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text(
                      'Insert plantation ID to request to join. Ask your plantation owner for that.',
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
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: _plantationKey,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Plantation Key', // Updated label text
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.red, // Set the color of the error text
                          fontSize: 14.0, // Set the font size of the error text
                        ),
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
                        final response = await supabase
                            .from('plantation')
                            .select()
                            .eq('join_key', _plantationKey.text)
                            .maybeSingle();

                        await supabase.from('request').insert({
                          'requester_id':
                              supabase.auth.currentUser!.id.toString(),
                          'target_id': response['master_manager_id'].toString(),
                          'plantation_id': response['plantation_id'].toString(),
                          'request_type': 'request',
                        });

                        await supabase.from('user_profile').update({
                          'role': 'pending_employee',
                        }).eq('id', supabase.auth.currentUser!.id.toString());

                        Navigator.of(context).pushReplacementNamed('/pending');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Your request have succesfully been sent'),
                            backgroundColor: Colors.green[400],
                          ),
                        );
                      } catch (e) {
                        print(e);
                        SnackBar(
                          content: Text('Request failed'),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        );
                      }
                      // Find selected plantation
                      // try plantation found
                      // if catch (e) : plantation not found
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
                      'Request to join',
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
