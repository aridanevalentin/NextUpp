import 'dart:ui';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSuccess(BuildContext context, String message) {
    _showGlassSnackBar(
      context,
      message,
      color: Colors.green.withOpacity(0.4),
      icon: Icons.check_circle_outline,
    );
  }

  static void showPending(BuildContext context, String message) {
    _showGlassSnackBar(
      context,
      message,
      color: Colors.blueAccent.withOpacity(0.4),
      icon: Icons.access_time_filled,
    );
  }

  static void showDestructive(BuildContext context, String message) {
    _showGlassSnackBar(
      context,
      message,
      color: Colors.redAccent.withOpacity(0.4),
      icon: Icons.delete_outline,
    );
  }

  static void showError(BuildContext context, String message) {
    _showGlassSnackBar(
      context,
      message,
      color: Colors.red.withOpacity(0.4),
      icon: Icons.error_outline,
    );
  }

  static void _showGlassSnackBar(
    BuildContext context,
    String message, {
    required Color color,
    required IconData icon,
  }) {
    // Remove current snackbar to update instantly
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: color,
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
