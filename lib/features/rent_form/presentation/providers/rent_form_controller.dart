import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/consts/rent_period_types.dart';
import 'package:motorent_cons/extensions/string_extension.dart';
import 'package:motorent_cons/features/auth/domain/models/submission_status_state.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';
import 'package:motorent_cons/features/home/domain/entities/rental_detail_model.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/features/rent_form/data/models/rental_transaction_dto.dart';
import 'package:motorent_cons/features/rent_form/domain/models/rent_form_state.dart';
import 'package:motorent_cons/features/rent_form/domain/repositories/rent_form_repository.dart';

final rentFormProvider = StateNotifierProvider<RentFormNotifier, RentFormState>(
  (ref) {
    final user = ref.watch(authUserProfileProvider);

    return RentFormNotifier(
      rentalDetail: ref.watch(selectedRentalDetailProvider)!,
      repository: ref.read(rentFormRepositoryProvider),
      userId: user.id,
    );
  },
);

class RentFormNotifier extends StateNotifier<RentFormState> {
  RentFormNotifier({
    required this.rentalDetail,
    required this.repository,
    required this.userId,
  }) : super(RentFormState());

  final RentFormRepository repository;
  final RentalDetail rentalDetail;
  final String userId;

  void setAddress(String value) {
    state = state.copyWith(address: value);
  }

  void setStartDateTime(DateTime value) {
    final endTime = value.add(Duration(days: rentalDetail.durationInDays));

    state = state.copyWith(startDateTime: value, endDateTime: endTime);
  }

  bool validate() {
    return state.address.isNotNullAndNotEmpty &&
        state.startDateTime != null &&
        state.endDateTime != null;
  }

  Future<void> submitRentForm() async {
    state = state.copyWith(submissionStatus: SubmissionStatus.loading);

    try {
      final data = RentalTransactionData(
        userId: userId,
        startDate: state.startDateTime,
        endDate: state.endDateTime,
        durationInDays: rentalDetail.durationInDays.toString(),
        totalPrice: rentalDetail.price,
        addressDetail: state.address,
      );

      final result = await repository.submitRent(data);

      result.fold(
        (l) {
          state = state.copyWith(
            submissionStatus: SubmissionStatus.failure,
            submissionErrorMessage: l.toString(),
          );
        },
        (r) {
          state = state.copyWith(submissionStatus: SubmissionStatus.success);
        },
      );
    } catch (e) {
      state = state.copyWith(
        submissionStatus: SubmissionStatus.failure,
        submissionErrorMessage: e.toString(),
      );
    }
  }
}
