import 'dart:convert';

import 'package:app/models/account_model.dart';
import 'package:http/http.dart' as http;

import '../models/network_response.dart';

class Account {
  Future<Result> createAccount(
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
  ) async {
    final url = "https://jsonplaceholder.typicode.com/posts";
    final body = {
      "name": name,
      "email": email,
      "password": password,
      "password1": confirmPassword,
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("fetchTrendingImages : ${data}");

        // Parse JSON into your model
        final imageResponse = AccountResponse.fromJson(data);
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
