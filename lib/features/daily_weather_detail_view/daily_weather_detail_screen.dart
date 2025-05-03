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
            DateFormat(
              'MMMM d',
              context.locale.toString(),
            ).format(DateTime.parse(date)),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Time'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Temp'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Feels Like'.tr(),
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Humidity'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Wind'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(thickness: 0.7),
              itemCount: dayHours.length,
              itemBuilder: (context, index) {
                final item = dayHours[index];
                final time =
                    item.dtTxt != null
                        ? DateFormat(
                          'HH:mm',
                        ).format(DateTime.parse(item.dtTxt!))
                        : '--:--';

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            time,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: Image.network(
                            '${Config.imageUrl}${item.icon}@2x.png',
                            width: 50,
                            height: 50,
                            errorBuilder:
                                (_, __, ___) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${item.temp.toStringAsFixed(1)}${isCelsius ? '°C' : '°F'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${item.feelsLike.toStringAsFixed(1)}${isCelsius ? '°C' : '°F'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${item.humidity}%',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${item.windSpeed.toStringAsFixed(1)} ༄',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
