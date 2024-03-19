// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/management/employee/employee_request_list.dart';
import 'package:sawitcare_app/services/user_validation.dart';
import 'package:sawitcare_app/services/employee_management.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  List? _employeeList;

  bool _isLoading = true; // Initialize as true to show loading initially

  @override
  void initState() {
    super.initState();
    _fetchEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Employee',
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person_add_alt_1,
                      size: 30), // Replace with your desired icon
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeRequest()));
                  },
                ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _employeeList!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            )),
                        child: ListTile(
                          tileColor: Colors.white,
                          onLongPress: () async {
                            // If manager & click on owner || manager, show remove employee dialog
                            if (await isManager(
                                        supabase.auth.currentUser!.id) ==
                                    true &&
                                (_employeeList?[index]['role'] == 'owner' ||
                                    _employeeList?[index]['role'] ==
                                        'manager')) {
                              // Restricted Access Dialog
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      surfaceTintColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        'Restricted Access',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      content: const Text(
                                        'You do not have permission to remove this user.',
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
                                                    BorderRadius.circular(10)),
                                          ),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      surfaceTintColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        'Remove ' +
                                            _employeeList?[index]
                                                ['first_name'] +
                                            ' ' +
                                            _employeeList?[index]['last_name'] +
                                            '?',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      content: const Text(
                                        'Are you sure you want to remove this employee?',
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
                                                    BorderRadius.circular(10)),
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
                                                const Color.fromRGBO(
                                                    201, 53, 59, 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            removeEmployee(
                                                _employeeList![index]['id']);
                                            setState(() {
                                              _employeeList!.removeAt(index);
                                            });
                                          },
                                          child: const Text(
                                            'Remove',
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
                            }
                          },
                          title: Text(
                            _employeeList![index]['first_name'] +
                                ' ' +
                                _employeeList![index]['last_name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle:
                              // If role is owner, show owner, if role is manager, show manager, else show employee
                              Text(
                            _employeeList![index]['role'] == 'owner'
                                ? ' Owner'
                                : _employeeList![index]['role'] == 'manager'
                                    ? 'Manager'
                                    : 'Employee',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.call),
                                onPressed: () async {
                                  print('Pressed Trailing');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.messenger_sharp),
                                onPressed: () async {
                                  print('Pressed Trailing');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ));
  }

  Future<void> _fetchEmployee() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching
    });
    // Fetch the list of requests from Supabase
    try {
      final data = await supabase
          .from('user_profile')
          .select(
            'first_name, last_name, role, phone, id',
          )
          .eq(
            'plantation_id',
            await getUserPlantationId(supabase.auth.currentUser!.id),
          )
          .neq('id', supabase.auth.currentUser!.id);

      setState(() {
        _employeeList = data ?? [];
        _isLoading = false; // Set loading to false after fetching
      });
      print(_employeeList);
    } catch (e) {
      print(e);
    }
  }
}
