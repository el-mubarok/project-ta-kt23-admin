import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';

class AppTheme {
  static SystemUiOverlayStyle navTheme({
    Color? statusBarColor,
    Color? navigationBarColor,
  }) {
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? AppColors.primary,
      statusBarIconBrightness:
          (statusBarColor ?? AppColors.primary).computeLuminance() >= 0.5
              ? Brightness.dark
              : Brightness.light,
      systemNavigationBarColor: navigationBarColor ?? AppColors.primary,
      systemNavigationBarIconBrightness:
          (navigationBarColor ?? AppColors.primary).computeLuminance() >= 0.5
              ? Brightness.dark
              : Brightness.light,
    );
  }

  //
  static const double appBarHeight = 64;
  static const double defaultPadding = 16;
  static const double inputButtonRadius = 10;
  static const double inputHeight = 42;
  static const double buttonHeight = 48;
  static const double inputFontSize = 14;
  static const double buttonFontSize = 14;
  static const double inputPaddingHorizontal = 16;
  static const double inputPaddingVertical = 0;
  static const double buttonPaddingHorizontal = 0;
  static const double buttonPaddingVertical = 0;
  //
  static InputDecoration inputDecorDefault({
    required String hintText,
    VoidCallback? passwordToggle,
    bool isPassword = false,
    bool passwordVisibility = false,
    required double heightTolerance,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColors.black.withOpacity(0.5),
      ),
      suffixIcon: suffix ??
          (isPassword
              ? GestureDetector(
                  onTap: () {
                    passwordToggle!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: HeroIcon(
                      passwordVisibility ? HeroIcons.eyeSlash : HeroIcons.eye,
                      color: AppColors.black,
                    ),
                  ),
                )
              : null),
      suffixIconConstraints: suffix == null
          ? const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            )
          : null,
      contentPadding: EdgeInsets.symmetric(
        horizontal: inputPaddingHorizontal,
        vertical: inputPaddingVertical - heightTolerance,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      alignLabelWithHint: true,
      border: const OutlineInputBorder(),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputButtonRadius),
        borderSide: const BorderSide(
          color: AppColors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(inputButtonRadius),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),
      fillColor: AppColors.primary,
    );
  }

  //
  static Border fullBorder = Border.all(
    width: 1,
    color: AppColors.white,
  );
  static Border selectedBorder({
    bool top = false,
    bool right = false,
    bool bottom = false,
    bool left = false,
  }) {
    BorderSide property = BorderSide(
      width: 1,
      color: AppColors.white,
    );
    BorderSide none = BorderSide.none;
    return Border(
      top: top ? property : none,
      right: right ? property : none,
      bottom: bottom ? property : none,
      left: left ? property : none,
    );
  }

  //
  static const double rightPaneWidth = 350 + 16;
}
