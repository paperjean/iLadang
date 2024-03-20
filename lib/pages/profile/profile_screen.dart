import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/profile/profile_picture.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sawitcare_app/pages/authentication/start_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true; // Initialize as true to show loading initially
  List? profileData;
  Map? plantationName;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBar(
          elevation: 0,
          title: const Text(
            "Profile",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  // Dialog to Confirm Logout
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          surfaceTintColor: Colors.white,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: const Text(
                            'Confirm Log Out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to log out?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(229, 230, 235, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(201, 53, 59, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _signOut();
                                print("Logging Out");
                              },
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // Make Profile Page
            const CircleAvatarWithTransition(
                primaryColor: const Color.fromRGBO(43, 128, 90, 1),
                image: NetworkImage(
                    "https://media.licdn.com/dms/image/D5603AQELVu0W8Q-uSw/profile-displayphoto-shrink_800_800/0/1671263039389?e=2147483647&v=beta&t=j3QWSAMeCIPhnQ07A-x58PPSHHlAKqvEZ0wn5kRzNx8")),
            //Name
            ListTileTheme(
                child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  profileData != null && profileData!.isNotEmpty
                      ? '${profileData![0]['first_name']} ${profileData![0]['last_name']}'
                      : '', // Accessing first_name from profileData and converting to String
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    profileData != null && profileData!.isNotEmpty
                        ? '${plantationName!['company_name']} | ${profileData![0]['role'].replaceFirst(profileData![0]['role'][0], profileData![0]['role'][0].toUpperCase())}'
                        : '', // Accessing first_name from profileData and converting to String
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
            //Phone

            ListTileTheme(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                  profileData != null && profileData!.isNotEmpty
                      ? '${profileData![0]['phone']}'
                      : '', // Accessing first_name from profileData and converting to String
                ),
              ),
            ),
            ListTileTheme(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  profileData != null && profileData!.isNotEmpty
                      ? '${profileData![0]['email']}'
                      : '', // Accessing first_name from profileData and converting to String
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      isLoading = true; // Set loading to true before fetching
    });
    // Fetch the list of requests from Supabase
    try {
      profileData = await supabase
          .from('user_profile')
          .select(
            'first_name, last_name, role, plantation_id, email, phone',
          )
          .eq(
            'id',
            supabase.auth.currentUser!.id,
          );

      plantationName = await supabase
          .from('plantation')
          .select('company_name')
          .eq('plantation_id', profileData![0]['plantation_id'])
          .single();

      setState(() {
        isLoading = false; // Set loading to false after fetching
      });
      print(profileData);
      print(plantationName);
    } catch (e) {
      print(e);
    }
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
