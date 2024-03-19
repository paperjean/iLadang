import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sawitcare_app/pages/activity/activities_summary_widget.dart';
import 'package:sawitcare_app/pages/activity/activity_info_card.dart';
import 'package:sawitcare_app/pages/activity/activity_list.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/promo_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/horizontal_card.dart';
import 'package:sawitcare_app/services/activity.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/date_picker.dart';

class EmployeeActivity extends StatefulWidget {
  const EmployeeActivity({super.key});

  @override
  State<EmployeeActivity> createState() => _EmployeeActivityState();
}

class _EmployeeActivityState extends State<EmployeeActivity> {
  List? _activityList;
  int harvestCount = 0;
  int pruneCount = 0;
  int fertilizeCount = 0;
  List? _originalActivityList; // Store original unfiltered list
  List<String> _employeeNameList = ['Everyone']; // Initialize with 'All'
  String _selectedName = 'Everyone'; // Default value
  String _selectedTime = 'All Time'; // Default value
  DateTime? startDate;
  DateTime? endDate;
  bool _isLoading = true;

  @override
  void initState() {
    _fetchActivityListByCurrentUser();
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  const Text(
                    'Activities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Drop Down With Text
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        final result = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate:
                              DateTime.now().add(const Duration(days: 356)),
                        );
                        if (result != null) {
                          setState(() {
                            startDate = result.start;
                            endDate = result.end;
                            _filterActivitiesListByDateRange(
                                startDate!, endDate!);
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_month_rounded)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  Visibility(
                    visible: _isLoading == false,
                    child: Text(
                      startDate != null && endDate != null
                          ? 'From ${startDate?.day}/${startDate?.month}/${startDate?.year} to ${endDate?.day}/${endDate?.month}/${endDate?.year}'
                          : 'Recent',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Reset button
                  Visibility(
                    visible: startDate != null && endDate != null,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          startDate = null;
                          endDate = null;
                          _filterActivitiesListByDateRange(
                              DateTime(2000), DateTime.now());
                        });
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Color.fromRGBO(43, 128, 90, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: LinearProgressIndicator(),
                    ),
                  )
                : ActivityList(activityList: _activityList),
          ],
        )),
      ),
    );
  }

// Filter by date range
  void _filterActivitiesListByDateRange(DateTime startDate, DateTime endDate) {
    try {
      setState(() {
        _activityList = _originalActivityList?.where((activity) {
          if (activity['created_at'] != null) {
            DateTime activityDate = DateTime.parse(activity['created_at']);
            return activityDate.isAfter(startDate) &&
                activityDate.isBefore(endDate);
          }
          return false; // If created_at is null, exclude the activity
        })?.toList();
      });
    } catch (e) {
      print(e);
    }

    // Summarize the activities
    _summarizeActivities();
  }

  // Summarize the activities
  void _summarizeActivities() {
    setState(() {
      // Reset the counts
      harvestCount = 0;
      pruneCount = 0;
      fertilizeCount = 0;

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
    });
  }

  Future<void> _fetchActivityListByCurrentUser() async {
    try {
      final data =
          await fetchActivityListByCurrentUser(); // Call the service function
      if (mounted) {
        setState(() {
          _activityList = data ?? []; // Assign fetched data to _activityList
          _originalActivityList =
              _activityList; // Store a copy in _originalActivityList
        });
      }
      _isLoading = false;
      // Summarize the activities
      _summarizeActivities();
      print(_activityList);
    } catch (e) {
      print(e);
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
