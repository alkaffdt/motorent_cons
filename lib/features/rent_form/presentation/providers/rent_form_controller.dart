import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/consts/rent_period_types.dart';
import 'package:motorent_cons/extensions/string_extension.dart';
import 'package:motorent_cons/features/home/domain/entities/rental_detail_model.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/features/rent_form/domain/models/rent_form_state.dart';

final rentFormProvider = StateNotifierProvider<RentFormNotifier, RentFormState>(
  (ref) {
    return RentFormNotifier(
      rentalDetail: ref.watch(selectedRentalDetailProvider)!,
    );
  },
);

class RentFormNotifier extends StateNotifier<RentFormState> {
  RentFormNotifier({required this.rentalDetail}) : super(RentFormState());

  final RentalDetail rentalDetail;

  void setAddress(String value) {
    state = state.copyWith(address: value);
  }

  void setStartDateTime(DateTime value) {
    final int rentalDurationInDays;

    switch (rentalDetail.periodType) {
      case RentPeriodTypes.daily:
        rentalDurationInDays = 1;
        break;
      case RentPeriodTypes.weekly:
        rentalDurationInDays = 7;
        break;
      case RentPeriodTypes.monthly:
        rentalDurationInDays = 30;
        break;
      default:
        rentalDurationInDays = 1;
    }

    final endTime = value.add(Duration(days: rentalDurationInDays));

    state = state.copyWith(startDateTime: value, endDateTime: endTime);
  }

  bool validate() {
    return state.address.isNotNullAndNotEmpty &&
        state.startDateTime != null &&
        state.endDateTime != null;
  }
}
