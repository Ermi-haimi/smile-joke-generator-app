// import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchJoke({required String category}) async {
  final response = await http.get(
    Uri.parse('https://v2.jokeapi.dev/joke/$category?format=txt'),
  );

  if (response.statusCode == 200) {
    return response.body;
  }

  throw Exception("Failed to load joke");
}
