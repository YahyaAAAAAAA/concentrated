import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/color_extensions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_image.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';

class HomeCard extends StatelessWidget {
  final String url;
  final Color backgroundColor;
  final Color buttonColor;
  final void Function()? onPressed;
  final bool isFlipped;

  const HomeCard({
    super.key,
    required this.url,
    required this.backgroundColor,
    required this.buttonColor,
    required this.isFlipped,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isFlipped ? buildFlipped() : buildNormal();
  }

  InkWell buildFlipped() {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(kOuterRadius),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kOuterRadius),
          border: Border.all(
            color: GColors.sand,
            width: 1,
          ),
          color: backgroundColor,
          gradient: LinearGradient(
            colors: [
              backgroundColor.shade300,
              backgroundColor,
              backgroundColor.shade600,
              backgroundColor.shade600,
            ],
          ),
        ),
        padding: EdgeInsets.all(4),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -10,
              child: AppImage(
                width: 200,
                height: 200,
                url: url,
              ),
            ),
            Positioned(
              left: 5,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('University Exams').primary(),
                  Text('Computer Science').secondary(),
                ],
              ),
            ),
            Positioned(
              left: 5,
              bottom: 5,
              child: PrimaryButton(
                onPressed: onPressed,
                text: 'Start Now',
                textSize: kSmallFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildNormal() {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(kOuterRadius),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: GColors.fern,
          borderRadius: BorderRadius.circular(kOuterRadius),
          gradient: LinearGradient(
            colors: [
              backgroundColor.shade600,
              backgroundColor,
              backgroundColor,
              backgroundColor.shade300,
            ],
          ),
        ),
        padding: EdgeInsets.all(4),
        child: Stack(
          children: [
            Positioned(
              left: -40,
              top: -10,
              child: AppImage(
                width: 200,
                height: 200,
                url: url,
              ),
            ),
            Positioned(
              right: 50,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tawjihi Exams').primaryOnSurface(),
                  Text('Shared Subjects').secondaryOnSurface(),
                ],
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: TrinaryButton(
                onPressed: onPressed,
                text: 'Start Now',
                hasBorder: false,
                textSize: kSmallFontSize,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(buttonColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
