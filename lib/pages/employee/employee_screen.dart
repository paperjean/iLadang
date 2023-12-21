import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final _requestStream =
      supabase.from('request').stream(primaryKey: ['request_id']);

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 47, 47),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 47, 47, 47),
            elevation: 0,
            centerTitle: false,
            title: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _requestStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final request = snapshot.data!;

          final List<String> requesterIds =
              request.map((map) => map['requester_id'].toString()).toList();

          return ListView.builder(
              itemCount: request.length,
              itemBuilder: (contex, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(request[index]['request_id']),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const ManagerRegistration()),
                                  // );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(43, 128, 90, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: const Size(150, 30),
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const ManagerRegistration()),
                                  // );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(229, 230, 235, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: const Size(150, 30),
                                ),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(45, 45, 45, 1),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Future<void> _fetchRequests() async {
    // Fetch the list of requests from Supabase
    try {
      final data = await supabase
          .from('request')
          .select()
          .eq(
            'target_id',
            supabase.auth.currentUser!.id,
          )
          .eq(
            'request_status',
            'pending',
          )
          .eq(
            'request_type',
            'request',
          )
          .then((value) async {
        for (var user in value) {
          final postData = await supabase
              .from('user_profile')
              .select(
                'first_name',
              )
              .eq(
                'id',
                user['requester_id'],
              );
          print(postData);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
