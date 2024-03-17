import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/activity/activities_summary_widget.dart';
import 'package:sawitcare_app/pages/activity/activity_info_card.dart';
import 'package:sawitcare_app/pages/activity/activity_list.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/promo_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/horizontal_card.dart';
import 'package:sawitcare_app/services/activity.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  List? _activityList;
  int harvestCount = 0;
  int pruneCount = 0;
  int fertilizeCount = 0;

  @override
  void initState() {
    _fetchActivityList();
    super.initState();
  }

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
            ActivitySummaryCard(
              // Past activities count with type : harvesting
              harvested: harvestCount,
              fertilized: fertilizeCount,
              pruned: pruneCount,
              overall: harvestCount + fertilizeCount + pruneCount,
            ),
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
                    'Recent Activities',
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
            ActivityList(activityList: _activityList),
          ],
        )),
      ),
    );
  }

  Future<void> _fetchActivityList() async {
    try {
      final data = await fetchActivityList(); // Call the service function
      if (mounted) {
        setState(() {
          _activityList = data ?? []; // Assign fetched data to _treeList
        });
      }

      if (_activityList != null) {
        for (var activity in _activityList!) {
          if (activity['type'] == 'harvesting') {
            harvestCount++;
          }
          if (activity['type'] == 'pruning') {
            pruneCount++;
          }
          if (activity['type'] == 'fertilizing') {
            fertilizeCount++;
          }
        }
      }

      print(_activityList);
    } catch (e) {
      print(e);
    }
  }
}
