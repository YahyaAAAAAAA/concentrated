import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/config/routes.dart';
import 'package:tweleve_ace/core/extensions/color_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

extension BuildContextExtension on BuildContext {
  //goPage,pushPage as replacement of push and go
  void goPage(AppPage page, {Map<String, String>? pathParams}) {
    String path = page.path;
    pathParams?.forEach((key, value) {
      path = path.replaceAll(':$key', value);
    });
    go(path);
  }

  void pushPage(
    AppPage page, {
    Map<String, String>? pathParams,
    Map<String, String>? queryParams,
  }) {
    String path = page.path;
    pathParams?.forEach((key, value) {
      path = path.replaceAll(':$key', value);
    });

    if (queryParams != null && queryParams.isNotEmpty) {
      final uri = Uri(path: path, queryParameters: queryParams);
      path = uri.toString();
    }

    push(path);
  }

  void cpush(
    Widget child, {
    Duration? duration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
  }) {
    //transitions moved to theme data
    //check any commit before "venue edit 95% done" commit for custom transitions
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => child));
  }

  void creplace(
    Widget child, {
    Duration? duration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
  }) {
    Navigator.of(this).pushReplacement(
      PageRouteBuilder(
        transitionDuration: duration ?? const Duration(milliseconds: 500),
        reverseTransitionDuration:
            duration ?? const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: transitionBuilder ?? TransitionAnimations.fade,
      ),
    );
  }

  void cpop() {
    Navigator.of(this).pop();
  }

  // Show a basic SnackBar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Colors.black,
                size: kSmallIconSize,
              ),
              Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: kSmallFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: GColors.fern.shade100.withValues(alpha: 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kOuterRadius),
            topRight: Radius.circular(kOuterRadius),
          ),
        ),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  //animated dialog
  Future<Object?> dialog({
    required Widget Function(BuildContext, Animation<double>, Animation<double>)
        pageBuilder,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    bool? barrierDismissible,
    Duration? transitionDuration,
  }) async {
    return showGeneralDialog(
      context: this,
      pageBuilder: pageBuilder,
      barrierLabel: '',
      barrierDismissible: barrierDismissible ?? true,
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 200),
      transitionBuilder:
          transitionBuilder ?? TransitionAnimations.slideFromBottom,
    );
  }
}

class TransitionAnimations {
  //slide transition from the right
  static Widget slideFromRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  //slide transition from the left
  static Widget slideFromLeft(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  //slide transition from the bottom
  static Widget slideFromBottom(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  //slide transition from the top
  static Widget slideFromTop(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  //fade transition
  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(begin: 0.0, end: 1.0);
    final fadeAnimation = animation.drive(tween);

    return FadeTransition(opacity: fadeAnimation, child: child);
  }

  //scale transition
  static Widget scale(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(begin: 0.0, end: 1.0);
    final scaleAnimation = animation.drive(tween);

    return ScaleTransition(scale: scaleAnimation, child: child);
  }
}
