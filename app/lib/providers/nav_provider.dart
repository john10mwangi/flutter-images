import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavProvider extends ChangeNotifier {
  final Ref ref;
  NavProvider({required this.ref});
  int selectedIndex = 0;
  final List<int> previousPageIndex = [0];

  void handleHistoryEntryRemoved() {
    previousPageIndex.removeLast();
    selectedIndex = previousPageIndex.isNotEmpty ? previousPageIndex.last : 0;
  }

  void setSelectedIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}

final navProvider = ChangeNotifierProvider<NavProvider>(
  (ref) => NavProvider(ref: ref),
);
