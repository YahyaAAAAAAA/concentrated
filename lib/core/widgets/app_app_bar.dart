import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_bar_button.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onOwnerButtonTap;
  final void Function()? onChatsPressed;
  final void Function()? onPressed;
  final String title;
  final bool isOwner;
  final PreferredSize? bottom;

  const AppAppBar({
    super.key,
    required this.isOwner,
    this.onPressed,
    this.title = '       ',
    this.onOwnerButtonTap,
    this.onChatsPressed,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: MediaQuery.of(context).size.width >= 300
              ? Row(
                  children: [
                    Image.asset(
                      'assets/images/wide_logo.png',
                      fit: BoxFit.contain,
                      width: 130,
                      height: 100,
                    ),
                    const Spacer(),
                    isOwner
                        ? AppBarButton(
                            onPressed: onOwnerButtonTap,
                            icon: Icons.person_4_outlined,
                            iconSize: kSmallIconSize + 5,
                            iconColor: GColors.white,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(GColors.fern),
                            ),
                          )
                        : 0.width,
                    isOwner ? 5.width : 0.width,
                    onChatsPressed != null
                        ? AppBarButton(
                            onPressed: onChatsPressed,
                            icon: Icons.message_outlined,
                            iconSize: kSmallIconSize + 3,
                          )
                        : 0.width,
                    5.width,
                    AppBarButton(
                      onPressed: null,
                      icon: Icons.more_vert,
                      iconColor: GColors.black,
                      iconSize: kSmallIconSize,
                    ),
                    5.width,
                  ],
                )
              : 0.width,
          toolbarHeight: 70,
          bottom: bottom,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}
