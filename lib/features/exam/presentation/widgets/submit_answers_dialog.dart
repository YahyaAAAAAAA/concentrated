import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';

class SubmitAnswersDialog extends StatelessWidget {
  final void Function()? onSubmitPressed;
  final void Function()? onCancelPressed;

  const SubmitAnswersDialog({
    super.key,
    this.onCancelPressed,
    this.onSubmitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 40,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Are you done answering ?')
                  .secondary(fontWeight: FontWeight.bold),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              TrinaryButton(
                text: 'Not Yes',
                onPressed: onCancelPressed,
              ),
              PrimaryButton(
                text: 'Finish Exam',
                onPressed: onSubmitPressed,
              ),
            ],
          )
        ],
      ),
    );
  }
}
