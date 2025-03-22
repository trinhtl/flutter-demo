import 'dart:convert';
import 'dart:ffi';

import 'package:crud_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String url = 'http://localhost:8080/users';

  static Future<List<User>> getUsers() async {
    print('getUsers-----------------------');
    try {
      final response = await http.get(Uri.parse(url + '/list'));
      if (response.statusCode == 200) {
        Map userMap = jsonDecode(response.body);
        return List<User>.from(
            userMap['content'].map((user) => User.fromJson(user)));
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  static Future<User> getUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$url/$id'));
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return User(firstName: '', lastName: '', email: '');
      }
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }

  static Future<num?> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }

  static Future<num?> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('$url/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to update user');
    }
  }

  static Future<void> deleteUser(num id) async {
    try {
      final response = await http.delete(Uri.parse('$url/$id'));
      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }
}
