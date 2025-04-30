import 'package:flutter/material.dart';
import 'package:generated/source/assets/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:weather_forecast_app/core/providers/router_provider.dart';
import 'package:weather_forecast_app/core/widgets/base_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go(Routes.current);
    });
  }

  Future<void> getDeviceInfo() async {
    await DeviceUtility.instance.initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      childBody: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Assets.lottie.weatherSplash.lottie(
            package: 'generated',
            height: 200,
          ),
        ),
      ),
    );
  }
}
