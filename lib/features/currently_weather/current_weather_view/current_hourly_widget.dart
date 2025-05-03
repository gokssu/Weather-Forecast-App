import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/error_screen.dart';
import 'package:weather_forecast_app/core/widgets/loading_screen.dart';
import 'package:weather_forecast_app/core/widgets/units_switch_widget.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';

class CurrentHourlyWidget extends HookConsumerWidget {
  const CurrentHourlyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isUnitCelsiusProvider);
    final hourlyWeather = ref.watch(
      getOneDayProvider(context.locale.languageCode),
    );
    return hourlyWeather.when(
      data: (hourlyWeather) {
        final hourlyList = hourlyWeather.list;
        return ListView(
          scrollDirection: Axis.horizontal,
          children:
              hourlyList
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 8,
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.dtTxt != null
                                ? DateFormat(
                                  'HH:mm',
                                ).format(DateTime.parse(item.dtTxt!))
                                : '--:--',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                            child: Image.network(
                              '${Config.imageUrl}${item.icon}@2x.png',
                              width: 50,
                              height: 50,
                              errorBuilder:
                                  (_, __, ___) => const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${item.temp.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        );
      },
      error:
          (e, st) => SizedBox(
            height: 200,
            child: ErrorScreen(
              errorMessage: 'Weather could not be received'.tr(),
            ),
          ),
      loading: () => SizedBox(height: 200, child: const LoadingScreen()),
    );
  }
}
