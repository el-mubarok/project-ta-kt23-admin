import 'package:attendanceappadmin/shared/ui/widgets/widget_tabbed_page_wrapper.dart';
import 'package:flutter/material.dart';

class PageTabScan extends StatefulWidget {
  const PageTabScan({super.key});

  @override
  State<StatefulWidget> createState() => _PageTabScan();
}

class _PageTabScan extends State<PageTabScan> {
  @override
  Widget build(BuildContext context) {
    return WidgetTabbedPageWrapper(
      child: Column(
        children: const <Widget>[
          Text("Scan"),
        ],
      ),
    );
  }
}
