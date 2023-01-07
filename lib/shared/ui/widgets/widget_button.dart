import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:attendanceappadmin/themes/themes.dart';

class WidgetButton extends StatefulWidget {
  const WidgetButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isBigButton = false,
    this.width = double.infinity,
    this.color,
  });

  final String label;
  final VoidCallback onTap;
  final bool isBigButton;
  final double width;
  final Color? color;

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
        color: widget.color ?? AppColors.success,
        borderRadius: BorderRadius.circular(
          !widget.isBigButton ? AppTheme.inputButtonRadius : 64,
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            widget.onTap();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
