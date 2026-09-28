import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/constants/app_constants.dart';

enum ScreenType { mobile, tablet, desktop }

class ResponsiveUtils {
  ResponsiveUtils._();

  static ScreenType screenTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppConstants.tabletBreakpoint) return ScreenType.desktop;
    if (width >= AppConstants.mobileBreakpoint) return ScreenType.tablet;
    return ScreenType.mobile;
  }

  static bool isMobile(BuildContext context) =>
      screenTypeOf(context) == ScreenType.mobile;

  static bool isTablet(BuildContext context) =>
      screenTypeOf(context) == ScreenType.tablet;

  static bool isDesktop(BuildContext context) =>
      screenTypeOf(context) == ScreenType.desktop;

  static int gridCrossAxisCount(BuildContext context) {
    switch (screenTypeOf(context)) {
      case ScreenType.mobile:
        return AppConstants.gridCrossAxisCountMobile;
      case ScreenType.tablet:
        return AppConstants.gridCrossAxisCountTablet;
      case ScreenType.desktop:
        return AppConstants.gridCrossAxisCountDesktop;
    }
  }

  static double horizontalPadding(BuildContext context) {
    switch (screenTypeOf(context)) {
      case ScreenType.mobile:
        return 16;
      case ScreenType.tablet:
        return 32;
      case ScreenType.desktop:
        return 48;
    }
  }

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width > AppConstants.maxContentWidth
        ? AppConstants.maxContentWidth
        : width;
  }

  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (screenTypeOf(context)) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
