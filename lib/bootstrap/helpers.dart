import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/resources/themes/styles/color_styles.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Helpers
|--------------------------------------------------------------------------
| Add your helper methods here
|-------------------------------------------------------------------------- */

/// helper to find correct color from the [context].
class ThemeColor {
  static ColorStyles get(BuildContext context, {String? themeId}) =>
      nyColorStyle<ColorStyles>(context, themeId: themeId);

  static Color fromHex(String hexColor) => nyHexColor(hexColor);
}

String formatCurrency(double amount) {
  final formatCurrency = NumberFormat.currency(
    locale: 'vi_VN', // Vietnamese locale
    symbol: '₫', // VND symbol
    decimalDigits: 0, // No decimal places for VND
  );
  return formatCurrency.format(amount);
}
