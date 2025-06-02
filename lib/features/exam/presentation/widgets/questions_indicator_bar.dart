import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

class QuestionsIndicatorBar extends StatefulWidget
    implements PreferredSizeWidget {
  final int index;
  final int listLength;

  const QuestionsIndicatorBar({
    super.key,
    required this.index,
    required this.listLength,
  });

  @override
  State<QuestionsIndicatorBar> createState() => _QuestionsIndicatorBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _QuestionsIndicatorBarState extends State<QuestionsIndicatorBar> {
  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    //generate list
    list = List.generate(
      widget.listLength,
      (index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 30,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GColors.fern,
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 20,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kOuterRadius),
                color: GColors.fern.withValues(alpha: 0.3),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant QuestionsIndicatorBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    //reset prev index
    list[oldWidget.index] = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 20,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kOuterRadius),
          color: GColors.fern.withValues(alpha: 0.3),
        ),
      ),
    );

    //update current index
    list[widget.index] = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 30,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kOuterRadius),
          color: GColors.fern,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: list,
      ),
    );
  }
}
