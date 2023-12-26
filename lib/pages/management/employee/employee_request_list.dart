import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/services/user_validation.dart';

class EmployeeRequest extends StatefulWidget {
  const EmployeeRequest({super.key});

  @override
  State<EmployeeRequest> createState() => _EmployeeRequestState();
}

class _EmployeeRequestState extends State<EmployeeRequest> {
  List? _requestList;

  bool _isLoading = true; // Initialize as true to show loading initially

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
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text(
                'Requests',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [],
            )),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _requestList?.length ?? 0,
                itemBuilder: (contex, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              '${_requestList?[index]?['first_name'] ?? 'Unknown'} ${_requestList?[index]?['last_name'] ?? 'Unknown'}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _requestList?[index]?['role'] == 'pending_manager'
                                  ? 'Manager'
                                  : _requestList?[index]?['role'] ==
                                          'pending_employee'
                                      ? 'Employee'
                                      : _requestList?[index]?['role'] ??
                                          'Unknown',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    // Show Dialog
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            surfaceTintColor: Colors.white,
                                            title: const Text(
                                              'Confirm Request',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to confirm this request?',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  print(_requestList![1]);

                                                  Navigator.of(context).pop();
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          229, 230, 235, 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          43, 128, 90, 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {
                                                  _confirmRequest(
                                                    _requestList![index]
                                                        ['request_id'],
                                                    _requestList![index]
                                                        ['plantation_id'],
                                                    _requestList![index]
                                                        ['requester_id'],
                                                    _requestList![index]
                                                        ['role'],
                                                  );
                                                  Navigator.of(context).pop();
                                                  print("Hello3");
                                                  // print(_requestList![index]
                                                  //     ['plantation_id']);
                                                },
                                                child: const Text(
                                                  'Confirm',
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
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(43, 128, 90, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              'Delete Request',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to delete this request?',
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
                                                      const Color.fromRGBO(
                                                          229, 230, 235, 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          201, 53, 59, 1),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {
                                                  _deleteRequest(
                                                    _requestList?[index]
                                                        ?['request_id'],
                                                    _requestList?[index]
                                                        ?['requester_id'],
                                                    _requestList?[index]
                                                        ?['role'],
                                                  );
                                                  Navigator.of(context).pop();
                                                  // initState();
                                                  print("Delete Complete");
                                                },
                                                child: const Text(
                                                  'Delete',
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
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(229, 230, 235, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fixedSize: const Size(150, 30),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color:
                                          const Color.fromRGBO(45, 45, 45, 1),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }));
  }

  Future<void> _fetchRequests() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching
    });
    // Fetch the list of requests from Supabase
    try {
      final data = await supabase
          .from('request')
          .select(
              'request_id, requester_id, request_status, request_type, plantation_id')
          .eq(
            'plantation_id',
            await getUserPlantationId(supabase.auth.currentUser!.id),
          )
          .eq(
            'request_status',
            'pending',
          )
          .eq(
            'request_type',
            'request',
          );

      for (var request in data) {
        final postData = await supabase
            .from('user_profile')
            .select(
              'first_name, last_name, role',
            )
            .eq(
              'id',
              request['requester_id'],
            );

        // Access the first_name from the fetched postData
        if (postData.isNotEmpty) {
          final firstName = postData.first['first_name'];
          final lastName = postData.first['last_name'];
          final role = postData.first['role'];

          // Append the first name to the request object
          request['first_name'] = firstName;
          request['last_name'] = lastName;
          request['role'] = role;
        } else {
          // Handle cases where first_name is not found
          request['first_name'] = 'Unknown'; // Or handle it differently
          request['last_name'] = 'Unknown';
          request['role'] = 'Unknown';
        }
        // print(request); // Now each request object includes the first_name
      }

      if (await isOwner(supabase.auth.currentUser!.id) == false) {
        data.removeWhere((element) =>
            element['role'] == 'pending_manager' ||
            element['role'] == 'rejected_manager' ||
            element['role'] == 'manager');
      }

      setState(() {
        _requestList = data ?? [];
        _isLoading = false; // Set loading to false after fetching
      });
      print(_requestList);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteRequest(
      String requestId, String requesterId, String roleRequested) async {
    try {
      // Update Request Status
      final response = await supabase
          .from('request')
          .update({'request_status': 'rejected'}).eq('request_id', requestId);

      // Update User to have role of employee or manager
      final response2 = await supabase
          .from('user_profile')
          .update({'role': 'declined'}).eq('id', requesterId);
      print(response);

      await _fetchRequests(); // Fetch fresh data after updating
    } catch (e) {
      print(e);
    }
  }

  Future<void> _confirmRequest(String requestId, String plantationId,
      String requesterId, String roleRequested) async {
    try {
      // Update the request status to confirmed
      final response = await supabase
          .from('request')
          .update({'request_status': 'accepted'}).eq('request_id', requestId);

      // Update User to have Plantation ID
      final response1 = await supabase
          .from('user_profile')
          .update({'plantation_id': plantationId}).eq('id', requesterId);

      // Update User to have role of employee or manager
      if (roleRequested == 'pending_employee') {
        final response2 = await supabase
            .from('user_profile')
            .update({'role': 'employee'}).eq('id', requesterId);
      } else {
        final response2 = await supabase
            .from('user_profile')
            .update({'role': 'manager'}).eq('id', requesterId);
      }

      await _fetchRequests(); // Fetch fresh data after updating
    } catch (e) {
      print(e);
      SnackBar(
        content: Text('Request failed'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }
}
