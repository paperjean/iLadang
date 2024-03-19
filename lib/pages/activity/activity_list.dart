import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sawitcare_app/pages/activity/activity_info_card.dart';
import 'package:sawitcare_app/services/activity.dart';

class ActivityList extends StatefulWidget {
  final List? _activityList;
  const ActivityList({Key? key, List? activityList})
      : _activityList = activityList,
        super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  // Method to get the formatted date string
  String getFormattedDate(String dateString) {
    DateTime activityDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(activityDate).abs();

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays <= 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else {
      return DateFormat('dd/MM/yy').format(activityDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
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
              child: Row(
                children: [
                  Text(
                    '${widget._activityList?[index]?['first_name']} ${widget._activityList?[index]?['type'] == 'harvesting' ? 'harvested' : (widget._activityList?[index]?['type'] == 'pruning' ? 'pruned' : 'fertilized')} Tree ${widget._activityList?[index]?['block']}${widget._activityList?[index]?['tree_number']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    DateFormat('h:mm a').format(DateTime.parse(
                        widget._activityList?[index]?['created_at'])),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                  Text(
                    getFormattedDate(
                        widget._activityList?[index]?['created_at']),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget._activityList?.length ?? 0,
      ),
    );
  }
}
