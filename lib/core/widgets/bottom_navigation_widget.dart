import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generated/source/assets/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_forecast_app/core/providers/router_provider.dart';
import 'package:weather_forecast_app/features/home/home_controller/home_provider.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(bottomNavigationControllerProvider);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      currentIndex: position,
      onTap: (value) => _onTap(value),
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(
          activeIcon: bottomItemIcon(Routes.current, 45),
          icon: bottomItemIcon(Routes.current, 35),
          label: Routes.current,
        ),
        BottomNavigationBarItem(
          activeIcon: bottomItemIcon(Routes.daily, 45),
          icon: bottomItemIcon(Routes.daily, 35),
          label: Routes.daily,
        ),
        BottomNavigationBarItem(
          activeIcon: bottomItemIcon(Routes.settings, 45),
          icon: bottomItemIcon(Routes.settings, 35),
          label: Routes.settings,
        ),
      ],
    );
  }

  void _onTap(int index) {
    ref.read(bottomNavigationControllerProvider.notifier).setPosition(index);

    switch (index) {
      case 0:
        context.go(Routes.current);
        break;
      case 1:
        context.go(Routes.daily);
        break;
      case 2:
        context.go(Routes.settings);
        break;
      default:
    }
  }

  bottomItemIcon(String route, double size) {
    Widget icon = Icon(Icons.cloud);
    switch (route) {
      case Routes.current:
        icon = Assets.images.currentWf.image(
          package: 'generated',
          height: size,
        );
      case Routes.daily:
        icon = Assets.images.weeklyWf.image(package: 'generated', height: size);

      case Routes.settings:
        icon = Assets.images.settingsWf.image(
          package: 'generated',
          height: size,
        );

      default:
        icon = Assets.images.currentWf.image(
          package: 'generated',
          height: size,
        );
    }

    return ClipRRect(borderRadius: BorderRadius.circular(4), child: icon);
  }
}
