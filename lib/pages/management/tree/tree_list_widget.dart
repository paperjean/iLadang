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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Tree $treeId',
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
      ),
    );
  }
}
