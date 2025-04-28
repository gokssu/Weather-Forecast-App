import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier._(super.mode);
  static const _key = 'theme_mode';

  static Future<ThemeNotifier> create(Brightness systemBrightness) async {
    final preferences = await SharedPreferences.getInstance();
    final savedValue = preferences.getString(_key);

    ThemeMode initialMode;
    if (savedValue == 'dark') {
      initialMode = ThemeMode.dark;
    } else if (savedValue == 'light') {
      initialMode = ThemeMode.light;
    } else {
      // Device theme
      initialMode =
          systemBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;
    }

    return ThemeNotifier._(initialMode);
  }

  Future<void> toggleTheme() async {
    final preferences = await SharedPreferences.getInstance();

    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await preferences.setString(_key, state.name); // 'light' or 'dark'
  }
}

final themeNotifierProvider = Provider<ThemeNotifier>((ref) {
  throw UnimplementedError('Must be overridden');
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ref.watch(themeNotifierProvider),
);
