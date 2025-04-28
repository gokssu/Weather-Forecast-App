import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  final brightness = View.of(context).platformDispatcher.platformBrightness;
  final baseTextTheme =
      brightness == Brightness.light ? lightTextTheme : darkTextTheme;
  final bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  final displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  final textTheme = displayTextTheme.copyWith(
    titleLarge: bodyTextTheme.titleLarge,
    titleMedium: bodyTextTheme.titleMedium,
    titleSmall: bodyTextTheme.titleSmall,
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
    headlineLarge: bodyTextTheme.headlineLarge,
    headlineMedium: bodyTextTheme.headlineMedium,
    headlineSmall: bodyTextTheme.headlineSmall,
  );
  return textTheme;
}

const defaultTextSize = 14.0;

final lightTextTheme = ThemeData.light().textTheme.copyWith(
  headlineLarge: const TextStyle(
    fontSize: defaultTextSize * 2,
    fontWeight: FontWeight.w600,
  ),
  titleLarge: const TextStyle(
    fontSize: defaultTextSize * 1.3,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: const TextStyle(
    fontSize: defaultTextSize,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: const TextStyle(
    fontSize: defaultTextSize - 2,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: const TextStyle(
    fontSize: defaultTextSize,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: const TextStyle(
    fontSize: defaultTextSize - 2,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: const TextStyle(
    fontSize: defaultTextSize,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: const TextStyle(
    fontSize: defaultTextSize - 2,
    fontWeight: FontWeight.w500,
  ),
);

final darkTextTheme = ThemeData.dark().textTheme.copyWith(
  headlineLarge: const TextStyle(
    fontSize: defaultTextSize * 2,
    fontWeight: FontWeight.w600,
  ),
  titleLarge: const TextStyle(
    fontSize: defaultTextSize * 1.3,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: const TextStyle(
    fontSize: defaultTextSize,
    height: 1.5,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: const TextStyle(
    fontSize: defaultTextSize - 2,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: const TextStyle(
    fontSize: defaultTextSize,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: const TextStyle(
    fontSize: defaultTextSize - 2,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: const TextStyle(
    fontSize: defaultTextSize,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: const TextStyle(
    fontSize: defaultTextSize - 2,
    fontWeight: FontWeight.w500,
  ),
);
