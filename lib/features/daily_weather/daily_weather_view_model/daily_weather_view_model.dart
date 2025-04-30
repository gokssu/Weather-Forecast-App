import 'package:easy_localization/easy_localization.dart';
import 'package:generated/generated.dart';

class DailyWeatherViewModel {
  final String date;
  final double tempMin;
  final double tempMax;
  final String icon;
  final String description;
  DailyWeatherViewModel({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.icon,
    required this.description,
  });

  static List<DailyWeatherViewModel> parseDailyWeather(
    List<HourlyWeather> hourlyList,
  ) {
    final Map<String, List<HourlyWeather>> groupedByDate = {};

    for (final item in hourlyList) {
      final dateTime =
          item.dtTxt != null ? DateTime.parse(item.dtTxt!) : DateTime.now();
      final dateKey = DateFormat('yyyy-MM-dd').format(dateTime);
      groupedByDate.putIfAbsent(dateKey, () => []).add(item);
    }

    final dailyList = <DailyWeatherViewModel>[];

    groupedByDate.forEach((date, entries) {
      final minTemp = entries
          .map((e) => e.tempMin as num)
          .reduce((a, b) => a < b ? a : b);
      final maxTemp = entries
          .map((e) => e.tempMax as num)
          .reduce((a, b) => a > b ? a : b);
      final firstWeather = entries.first;

      dailyList.add(
        DailyWeatherViewModel(
          date: date,
          tempMin: minTemp.toDouble(),
          tempMax: maxTemp.toDouble(),
          icon: firstWeather.icon,
          description: firstWeather.description,
        ),
      );
    });

    return dailyList;
  }
}
