import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated/generated.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/loading_screen.dart';
import 'package:weather_forecast_app/core/widgets/units_switch_widget.dart';

class CurrentWeatherWidget extends ConsumerWidget {
  const CurrentWeatherWidget({super.key, required this.weather});
  final CurrentWeather weather;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isUnitCelsiusProvider);
    return Column(
      children: [
        Text(
          DateFormat('MMMM d, HH:mm').format(DateTime.now()),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Text(
          '${weather.cityName} ,${weather.country}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Image.network(
          '${Config.imageUrl}${weather.icon}@2x.png',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return LoadingScreen();
          },
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error);
          },
        ),
        Text(
          '${weather.temp} ${isCelsius ? '°C' : '°F'}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        Text(
          '${weather.mainWeather} - ${weather.description}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${'Max:'.tr()} ${weather.tempMax} ${isCelsius ? '°C' : '°F'}  - ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              '${'Min:'.tr()} ${weather.tempMin} ${isCelsius ? '°C' : '°F'}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${'Feels Like:'.tr()} ${weather.feelsLike} ${isCelsius ? '°C' : '°F'}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              Text(
                '${'Humidity:'.tr()} ${weather.humidity} %',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                (weather.visibility != null && weather.visibility != 0)
                    ? '${'Visibility:'.tr()} ${weather.visibility! * 0.001} km '
                    : '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              Text(
                '${'Wind:'.tr()} ${weather.windSpeed} ༄',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
