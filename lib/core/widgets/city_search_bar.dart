import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_forecast_app/core/utils/config.dart';
import 'package:weather_forecast_app/features/currently_weather/current_weather_controller/current_weather_provider.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:weather_forecast_app/features/daily_weather/daily_weather_controller/daily_weather_provider.dart';

final selectedCityProvider = StateProvider<String>((ref) => '');

class CitySearchBar extends HookConsumerWidget {
  const CitySearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityName = ref.watch(selectedCityProvider);
    final controller = useTextEditingController(text: cityName);
    void search(String? query, String lat, String long) {
      if (query != null &&
          query.isNotEmpty &&
          lat.isNotEmpty &&
          long.isNotEmpty) {
        ref.read(selectedCityProvider.notifier).state = query;
        ref.watch(getCurrentProvider(context.locale.languageCode));
        ref.watch(getOneDayProvider(context.locale.languageCode));
      }
    }

    placesAutoCompleteTextField() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: Config.apiKeyGooglePlace,
          inputDecoration: InputDecoration(
            hintText: 'Search city'.tr(),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          debounceTime: 400,
          countries: ["US", "DE", "TR"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            FocusScope.of(context).unfocus();
            search(
              prediction.description ?? "",
              prediction.lat ?? '',
              prediction.lng ?? '',
            );
            if (kDebugMode) {
              debugPrint("placeDetails${prediction.description}");
            }
          },
          itemClick: (Prediction prediction) {
            controller.text = prediction.description ?? "";
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0),
            );
            FocusScope.of(context).unfocus();
          },
          seperatedBuilder: Divider(),
          containerHorizontalPadding: 10,

          // OPTIONAL// If you want to customize list view item builder
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 7),
                  Expanded(child: Text(prediction.description ?? "")),
                ],
              ),
            );
          },
          isCrossBtnShown: true,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[SizedBox(height: 20), placesAutoCompleteTextField()],
    );
  }
}
