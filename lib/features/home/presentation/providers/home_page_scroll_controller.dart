import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeScreenScrollControllerProvider =
    NotifierProvider<HomeScreenScrollController, ScrollController>(
      HomeScreenScrollController.new,
    );

class HomeScreenScrollController extends Notifier<ScrollController> {
  @override
  ScrollController build() {
    return ScrollController();
  }

  void scrollDown({int pixels = 75}) {
    // prevent scrolling if it's close to the bottom
    if (state.position.pixels >= state.position.maxScrollExtent - 50) return;

    state.animateTo(
      state.position.pixels + pixels,
      duration: const Duration(milliseconds: 800),
      curve: Curves.linear,
    );
  }

  void vScrollToTop() {
    state.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
