import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: GColors.fern,
      ),
    );
  }
}
