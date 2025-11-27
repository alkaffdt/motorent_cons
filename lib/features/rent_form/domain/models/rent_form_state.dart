import 'package:motorent_cons/features/auth/domain/models/submission_status_state.dart';

class RentFormState {
  final SubmissionStatus submissionStatus;
  final String? submissionErrorMessage;
  final String address;
  final DateTime? startDateTime;
  final DateTime? endDateTime;

  RentFormState({
    this.submissionStatus = SubmissionStatus.initial,
    this.address = "",
    this.startDateTime,
    this.submissionErrorMessage,
    this.endDateTime,
  });

  RentFormState copyWith({
    String? address,
    DateTime? startDateTime,
    DateTime? endDateTime,
    SubmissionStatus? submissionStatus,
    String? submissionErrorMessage,
  }) {
    return RentFormState(
      address: address ?? this.address,
      submissionErrorMessage:
          submissionErrorMessage ?? this.submissionErrorMessage,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }
}
