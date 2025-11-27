import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/rent_form/data/models/rent_submit_dto.dart';
import 'package:motorent_cons/features/rent_form/domain/models/rent_form_state.dart';

final rentFormProvider = StateNotifierProvider<RentFormNotifier, RentFormState>(
  (ref) => RentFormNotifier(),
);

class RentFormNotifier extends StateNotifier<RentFormState> {
  RentFormNotifier() : super(RentFormState());

  void setAddress(String value) {
    state = state.copyWith(address: value);
  }

  void setStartDateTime(DateTime value) {
    state = state.copyWith(startDateTime: value);
  }

  void setEndDateTime(DateTime value) {
    state = state.copyWith(endDateTime: value);
  }
}
