import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/widgets/base_widget.dart';

class DailyWeatherScreen extends ConsumerWidget {
  const DailyWeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(childBody: Center(child: Text('daily')));
  }
}
