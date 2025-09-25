import 'package:app/models/image_model.dart';
import 'package:app/services/account.dart';
import 'package:app/services/pixabay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/network_response.dart';

class AppProvider extends ChangeNotifier {
  final Ref ref;
  AppProvider({required this.ref});

  Pixabay pixabay = Pixabay();
  Account account = Account();
  String selectedCategory = "popular";
  List<String> categories = ["popular", "latest"];
  List<Hit>? images, queryImages;
  Hit? selectedImage;

  bool loading = true, updating = false;

  String? fullName, email, password, confirmPassword;

  var userId;

  void fetchImages() {
    pixabay.fetchTrendingImages(selectedCategory).then((result) {
      print("fetchImages : ${result is Failure}");
      if (result is Success) {
        images = (result.data as dynamic).hits;
        loading = false;
        notifyListeners();
      } else if (result is Failure) {
        print("fetchImages : ${result.message}");
        // Handle error
        loading = false;
        notifyListeners();
      }
    });
  }

  void searchImages(String query) {
    pixabay.searchImages(query: query).then((result) {
      print("fetchImages : ${result is Failure}");
      if (result is Success) {
        queryImages = (result.data as dynamic).hits;
        loading = false;
        notifyListeners();
      } else if (result is Failure) {
        print("fetchImages : ${result.message}");
        // Handle error
        loading = false;
        notifyListeners();
      }
    });
  }

  Future<bool> createUserAccount() async {
    updating = true;
    notifyListeners();
    var res = await account.createAccount(
      fullName,
      email,
      password,
      confirmPassword,
    );
    if (res is Success) {
      final response = (res.data as dynamic);
      print("createUserAccount : ${response.toJson()}");
      userId = response.id;
      updating = false;
      fullName = null;
      email = null;
      password = null;
      confirmPassword = null;
      notifyListeners();
      return Future.value(true);
    }

    if (res is Failure) {
      print("createUserAccount : ${res.message}");
      // Handle error
      updating = false;
      notifyListeners();
      return Future.value(false);
    }
    return Future.value(false);
  }
}

final appProvider = ChangeNotifierProvider<AppProvider>(
  (ref) => AppProvider(ref: ref),
);
