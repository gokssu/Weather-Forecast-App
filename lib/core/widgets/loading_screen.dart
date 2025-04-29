import 'package:flutter/material.dart';
import 'package:generated/source/assets/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/widgets/base_widget.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget(
      childBody: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Assets.lottie.weatherLoading.lottie(
            package: 'generated',
            height: 200,
          ),
        ),
      ),
    );
  }
}
