import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
/// Product localization manager
final class AppLocalization extends EasyLocalization {
  /// ProductLocalization need to [child] for a wrap locale item
  AppLocalization({required super.child, super.key})
    : super(
        supportedLocales: _supportedItems,
        path: _translationPath,
        useOnlyLangCode: true,
      );

  static final List<Locale> _supportedItems = [
    Locales.tr.locale,
    Locales.en.locale,
    Locales.de.locale,
  ];

  static const String _translationPath = 'assets/language';

  /// Change project language by using [Locales]
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locales value,
  }) => context.setLocale(value.locale);
}

/// Project locale enum for operation and configuration
enum Locales {
  /// Turkish locale
  tr(Locale('tr', 'TR')),

  /// English locale
  en(Locale('en', 'US')),

  /// German locale
  de(Locale('de', 'DE'));

  /// Locale value
  final Locale locale;

  const Locales(this.locale);
}
