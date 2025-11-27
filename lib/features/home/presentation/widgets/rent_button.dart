import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseButton extends ConsumerWidget {
  final bool isVisible;
  final VoidCallback onPressed;

  const PurchaseButton({
    super.key,
    required this.isVisible,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        offset: isVisible ? Offset(0, 0) : Offset(0, 1.0),

        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isVisible ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text("Let's rent"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
