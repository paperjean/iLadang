import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/field/reporting/scan_nfc_page.dart';
import 'package:sawitcare_app/services/user.dart';

import '../reporting/report_form.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String fullName = '';
  void initState() {
    super.initState();
    fetchAndSetFirstName();
  }

  Future<void> fetchAndSetFirstName() async {
    String? data = await fetchName();
    if (mounted) {
      setState(() {
        fullName = data!;
      });
    }
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
                'Menu',
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back,",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    Text('$fullName',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/tree_screen');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(230, 252, 242, 1),
                      border: Border.all(
                          color: Color.fromRGBO(43, 128, 90, 1), width: 1)),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.search,
                            size: 100,
                            color: Color.fromRGBO(43, 128, 90, 1),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            "Find Tree",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(43, 128, 90, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(27, 115, 75, 1),
                      Color.fromRGBO(52, 169, 116, 1),
                      Color.fromRGBO(0, 107, 58, 1)
                    ])),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/nfc_scan.png',
                            width: 100,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScanNFC()),
                        );
                        print("Scan and Report");
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text(
                            "Scan and Report",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
