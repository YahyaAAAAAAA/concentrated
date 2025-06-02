import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/constants.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kListViewWidth),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: body,
          ),
        ),
      ),
    );
  }
}
