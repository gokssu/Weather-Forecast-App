import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated/source/models/index.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/base_widget.dart';
import 'package:weather_forecast_app/core/widgets/units_switch_widget.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';

class DailyWeatherDetailScreen extends HookConsumerWidget {
  final String date;
  const DailyWeatherDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isUnitCelsiusProvider);
    final weeklyWeather =
        ref.read(get7DayProvider(context.locale.languageCode)).value;
    late List<HourlyWeather> dayHours = [];
    if (weeklyWeather != null && weeklyWeather.list.isNotEmpty) {
      for (var day in weeklyWeather.list) {
        if (day.dtTxt != null &&
            DateFormat('yyyy-MM-dd').format(DateTime.parse(day.dtTxt!)) ==
                date) {
          dayHours.add(day);
        }
      }
    }
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Daily Detail'.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      childBody: Column(
        children: [
          Text(
            DateFormat('MMMM d').format(DateTime.parse(date)),

            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Time'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 60),
              Text(
                'Temp'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              Text(
                'Feels Like:'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              Text(
                'Humidity:'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),

              Text(
                'Wind:'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),

          Expanded(
            child: ListView(
              children:
                  dayHours
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 8,
                            bottom: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                item.dtTxt != null
                                    ? DateFormat(
                                      'HH:mm',
                                    ).format(DateTime.parse(item.dtTxt!))
                                    : '--:--',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(width: 8),
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.secondaryContainer,
                                child: Image.network(
                                  '${Config.imageUrl}${item.icon}@2x.png',
                                  width: 40,
                                  height: 40,
                                  errorBuilder:
                                      (_, __, ___) => const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${item.temp} ${isCelsius ? '°C' : '°F'}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '${item.feelsLike} ${isCelsius ? '°C' : '°F'}',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${item.humidity} %',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                              Text(
                                '${item.windSpeed} ༄',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
