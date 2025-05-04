import 'package:flutter/material.dart';
import 'package:pokedex/features/shared/presentation/widgets/custom_toast.dart';

class ToastUtils {
  static void showCustomToast(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.green,
    IconData icon = Icons.check,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: CustomToast(
            message: message,
            backgroundColor: backgroundColor,
            icon: icon,
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
