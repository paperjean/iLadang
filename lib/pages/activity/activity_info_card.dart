import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActivityInfoDialog extends StatelessWidget {
  final String? imageUrl;
  final String first_name;
  final String action;
  final String block;
  final int tree_number;
  final String time;
  final String date;
  final String? remark;
  final String? bunches;

  const ActivityInfoDialog(
      {Key? key,
      required this.imageUrl,
      required this.first_name,
      required this.action,
      required this.block,
      required this.tree_number,
      required this.time,
      required this.date,
      required this.remark,
      required this.bunches})
      : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          children: [
            // Reporting Image
            imageUrl == null || imageUrl == ''
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 200,
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        size: 100,
                        color: Colors.grey.shade400,
                      ),
                    ))
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: double
                            .infinity, // Make the image take the full width of the container
                        height:
                            200, // Specify a fixed height to control the size
                      ),
                    ),
                  ),
            // Table
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    const Text('Employee',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(' $first_name'),
                  ]),
                  TableRow(children: [
                    const Text('Action',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    // Capital first letter of action
                    Text(' ${action[0].toUpperCase()}${action.substring(1)}'),
                  ]),
                  TableRow(children: [
                    const Text('Tree',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(' $block$tree_number'),
                  ]),
                  TableRow(children: [
                    const Text('Time',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(' $time'),
                  ]),
                  TableRow(children: [
                    const Text('Date',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(' $date'),
                  ]),
                  // If remark is null or empty, don't show the remark
                  remark == null || remark == ''
                      ? const TableRow(children: [Text(''), Text('')])
                      : TableRow(children: [
                          const Text('Remark',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(' $remark'),
                        ]),
                  // If bunches is null or empty, don't show the bunches
                  bunches == null || bunches == ''
                      ? const TableRow(children: [Text(''), Text('')])
                      : TableRow(children: [
                          const Text('Bunches',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(' $bunches'),
                        ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
