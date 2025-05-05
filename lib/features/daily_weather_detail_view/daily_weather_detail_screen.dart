import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/core/widgets/index.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';

class DailyWeatherDetailScreen extends HookConsumerWidget {
  final String date;
  const DailyWeatherDetailScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isUnitCelsiusProvider);
    final dailyWeatherAsync = ref.watch(
      get7DayProvider(context.locale.languageCode),
    );

    return dailyWeatherAsync.when(
      data:
          (
            either,
          ) => either.fold((failure) => ErrorHandlingScreen(failure: failure), (
            weeklyWeather,
          ) {
            final dayHours =
                weeklyWeather.list
                    .where(
                      (day) =>
                          day.dtTxt != null &&
                          DateFormat(
                                'yyyy-MM-dd',
                              ).format(DateTime.parse(day.dtTxt!)) ==
                              date,
                    )
                    .toList();

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
                        _headerText(context, 'Time', flex: 2),
                        const Expanded(flex: 2, child: SizedBox()),
                        _headerText(context, 'Temp', flex: 2),
                        _headerText(
                          context,
                          'Feels Like',
                          flex: 3,
                          align: TextAlign.end,
                        ),
                        _headerText(context, 'Humidity', flex: 3),
                        _headerText(context, 'Wind', flex: 2),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder:
                          (_, __) => const Divider(thickness: 0.7),
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
                              _cellText(time, context),
                              Expanded(
                                child: CircleAvatar(
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
                              ),
                              _cellText(
                                '${item.temp.toStringAsFixed(1)}${isCelsius ? '°C' : '°F'}',
                                context,
                              ),
                              _cellText(
                                '${item.feelsLike.toStringAsFixed(1)}${isCelsius ? '°C' : '°F'}',
                                context,
                              ),
                              _cellText('${item.humidity}%', context),
                              _cellText(
                                '${item.windSpeed.toStringAsFixed(1)} ༄',
                                context,
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
          }),
      error:
          (e, st) => BaseWidget(
            appBar: AppBar(title: const Text('Daily Detail')),
            childBody: Center(child: Text('Weather could not be loaded'.tr())),
          ),
      loading: () => const LoadingScreen(),
    );
  }

  Widget _headerText(
    BuildContext context,
    String text, {
    required int flex,
    TextAlign align = TextAlign.center,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text.tr(),
        textAlign: align,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }

  Widget _cellText(String text, BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
