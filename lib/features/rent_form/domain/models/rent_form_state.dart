class RentFormState {
  final String address;
  final String startTime;
  final String endTime;

  RentFormState({
    required this.address,
    required this.startTime,
    required this.endTime,
  });

  RentFormState copyWith({
    String? address,
    String? startTime,
    String? endTime,
  }) {
    return RentFormState(
      address: address ?? this.address,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
