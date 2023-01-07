import 'package:attendanceappadmin/shared/ui/widgets/widget_tabbed_page_wrapper.dart';
import 'package:flutter/material.dart';

class PageTabAccount extends StatefulWidget {
  const PageTabAccount({super.key});

  @override
  State<StatefulWidget> createState() => _PageTabAccount();
}

class _PageTabAccount extends State<PageTabAccount> {
  @override
  Widget build(BuildContext context) {
    return WidgetTabbedPageWrapper(
      child: Column(
        children: const <Widget>[
          Text("Account"),
        ],
      ),
    );
  }
}
