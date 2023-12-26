import 'package:sawitcare_app/main.dart';

// Remove Employee
Future<bool> removeEmployee(String id) async {
  try {
    // Update User Role & Plantation ID to null
    final response = await supabase
        .from('user_profile')
        .update({'role': 'removed', 'plantation_id': null}).eq('id', id);
    if (response.error == null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
