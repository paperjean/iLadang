import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/services/user_validation.dart';

Future<List<Map<String, dynamic>>?> fetchTreeList() async {
  try {
    // Fetch the list of requests from Supabase
    final data = await supabase
        .from('tree')
        .select('tree_id, block, tree_number, latitude, longitude')
        .eq(
          'plantation_id',
          await getUserPlantationId(supabase.auth.currentUser!.id),
        );

    // Convert List<dynamic> to List<Map<String, dynamic>>
    final treeList = data
        .map<Map<String, dynamic>>(
            (dynamic item) => item as Map<String, dynamic>)
        .toList();

    // For every tree, fetch the activities data done for fertilizing, pruning, and harvesting
    for (var tree in treeList) {
      // Fetch all activities and order by date
      final postData = await supabase
          .from('activity')
          .select()
          .eq(
            'tree_id',
            tree['tree_id'],
          )
          .order('created_at', ascending: false);

      // Initialize date fields to null
      tree['daysHarvested'] = null;
      tree['daysPruned'] = null;
      tree['daysFertilized'] = null;
      // If postData is not empty - see if got activity == harvest/fertilize/prune
      if (postData.isNotEmpty) {
        for (var activity in postData) {
          final now = DateTime.now();
          final activityDateTime = DateTime.parse(activity['created_at']);
          final durationInSeconds = now.difference(activityDateTime).inSeconds;
          final durationInDays =
              durationInSeconds / (24 * 60 * 60); // Number of seconds in a day

          if (activity['type'] == 'harvesting') {
            tree['daysHarvested'] = durationInDays.toStringAsFixed(1);
          }
          if (activity['type'] == 'pruning') {
            tree['daysPruned'] = durationInDays.toStringAsFixed(1);
          }
          if (activity['type'] == 'fertilizing') {
            tree['daysFertilized'] = durationInDays.toStringAsFixed(1);
          }
        }
      }
    }

    return treeList; // Return the fetched tree list
  } catch (e) {
    print(e);
    return null; // Return null if an error occurs
  }
}

// Function to post data of block to supabase
Future<bool> postBlockData(
  String blockLabel,
  int blockColor,
  List<LatLng> cornerList,
  String? employeeId,
) async {
  // Convert cornerList to JSON
  try {
    final List<Map<String, dynamic>> cornerListJson = cornerList
        .map<Map<String, dynamic>>(
          (LatLng corner) => {
            'latitude': corner.latitude,
            'longitude': corner.longitude,
          },
        )
        .toList();
    await supabase.from('tree_block').upsert({
      'block_label': blockLabel,
      'color': blockColor,
      'corner_coordinates': cornerListJson,
      'plantation_id': await getUserPlantationId(supabase.auth.currentUser!.id),
      'employee_id': employeeId,
    });
    return true;
  } catch (e) {
    print(e);
    // Error Snackbar
    SnackBar(
      content: const Text('Error Registering Block'),
      backgroundColor: Colors.red[400],
    );
    return false;
  }
}

// Function to fetch block coordinates from supabase
Future<List<Map<String, dynamic>>> fetchBlockCoordinates() async {
  try {
    final data = await supabase.from('tree_block').select().eq(
          'plantation_id',
          await getUserPlantationId(supabase.auth.currentUser!.id),
        );
    final blockList = data
        .map<Map<String, dynamic>>(
            (dynamic item) => item as Map<String, dynamic>)
        .toList();

    // Change List of Coordinates to List of LatLng
    for (var block in blockList) {
      final List<LatLng> cornerCoordinates = block['corner_coordinates']
          .map<LatLng>(
            (dynamic item) => LatLng(
              item['latitude'],
              item['longitude'],
            ),
          )
          .toList();
      block['corner_coordinates'] = cornerCoordinates;
    }
    print(blockList);
    return blockList;
  } catch (e) {
    print(e);
    return [];
  }
}
