import 'dart:convert';

import 'package:app/models/image_model.dart';
import 'package:http/http.dart' as http;

import '../models/network_response.dart';

class Pixabay {
  var apiKey = "52447905-906617d2821a32a015407b6c8";
  Future<Result> fetchTrendingImages(String orderBy) async {
    final url =
        // "https://pixabay.com/api/?key=$apiKey&image_type=photo&order=popular&per_page=2";
        // "https://pixabay.com/api/?key=$apiKey&q=yellow+flowers&image_type=photo&pretty=true&per_page=5&order=popular";
        "https://pixabay.com/api/?key=$apiKey&image_type=photo&pretty=true&per_page=20&order=$orderBy";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("fetchTrendingImages : ${data}");

        // Parse JSON into your model
        final imageResponse = ImageResponse.fromJson(data);
        print("fetchTrendingImages : ${imageResponse.toJson()}");

        return Success(imageResponse);
      } else {
        return Failure(
          "Request failed: ${response.statusCode} - ${response.reasonPhrase}",
        );
      }
    } on http.ClientException catch (e) {
      return Failure("Network error: $e");
    } on FormatException catch (e) {
      return Failure("JSON parse error: $e");
    } catch (e) {
      return Failure("Unexpected error: $e");
    }
  }

  Future<Result> searchImages({String? query = "yellow+flowers"}) async {
    final url =
        "https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&pretty=true&per_page=20";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("fetchTrendingImages : ${data}");

        // Parse JSON into your model
        final imageResponse = ImageResponse.fromJson(data);
        print("fetchTrendingImages : ${imageResponse.toJson()}");

        return Success(imageResponse);
      } else {
        return Failure(
          "Request failed: ${response.statusCode} - ${response.reasonPhrase}",
        );
      }
    } on http.ClientException catch (e) {
      return Failure("Network error: $e");
    } on FormatException catch (e) {
      return Failure("JSON parse error: $e");
    } catch (e) {
      return Failure("Unexpected error: $e");
    }
  }
}
