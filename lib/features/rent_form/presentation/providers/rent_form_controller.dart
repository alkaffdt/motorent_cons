import 'package:flutter_riverpod/flutter_riverpod.dart';

final rentFormProvider =
    StateNotifierProvider<RentFormController, AsyncValue<bool>>((ref) {
      return RentFormController();
    });

class RentFormController extends StateNotifier<AsyncValue<bool>> {
  RentFormController() : super(const AsyncValue.data(false));
}
