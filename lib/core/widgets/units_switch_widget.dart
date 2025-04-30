import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/current_weather_provider.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';

final isUnitCelsiusProvider = StateProvider<bool>((ref) => true);

class UnitsSwitchWidget extends HookConsumerWidget {
  final Position position;
  const UnitsSwitchWidget({super.key, required this.position});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isUnitCelsiusProvider);
    final notifier = ref.read(isUnitCelsiusProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '°F',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Switch(
            value: isCelsius,
            onChanged: (val) {
              notifier.state = val;
              ref.watch(getCurrentProvider(context.locale.languageCode));
              ref.watch(getOneDayProvider(context.locale.languageCode));
            },
            activeColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          Text(
            '°C',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
