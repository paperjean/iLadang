import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';

Future<bool> isOwner(String CurrentId) async {
  try {
    final response =
        await supabase.from('user_profile').select('role').eq('id', CurrentId);

    if (response.first['role'] == 'owner') {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> isManager(String CurrentId) async {
  try {
    final response =
        await supabase.from('user_profile').select('role').eq('id', CurrentId);

    if (response.first['role'] == 'manager') {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> isEmployee(String CurrentId) async {
  try {
    final response =
        await supabase.from('user_profile').select('role').eq('id', CurrentId);

    if (response.first['role'] == 'employee') {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

// Get User Profile Plantation Id
Future<String> getUserPlantationId(String currentId) async {
  try {
    // Await the database response to get the actual data
    final response = await supabase
        .from('user_profile')
        .select('plantation_id')
        .eq('id', currentId)
        .single();

    final plantationId = response['plantation_id'];

    return plantationId; // Return the extracted plantation_id
  } catch (e) {
    print(e); // Log any errors
    return ''; // Return an empty string if an error occurs
  }
}
