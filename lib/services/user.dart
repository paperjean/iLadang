import 'package:sawitcare_app/main.dart';

Future<String?> fetchName() async {
  try {
    final response = await supabase
        .from('user_profile')
        .select(
          'first_name, last_name',
        )
        .eq(
          'id',
          supabase.auth.currentUser!.id,
        );

    final fullName =
        response.first['first_name'] + ' ' + response.first['last_name'];

    return fullName;
  } catch (e) {
    print(e);
  }
  return null;
}
