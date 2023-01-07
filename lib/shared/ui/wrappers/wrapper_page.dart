import 'dart:io';

import 'package:attendanceappadmin/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.scrollable = true,
    this.appBarHeight,
    this.hasPadding = true,
    this.statusBarColor,
    this.navigationBarColor,
  });

  final Widget child;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool scrollable;
  final double? appBarHeight;
  final bool hasPadding;
  final Color? statusBarColor;
  final Color? navigationBarColor;

  @override
  State<StatefulWidget> createState() => _WrapperPage();
}

class _WrapperPage extends State<WrapperPage> {
  Widget iOSChild(double padTop, double padBot) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
          top: padTop,
          bottom: padBot,
        ),
        width: MediaQuery.of(context).size.width,
        color: widget.backgroundColor,
        child: Column(
          children: <Widget>[
            widget.appBar ?? Container(),
            //
            Expanded(
              child: widget.scrollable
                  ? SingleChildScrollView(
                      padding: EdgeInsets.all(
                        widget.hasPadding ? AppTheme.defaultPadding : 0,
                      ),
                      child: _FullWidth(child: widget.child),
                    )
                  : _FullWidth(child: widget.child),
            ),
            //
            widget.bottomNavigationBar ?? Container(),
          ],
        ),
      ),
    );
  }

  Widget androidChild(double padTop, double padBot) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar != null
            ? PreferredSize(
                child: widget.appBar ?? Container(),
                preferredSize: Size.fromHeight(100),
              )
            : null,
        body: Container(
          padding: EdgeInsets.only(
            // top: padTop,
            bottom: padBot,
          ),
          width: MediaQuery.of(context).size.width,
          color: widget.backgroundColor,
          child: widget.scrollable
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(
                    widget.hasPadding ? AppTheme.defaultPadding : 0,
                  ),
                  child: _FullWidth(child: widget.child),
                )
              : _FullWidth(child: widget.child),
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double padTop = MediaQuery.of(context).padding.top;
    double padBot = MediaQuery.of(context).padding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.navTheme(
        statusBarColor: widget.statusBarColor,
        navigationBarColor: widget.navigationBarColor,
      ),
      child: androidChild(
        padTop,
        padBot,
      ),
      // child: SafeArea(
      //   top: false, //Platform.isIOS ? false : true,
      //   bottom: Platform.isIOS ? false : true,
      //   child: Platform.isIOS
      //       ? iOSChild(
      //           padTop,
      //           padBot,
      //         )
      //       : androidChild(
      //           padTop,
      //           padBot,
      //         ),
      // ),
    );
  }
}

class _DesktopScrollbar extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      controller: details.controller,
      thumbVisibility: true,
      child: child,
    );
  }
}

class _FullWidth extends StatelessWidget {
  const _FullWidth({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}
