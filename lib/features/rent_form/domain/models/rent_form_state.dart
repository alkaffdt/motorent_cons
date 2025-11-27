class RentFormState {
  final String address;
  final DateTime? startDateTime;
  final DateTime? endDateTime;

  RentFormState({this.address = "", this.startDateTime, this.endDateTime});

  RentFormState copyWith({
    String? address,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) {
    return RentFormState(
      address: address ?? this.address,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
    );
  }
}
