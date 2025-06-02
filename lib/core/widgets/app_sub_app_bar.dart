import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_bar_button.dart';

class AppSubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onPressed;
  final void Function()? onBack;
  final String title;
  final PreferredSize? bottom;
  final Color? backgroundColor;

  const AppSubAppBar({
    super.key,
    this.onPressed,
    this.title = '       ',
    this.bottom,
    this.backgroundColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: backgroundColor ?? Colors.transparent,
          centerTitle: true,
          leading: 0.width,
          title: MediaQuery.of(context).size.width >= 300
              ? Row(
                  children: [
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppBarButton(
                          onPressed: onBack ?? () => context.pop(),
                          icon: Icons.arrow_back_ios_new_rounded,
                          iconSize: kSmallIconSize,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kNormalFontSize,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    AppBarButton(
                      onPressed: onPressed,
                      icon: Icons.more_vert,
                      iconColor: GColors.black,
                      iconSize: kSmallIconSize,
                    ),
                    5.width,
                  ],
                )
              : 0.width,
          toolbarHeight: 70,
          leadingWidth: 0,
          bottom: bottom,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}
