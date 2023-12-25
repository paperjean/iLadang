import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/management/employee/employee_screen%20copy.dart';
import 'package:sawitcare_app/services/user_validation.dart';

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
        backgroundColor: Color.fromARGB(255, 47, 47, 47),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 47, 47, 47),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Employee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.person_add_alt_1,
                      color: Colors.white,
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _employeeList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          _employeeList![index]['first_name'] +
                              ' ' +
                              _employeeList![index]['last_name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _employeeList![index]['role'],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        trailing: Text(
                          _employeeList![index]['phone'],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
            'first_name, last_name, role, phone',
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
