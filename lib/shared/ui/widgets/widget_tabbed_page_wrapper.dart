import 'package:attendanceappadmin/shared/ui/wrappers/wrapper_page.dart';
import 'package:flutter/material.dart';

class WidgetTabbedPageWrapper extends StatelessWidget {
  const WidgetTabbedPageWrapper({
    super.key,
    required this.child,
    this.scrollable = true,
    this.bottomBar,
    this.appBar,
    this.background,
  });

  final Widget child;
  final bool scrollable;
  final Widget? bottomBar;
  final PreferredSizeWidget? appBar;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      backgroundColor: background,
      appBar: appBar,
      bottomNavigationBar: bottomBar,
      scrollable: false,
      child: child,
    );
  }
}
