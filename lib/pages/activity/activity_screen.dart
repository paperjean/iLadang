import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/activity/activities_summary_widget.dart';
import 'package:sawitcare_app/pages/activity/activity_info_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/promo_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/horizontal_card.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            centerTitle: false,
            title: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                  ),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          children: [
            ActivitySummaryCard(treeName: "20"),
            // Line
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    'List of Activities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Drop Down With Text
                  Spacer(),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Color.fromRGBO(226, 232, 240, 1),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          children: [
                            Text(
                              'All',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            // List with Name, Activity Done, Date Time
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ActivityInfoDialog();
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(10, 20),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.05)),
                  ],
                ),
                child: const Row(
                  children: [
                    Text(
                      'Ikmal harvested a tree at B153',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    Spacer(),
                    Text(
                      '3:00 PM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      ' | ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      'Today',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            // Space
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(10, 20),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.05)),
                  ],
                ),
                child: const Row(
                  children: [
                    Text(
                      'Ikmal harvested a tree at B153',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    Spacer(),
                    Text(
                      '3:00 PM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      ' | ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      'Today',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            // Space
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(10, 20),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.05)),
                  ],
                ),
                child: const Row(
                  children: [
                    Text(
                      'Ikmal harvested a tree at B153',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    Spacer(),
                    Text(
                      '3:00 PM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      ' | ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    Text(
                      'Today',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
