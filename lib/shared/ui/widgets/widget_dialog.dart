import 'package:attendanceappadmin/themes/color.dart';
import 'package:flutter/material.dart';

class WidgetDialog extends StatefulWidget {
  const WidgetDialog({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.onOk,
    this.okOnly = false,
  });

  final String? title;
  final String? subtitle;
  final String? content;
  final VoidCallback? onOk;
  final bool okOnly;

  @override
  State<StatefulWidget> createState() => _WidgetDialog();
}

class _WidgetDialog extends State<WidgetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxHeight: 500,
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: MediaQuery.of(context).size.width - 64,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // header
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      //
                      if (widget.subtitle != null)
                        Text(
                          widget.subtitle ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                    //
                  ),
                ),
                //
                const Divider(),
                //
                // content
                SingleChildScrollView(
                  child: Text(
                    widget.content ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!widget.okOnly)
                        _AlerButtonItem(
                          text: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      _AlerButtonItem(
                        text: "OK",
                        onTap: () {
                          widget.onOk!();
                          Navigator.pop(context);
                        },
                      ),
                    ],
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

class _AlerButtonItem extends StatelessWidget {
  const _AlerButtonItem({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.tertiary,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
