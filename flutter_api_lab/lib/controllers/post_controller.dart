library post_controller;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_api_lab/models/post_model.dart' as post_model;


Future<List<post_model.Post>> fetchPosts() async {
  try {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{'Content-Type': 'application/json'})
        .timeout(const Duration(seconds: 1));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post) => post_model.Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }

  } catch(e) {
    throw Exception('Failed to load posts: $e');
  }
}
