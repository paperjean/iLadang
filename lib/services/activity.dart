import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/services/user_validation.dart';

Future<List<Map<String, dynamic>>?> fetchActivityList() async {
  try {
    // Fetch the list of requests from Supabase
    final data = await supabase
        .from('activity')
        .select(
            'activity_id, created_at, updater_id, type, tree_id, image_url, remark')
        .eq(
          'plantation_id',
          await getUserPlantationId(supabase.auth.currentUser!.id),
        );

    // Convert List<dynamic> to List<Map<String, dynamic>>
    final activityList = data
        .map<Map<String, dynamic>>(
            (dynamic item) => item as Map<String, dynamic>)
        .toList();

    // For every activity, append with updater name
    for (var activity in activityList) {
      // Fetch all names of the updater
      final postData = await supabase
          .from('user_profile')
          .select(
            'first_name',
          )
          .eq(
            'id',
            activity['updater_id'],
          );

      // Access the first_name from the fetched postData
      final firstName = postData.first['first_name'];
      activity['first_name'] = firstName;

      // Fetch the tree number & block
      final treeData = await supabase
          .from('tree')
          .select(
            'tree_number, block',
          )
          .eq(
            'tree_id',
            activity['tree_id'],
          );

      // Access the tree_number & block from the fetched treeData
      final treeNumber = treeData.first['tree_number'];
      final block = treeData.first['block'];
      activity['tree_number'] = treeNumber;
      activity['block'] = block;
    }
    activityList.sort((a, b) => DateTime.parse(b['created_at'])
        .compareTo(DateTime.parse(a['created_at'])));

    return activityList; // Return the fetched tree list
  } catch (e) {
    print(e);
    return null; // Return null if an error occurs
  }
}

Future<List<Map<String, dynamic>>?> fetchActivityListByCurrentUser() async {
  try {
    // Fetch the list of requests from Supabase
    final data = await supabase
        .from('activity')
        .select(
            'activity_id, created_at, updater_id, type, tree_id, image_url, remark')
        .eq(
          'plantation_id',
          await getUserPlantationId(supabase.auth.currentUser!.id),
        )
        .eq(
          'updater_id',
          supabase.auth.currentUser!.id,
        );

    // Convert List<dynamic> to List<Map<String, dynamic>>
    final activityList = data
        .map<Map<String, dynamic>>(
            (dynamic item) => item as Map<String, dynamic>)
        .toList();

    // For every activity, append with updater employee name and tree number
    for (var activity in activityList) {
      activity['first_name'] = 'You'; // Set the updater name to 'You'
      // Fetch the tree number & block
      final treeData = await supabase
          .from('tree')
          .select(
            'tree_number, block',
          )
          .eq(
            'tree_id',
            activity['tree_id'],
          );

      // Access the tree_number & block from the fetched treeData
      final treeNumber = treeData.first['tree_number'];
      final block = treeData.first['block'];
      activity['tree_number'] = treeNumber;
      activity['block'] = block;
    }
    activityList.sort((a, b) => DateTime.parse(b['created_at'])
        .compareTo(DateTime.parse(a['created_at'])));

    return activityList; // Return the fetched tree list
  } catch (e) {
    print(e);
    return null; // Return null if an error occurs
  }
}
