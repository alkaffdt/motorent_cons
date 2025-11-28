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

  void scrollDown({int pixels = 100}) {
    state.animateTo(
      state.position.pixels + pixels,
      duration: const Duration(milliseconds: 500),
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
