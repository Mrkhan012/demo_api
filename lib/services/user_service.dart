import 'dart:convert';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
 static Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);

    // Try parsing each user one-by-one and log if it fails
    List<User> users = [];
    for (var json in data) {
      try {
        users.add(User.fromJson(json));
      } catch (e) {
        print('Failed to parse user: $json\nError: $e');
      }
    }

    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
}