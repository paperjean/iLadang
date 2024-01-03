import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/cardwidget.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/price_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/delivery_record.dart';
import 'package:sawitcare_app/pages/management/yield/bar_graph.dart';

import '../reporting/report_form.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        colors: [Color(0xff53E88B), Color(0xff15BE77)])),
                child: const Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.location_on_outlined,
                            size: 60, color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          "Find Tree",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        colors: [Color(0xff53E88B), Color(0xff15BE77)])),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.qr_code_scanner_rounded,
                            size: 60, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportForm()),
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
              ),
            )
          ],
        ));
  }
}
