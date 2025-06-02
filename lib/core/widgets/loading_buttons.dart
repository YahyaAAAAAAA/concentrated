import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tweleve_ace/core/widgets/row_button.dart';

//quick loading for pages that display RowButtons
class LoadingButtons extends StatelessWidget {
  const LoadingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: List.generate(
          5,
          (index) => Skeletonizer(
              enabled: true,
              child: RowButton(text: 'Dummy', icon: Icons.check))),
    );
  }
}
