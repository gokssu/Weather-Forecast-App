import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated/generated.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/providers/router_provider.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/units_switch_widget.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_view_model/daily_weather_view_model.dart';

class DailyWeatherWidget extends ConsumerWidget {
  const DailyWeatherWidget({super.key, required this.weather});
  final DailyWeatherResponse weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isUnitCelsiusProvider);
    final dailyList = DailyWeatherViewModel.parseDailyWeather(weather.list);
    return Column(
      children:
          dailyList.map((day) {
            return ListTile(
              onTap: () {
                context.pushNamed(
                  Routes.dailyDetail,
                  pathParameters: {'date': day.date},
                );
              },
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat(
                            'MMMM d',
                            context.locale.toString(),
                          ).format(DateTime.parse(day.date)),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        child: Image.network(
                          '${Config.imageUrl}${day.icon}@2x.png',
                          width: 50,
                          height: 50,
                          errorBuilder: (_, __, ___) => const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${'Min'.tr()}: ${day.tempMin.toStringAsFixed(1)}${isCelsius ? '°C' : '°F'} ",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${'Max'.tr()}: ${day.tempMax.toStringAsFixed(1)}${isCelsius ? '°C' : '°F'}",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
