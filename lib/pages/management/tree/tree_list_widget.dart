import 'package:flutter/material.dart';

class TreeListWidget extends StatelessWidget {
  final String? treeId;
  final String? harvest;
  final String? fertilize;
  final String? prune;
  // final Function() onMoreTap;

  const TreeListWidget(
      {required this.treeId,
      required this.harvest,
      required this.fertilize,
      required this.prune,
      // required this.onMoreTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color(0x6639D2C0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.forest,
                size: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 25, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Tree $treeId',
                    // '#${treeId}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(harvest != null
                  ? 'Harvested $harvest days ago'
                  : 'Harvesting data unavailable'),
              Text(prune != null
                  ? 'Pruned $prune days ago'
                  : 'Pruning data unavailable'),
              Text(fertilize != null
                  ? 'Fertilized $fertilize days ago'
                  : 'Fertilizing data unavailable'),
            ],
          ),
        ),
      ],
    );
  }
}
