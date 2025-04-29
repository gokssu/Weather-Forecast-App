import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationControllerProvider =
    StateNotifierProvider<BottomNavigationController, int>((ref) {
      return BottomNavigationController(0);
    });

class BottomNavigationController extends StateNotifier<int> {
  BottomNavigationController(super.state);

  void setPosition(int value) {
    state = value;
  }
}
