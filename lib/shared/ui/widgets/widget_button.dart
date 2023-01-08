import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:attendanceappadmin/themes/themes.dart';
import 'package:heroicons/heroicons.dart';

class WidgetButton extends StatefulWidget {
  const WidgetButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isBigButton = false,
    this.width = double.infinity,
    this.color,
    this.suffixIcon,
    this.prefixIcon,
    this.isDisabled = false,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isBigButton;
  final double width;
  final Color? color;
  final HeroIcons? suffixIcon;
  final HeroIcons? prefixIcon;
  final bool isDisabled;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() => _WidgetButton();
}

class _WidgetButton extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: !widget.isBigButton ? AppTheme.buttonHeight : null,
      child: Material(
        color: !widget.isDisabled && !widget.isLoading
            ? (widget.color ?? AppColors.success)
            : (widget.color ?? AppColors.success).withOpacity(0.5),
        borderRadius: BorderRadius.circular(
          !widget.isBigButton ? AppTheme.inputButtonRadius : 64,
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          highlightColor: !widget.isDisabled && !widget.isLoading
              ? null
              : AppColors.transparent,
          splashFactory: !widget.isDisabled && !widget.isLoading
              ? null
              : NoSplash.splashFactory,
          onTap: () {
            if (!widget.isDisabled) {
              widget.onTap();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: !widget.isBigButton
                  ? AppTheme.buttonPaddingHorizontal
                  : AppTheme.defaultPadding,
              vertical: !widget.isBigButton
                  ? AppTheme.buttonPaddingVertical
                  : AppTheme.defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //
                if (widget.isLoading)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(
                          (widget.color ?? AppColors.success)
                                      .computeLuminance() >=
                                  0.5
                              ? AppColors.black
                              : AppColors.white,
                        ),
                      ),
                    ),
                  ),

                if (widget.prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: HeroIcon(
                      widget.prefixIcon ?? HeroIcons.academicCap,
                      color: (widget.color ?? AppColors.success)
                                  .computeLuminance() >=
                              0.5
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),

                Text(
                  widget.label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: (widget.color ?? AppColors.success)
                                .computeLuminance() >=
                            0.5
                        ? AppColors.black
                        : AppColors.white,
                    fontSize:
                        !widget.isBigButton ? AppTheme.buttonFontSize : 16,
                  ),
                ),
                //
                if (widget.suffixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: HeroIcon(
                      widget.suffixIcon ?? HeroIcons.academicCap,
                      color: (widget.color ?? AppColors.success)
                                  .computeLuminance() >=
                              0.5
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
