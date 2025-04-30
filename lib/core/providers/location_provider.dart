import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';

final locationNotifierProvider =
    StateNotifierProvider<LocationNotifier, AsyncValue<Position?>>(
      (ref) => LocationNotifier(),
    );

/// Notifier
class LocationNotifier extends StateNotifier<AsyncValue<Position?>> {
  LocationNotifier() : super(const AsyncLoading()) {
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are not open.'.tr());
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied.'.tr());
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions permanently denied.'.tr());
      }

      final position = await Geolocator.getCurrentPosition();
      state = AsyncValue.data(position);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void setCustomPosition(Position position) {
    state = AsyncValue.data(position);
  }

  Future<void> refreshLocation() async {
    state = const AsyncLoading();
    await _getUserLocation();
  }
}
