import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated/generated.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/loading_screen.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/current_weather_provider.dart';

class CurrentWeatherWidget extends StatefulHookConsumerWidget {
  const CurrentWeatherWidget({super.key, required this.weather});
  final CurrentWeather weather;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends ConsumerState<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
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
          '${widget.weather.cityName} ,${widget.weather.country}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Image.network(
          '${Config.imageUrl}${widget.weather.icon}@2x.png',
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
          '${widget.weather.temp} ${isCelsius ? '°C' : '°F'}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        Text(
          '${widget.weather.mainWeather} - ${widget.weather.description}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${'Max:'.tr()} ${widget.weather.tempMax} ${isCelsius ? '°C' : '°F'}  - ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              '${'Min:'.tr()} ${widget.weather.tempMin} ${isCelsius ? '°C' : '°F'}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '${'Feels Like:'.tr()} ${widget.weather.feelsLike} ${isCelsius ? '°C' : '°F'}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '${'Humidity:'.tr()} ${widget.weather.humidity} %',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        if (widget.weather.visibility != null && widget.weather.visibility != 0)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${'Visibility:'.tr()} ${widget.weather.visibility! * 0.001} km ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '${'Wind:'.tr()} ${widget.weather.windSpeed} ༄',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
