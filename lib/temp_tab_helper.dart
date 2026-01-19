import 'package:flutter/material.dart';
import 'package:nextupp/core/theme/app_theme.dart';

Widget buildUnclippedTab({
  required BuildContext context,
  required String label,
  required int index,
  required TabController tabController,
}) {
  final isSelected = tabController.index == index;
  return InkResponse(
    onTap: () {
      tabController.animateTo(index);
    },
    containedInkWell: false, // Allows splash to overflow
    radius: 60, // Large radius for expansive effect
    splashFactory: InkSparkle.splashFactory, // Sparkle/Purpurina effect
    highlightColor: Colors.transparent,
    splashColor: AppTheme.accent.withOpacity(0.3),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppTheme.accent : Colors.white60,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    ),
  );
}
