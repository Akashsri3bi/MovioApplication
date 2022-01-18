import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/movie.dart';

class Webservice {
  Future<List<Movie>> loadMovies(String key) async {
    String url = "http://www.omdbapi.com/?s=" + key + "&apiKey=a7f07251";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["Search"];
      if (list != null) {
        return list.map((item) => Movie.fromJson(item)).toList();
      }
      return [];
    } else {
      throw Exception("Error loading status");
    }
  }

  Future<List<Movie>> loadGeneral(String key) async {
    String url = "http://www.omdbapi.com/?s=" + key + "&apiKey=a7f07251";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["Search"];
      if (list != null) {
        return list.map((item) => Movie.fromJson(item)).toList();
      }
      return [];
    } else {
      throw Exception("Error loading status");
    }
  }
}
