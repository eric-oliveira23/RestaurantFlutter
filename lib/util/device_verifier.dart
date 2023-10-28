import 'package:flutter/material.dart';

class DeviceVerifier {
  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDeviceSmall(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    const maxWidth = 350.0;

    return screenSize.width < maxWidth;
  }

  static double responsiveFontSize(BuildContext context) {
    if (isDeviceSmall(context)) {
      return 13;
    } else if (isPhone(context)) {
      return 17;
    } else if (isTablet(context)) {
      return 23;
    }
    return 23;
  }

  static double responsiveFontSizeSmall(BuildContext context) {
    if (isDeviceSmall(context)) {
      return 10;
    }

    return 15;
  }

  static double responsiveFontSizeBig(BuildContext context) {
    if (isDeviceSmall(context)) {
      return 16;
    } else if (isPhone(context)) {
      return 19;
    } else if (isTablet(context)) {
      return 26;
    }
    return 15;
  }
}
